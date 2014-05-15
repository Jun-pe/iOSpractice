//
//  ContactRecordManager.m
//  FastContact
//
//  Created by 野田 潤平 on 2014/05/13.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import "ContactRecordManager.h"

@implementation ContactRecordManager

+ (instancetype)sharedManager
{
    static id manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

// ファイルの保存先を返す
- (NSString *)filePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *name = @"records.plist";
    
    return [path stringByAppendingPathComponent:name];
}

- (id)init
{
    self = [super init];
    if (self) {
        // ファイルからデータを読み込む
        NSMutableArray *records = [NSKeyedUnarchiver unarchiveObjectWithFile:[self filePath]];
        // データがない場合は空の配列を設定
        if (!records) {
            records = [NSMutableArray array];
        }
        
        _addressBook = ABAddressBookCreateWithOptions(nil, nil);
        _records = records;
    }
    return self;
}

- (void)dealloc
{
    CFRelease(_addressBook);
}

- (BOOL)save
{
    // データをファイルに書き出し
    return [NSKeyedArchiver archiveRootObject:self.records toFile:[self filePath]];
}
@end
