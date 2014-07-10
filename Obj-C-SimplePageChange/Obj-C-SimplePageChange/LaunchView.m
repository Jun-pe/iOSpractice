//
//  LaunchView.m
//  Obj-C-SimplePageChange
//
//  Created by 阿部 潤平 on 2014/07/04.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LaunchView.h"



@implementation LaunchView

UILabel *label;
UIButton *button;

// アクセサ
@synthesize delegate;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        
        self.backgroundColor = [UIColor whiteColor];
        
        // label
        label = [[UILabel alloc] initWithFrame: CGRectMake(20, 80, 280, 40)];
        label.text = @"シンプルなページ遷移の実装";
        label.textColor = [UIColor blackColor];
        
        [self addSubview:label];
        
        // button
        button = [[UIButton alloc] initWithFrame:CGRectMake(20, 130, 280, 40)];
        [button setTitle:@"画面遷移" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
    }
    return self;
}

// 画面のボタンがタッチされたときの処理
- (void)pageChange:(UIButton *)sender {
    
    // delegateに処理を委譲する
    [self.delegate changePage];
}
@end