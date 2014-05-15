//
//  ContactRecord.m
//  FastContact
//
//  Created by 野田 潤平 on 2014/05/13.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import "ContactRecord.h"
#import "ContactRecordManager.h"

static NSString *const kEncodeKeyRecordID = @"RecordID";
static NSString *const kEncodeKeyPropertyID = @"PropertyID";
static NSString *const kEncodeKeyMultiValueIdentifier = @"MultiValueIdentifier";

@interface ContactRecord()
@property(assign, nonatomic)ABRecordID recordID;
@end

@implementation ContactRecord

- (id)initWithPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    self = [super init];
    if (self) {
        // 内部的には、ABRecordRefを直接持たずに、ABRecordRefを示すIDを保持する
        _recordID = ABRecordGetRecordID(person);
        _propertyID = property;
        _multiValueIdentifier = identifier;
    }
    
    return self;
}

// NSCodingのデコードメソッド
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        // NSCoderから各プロパティの値をデコードする
        _recordID = [aDecoder decodeInt32ForKey:kEncodeKeyRecordID];
        _propertyID = [aDecoder decodeInt32ForKey:kEncodeKeyPropertyID];
        _multiValueIdentifier = [aDecoder decodeInt32ForKey:kEncodeKeyMultiValueIdentifier];
    }
    return self;
}

// NSCodingのエンコードメソッド
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    // 各プロパティの値をエンコードする
    [aCoder encodeInt32:_recordID forKey:kEncodeKeyRecordID];
    [aCoder encodeInt32:_propertyID forKey:kEncodeKeyPropertyID];
    [aCoder encodeInt32:_multiValueIdentifier forKey:kEncodeKeyMultiValueIdentifier];
}

// 保持しているIDからABRecordRefを取得して返す
- (ABRecordRef)person
{
    ABAddressBookRef addressBook = [[ContactRecordManager sharedManager] addressBook];
    return ABAddressBookGetPersonWithRecordID(addressBook, self.recordID);
}
@end
