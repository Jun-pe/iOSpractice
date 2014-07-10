//
//  MainView.m
//  Obj-C-Sample
//
//  Created by 阿部 潤平 on 2014/07/04.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainView.h"

@implementation MainView

UILabel *label;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        
        self.backgroundColor = [UIColor whiteColor];
        
        label = [[UILabel alloc]initWithFrame: CGRectMake(20, 20, 220, 40)];
        label.text = @"Hello";
        label.textColor = [UIColor blackColor];
        
        [self addSubview:label];
    }
    return self;
}

@end