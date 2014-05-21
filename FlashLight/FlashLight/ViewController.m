//
//  ViewController.m
//  FlashLight
//
//  Created by 野田 潤平 on 2014/05/21.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *lightSwitch;
@property (weak, nonatomic) IBOutlet UISlider *brightnessSlider;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [self becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// ファーストレスポンダとして設定
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

// ライトの制御
- (void)configureLight
{
    NSError *error = nil;
    
    // ビデオデバイスを取得
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 各コントローラから値を取得
    BOOL isOn = self.lightSwitch.isOn;
    float level = self.brightnessSlider.value;
    
    // トーチを持ったデバイスが正しく取得できれいれば
    if (device && device.hasTorch) {
        // デバイスをロック
        [device lockForConfiguration:&error];
        
        // 明るさが0より大きく、スイッチがONになっていれば
        if (level > 0.0f && isOn) {
            // トーチの明るさを設定
            [device setTorchModeOnWithLevel:level error:&error];
        }
        else {
            // トーチをオフに
            device.torchMode = AVCaptureTorchModeOff;
        }
        
        // ロックの解除
        [device unlockForConfiguration];
    }
}
// UISliderイベント
- (IBAction)performLightSwitchAction:(id)sender {
    // ライトの制御
    [self configureLight];
}
// UISwitchイベント
- (IBAction)performBrightnessSliderAction:(id)sender {
    // ライトの制御
    [self configureLight];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    // シェイクジェスチャを認識したとき
    if (motion == UIEventSubtypeMotionShake) {
        // スイッチのON/OFFを切り替え
        [self.lightSwitch setOn:!self.lightSwitch.isOn animated:YES];
        
        // ライトの制御
        [self configureLight];
    }
}
@end
