//
//  LaunchVC.m
//  Obj-C-SimplePageChange
//
//  Created by 阿部 潤平 on 2014/07/04.
//  Copyright (c) 2014年 Self. All rights reserved.
//
#import "LaunchVC.h"

@implementation LaunchVC

// アクセサ
@synthesize delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    LaunchView *launchView = [[LaunchView alloc] initWithFrame: self.view.bounds];
    
    // LaunchViewのdelegateを設定
    launchView.delegate = self;
    
    [self.view addSubview:launchView];
}

// LaunchViewのdelegateから委譲された処理
- (void)changePage
{
    // delegateに処理を委譲する
    [self.delegate changePage];
}
@end