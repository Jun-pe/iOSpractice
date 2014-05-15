//
//  ContactRecord.h
//  FastContact
//
//  Created by 野田 潤平 on 2014/05/13.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactRecord : NSObject <NSCoding>

- (id)initWithPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier;

@property(readonly, nonatomic)ABRecordRef person;
@property(readonly, nonatomic)ABPropertyID propertyID;
@property(readonly, nonatomic)ABMultiValueIdentifier multiValueIdentifier;
@end
