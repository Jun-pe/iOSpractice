//
//  CameraManager.m
//  SilentCamera
//
//  Created by 野田 潤平 on 2014/05/21.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import "CameraManager.h"

// シャッターが押されてから撮影するまでの時間（秒）
#define kTimerIntarval 5.0f

@interface CameraManager()

@property(nonatomic, strong) AVCaptureSession *session;
@property(nonatomic, strong) NSTimer *timer;
@property(readwrite) BOOL takePhotoFlag;

@end

@implementation CameraManager

+ (instancetype)sharedManager
{
    static id manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self initializeCamera];
    }
    return self;
}

// カメラでバイスを初期化してセッション作成
- (void)initializeCamera
{
    NSError *error;
    
    // セッションを作成
    if (self.session) {
        [self.session stopRunning];
        self.session = nil;
    }
    self.session = [[AVCaptureSession alloc] init];
    
    // 入力デバイス
    AVCaptureDevice *captureDevice = nil;
    NSArray *devices = [AVCaptureDevice devices];
    
    // 前面カメラを見つける
    for (AVCaptureDevice *device in devices)
    {
        if (device.position == AVCaptureDevicePositionFront)
        {
            captureDevice = device;
        }
    }
    
    // カメラが見つからなかった場合
    if (captureDevice == nil) { return; }
    
    // デバイスからデバイス入力を得る
    AVCaptureDeviceInput *deviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:captureDevice error:&error];
    
    if (error) {
        // カメラの初期化に失敗
        return;
    }
    
    // 出力の作成
    AVCaptureVideoDataOutput *videoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
    [videoDataOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
    [videoDataOutput setVideoSettings:@{(id)kCVPixelBufferPixelFormatTypeKey : @(kCMPixelFormat_32BGRA)}];
    
    // セッション作成
    self.session = [[AVCaptureSession alloc] init];
    
    [self.session addInput:deviceInput];
    [self.session addOutput:videoDataOutput];
    
    [self.session startRunning];
}

// 撮影
- (void)takePhoto
{
    // すでにタイマーが作動中なら無視
    if (self.timer == nil)
    {
        // 一定時間の後メソッドを呼ぶ
        self.timer = [NSTimer scheduledTimerWithTimeInterval:kTimerIntarval target:self selector:@selector(changeTakePhotoFlag) userInfo:nil repeats:NO];
    }
}

// 撮影フラグを立てる
- (void)changeTakePhotoFlag
{
    // タイマーを削除
    [self.timer invalidate];
    self.timer = nil;
    
    // 撮影フラグを立てる
    self.takePhotoFlag = YES;
}

#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate

// サンプルバッファが書き込まれたとき
- (void)captureOutput:(AVCaptureOutput *)captureOutput didDropSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    // 撮影フラグが立っていれば
    if (self.takePhotoFlag)
    {
        // サンプルバッファからUIImageを取得
        UIImage *image = [self imageFromSampleBuffer:sampleBuffer];
        
        // UIImageをカメラロールへ保存
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingImageWithError:contextInfo:), nil);
        
        // 撮影フラグを無効に
        self.takePhotoFlag = NO;
    }
}

// カメラロールへの保存が完了したとき
- (void)image:(UIImage *)image didFinishSavingImageWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    // 何もしない
    // （通常のカメラアプリではエラーハンドリングをする）
}

// サンプルバッファからUIImageを作成
- (UIImage *)imageFromSampleBuffer:(CMSampleBufferRef)sampleBuffer
{
    // イメージバッファを崇徳
    CVImageBufferRef buffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    
    // イメージバッファをロック
    CVPixelBufferLockBaseAddress(buffer, 0);
    
    // イメージバッファから情報取得
    uint8_t *base = CVPixelBufferGetBaseAddress(buffer);
    size_t width = CVPixelBufferGetWidth(buffer);
    size_t height = CVPixelBufferGetHeight(buffer);
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(buffer);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(base, width, height, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    
    // CGImageからUIImageに変換
    UIImage *image = [UIImage imageWithCGImage:imageRef scale:1.0f orientation:UIImageOrientationRight];
    
    // 解放
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    CGContextRelease(context);
    
    // イメージバッファのアンロック
    CVPixelBufferUnlockBaseAddress(buffer, 0);
    
    return image;
}
@end
