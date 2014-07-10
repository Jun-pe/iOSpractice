//
//  SecondView.m
//  Obj-C-SimplePageChange
//
//  Created by 阿部 潤平 on 2014/07/04.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SecondView.h"

@implementation SecondView

@synthesize url;

UIWebView *webView;

- (instancetype)init {
    self = [super initWithNibName:nil bundle:nil];
    
    webView = [[UIWebView alloc]initWithFrame: [self.view bounds]];
    [self.view addSubview:webView];
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString: self.url]];
    [webView loadRequest:request];
}
@end