//
//  MainVC.m
//  Obj-C-SimplePageChange
//
//  Created by 阿部 潤平 on 2014/07/04.
//  Copyright (c) 2014年 Self. All rights reserved.
//
#import "MainVC.h"

@implementation MainVC
{
    UINavigationController *navController;
    LaunchVC *launchVC;
    SecondVC *secondVC;
    SecondView *secondView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    launchVC = [[LaunchVC alloc] init];
    secondVC = [[SecondVC alloc] init];
    secondView = [[SecondView alloc] init];
    launchVC.delegate = self;
    
    navController = [[UINavigationController alloc] initWithRootViewController: launchVC];
    
    [self.view addSubview: navController.view];
}

// LaunchVCのdelegateから委譲された処理を実装
- (void)changePage
{
    // ビューをテーブルビューに書き換える
    secondVC.delegate = self;
    [navController pushViewController:secondVC animated:YES];
}
- (void)showDetail:(NSString *)url
{
    secondView.url = url;
    [navController pushViewController:secondView animated:YES];
}
@end