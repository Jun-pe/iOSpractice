//
//  MainVC.m
//  Obj-C-Sample
//
//  Created by 阿部 潤平 on 2014/07/03.
//  Copyright (c) 2014年 Self. All rights reserved.
//
#import "MainVC.h"

@implementation MainVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view = [[MainView alloc] initWithFrame: self.view.bounds];
}
@end