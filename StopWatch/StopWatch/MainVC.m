//
//  MainVC.m
//  StopWatch
//
//  Created by 阿部 潤平 on 2014/07/08.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import "MainVC.h"


@implementation MainVC
- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _mainView = [[MainView alloc] initWithFrame:self.view.bounds];
        
        [self.view addSubview:_mainView];
    }
    return self;
}

@end
