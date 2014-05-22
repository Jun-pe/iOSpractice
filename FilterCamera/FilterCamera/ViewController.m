//
//  ViewController.m
//  FilterCamera
//
//  Created by 野田 潤平 on 2014/05/22.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import "ViewController.h"
#import "CameraManager.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet GPUImageView *cameraView;

@end

@implementation ViewController

#pragma mark - View LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[CameraManager sharedManager] startCamera:(GPUImageView *)self.cameraView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // ファインダー画面をViewいっぱいに広げる
    self.cameraView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;
}
// 戻るボタン押下時
- (IBAction)performPreviousButtonAction:(id)sender {
    // 前のフィルタに変更
    [[CameraManager sharedManager]setPreviousFilter:self.cameraView];
}
// 次へボタン押下時
- (IBAction)performNextButtonAction:(id)sender {
    // 次のフィルタに変更
    [[CameraManager sharedManager]setNextFilter:self.cameraView];
}
// 撮影ボタン押下時
- (IBAction)performShutterButtonAction:(id)sender {
    // 写真を撮影
    [[CameraManager sharedManager] takePhoto];
}
// カメラ切り替えボタン押下時
- (IBAction)performSwitchCameraButtonAction:(id)sender {
    [[CameraManager sharedManager] switchCameraPosition:self.cameraView];
}

@end
