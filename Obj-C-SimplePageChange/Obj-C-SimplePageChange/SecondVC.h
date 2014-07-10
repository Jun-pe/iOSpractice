//
//  SecondVC.h
//  Obj-C-SimplePageChange
//
//  Created by 阿部 潤平 on 2014/07/04.
//  Copyright (c) 2014年 Self. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol SecondVCDelegate <NSObject>

- (void)showDetail:(NSString *)url;

@end

@interface SecondVC : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign)id<SecondVCDelegate> delegate;

@property NSMutableArray *entryList;

@end