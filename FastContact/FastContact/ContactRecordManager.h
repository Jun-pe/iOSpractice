//
//  ContactRecordManager.h
//  FastContact
//
//  Created by 野田 潤平 on 2014/05/13.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactRecordManager : NSObject
@property(readonly, nonatomic)NSMutableArray *records;
@property(readonly, nonatomic)ABAddressBookRef addressBook;

// アプリケーション内で共通のインスタンスを返す
+ (instancetype)sharedManager;
- (BOOL)save;
@end
