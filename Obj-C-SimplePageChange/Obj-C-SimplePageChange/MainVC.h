//
//  MainVC.h
//  Obj-C-SimplePageChange
//
//  Created by 阿部 潤平 on 2014/07/04.
//  Copyright (c) 2014年 Self. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "LaunchVC.h"
#import "SecondVC.h"
#import "SecondView.h"

// protocolとしてLaunchVCDelegateを読み込む
@interface MainVC : UIViewController<LaunchVCDelegate, SecondVCDelegate>

@end