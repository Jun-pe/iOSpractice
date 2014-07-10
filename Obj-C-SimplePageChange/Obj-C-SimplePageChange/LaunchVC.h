//
//  LaunchVC.h
//  Obj-C-SimplePageChange
//
//  Created by 阿部 潤平 on 2014/07/04.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LaunchView.h"

// delegate を宣言
@protocol LaunchVCDelegate <NSObject>

// delegate で利用するメソッドを定義（実装はdelegate先で行う）
- (void)changePage;

@end

// protocolとしてLaunchViewDelegateを読み込む
@interface LaunchVC: UIViewController<LaunchViewDelegate>

// delegate 先から参照出来るようにdelegateを定義
@property (nonatomic, assign) id<LaunchVCDelegate> delegate;

@end