//
//  ContactService.h
//  FastContact
//
//  Created by 野田 潤平 on 2014/05/13.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ContactRecord;
@interface ContactService : NSObject
+ (void)contactWithRecord:(ContactRecord *)record;
@end
