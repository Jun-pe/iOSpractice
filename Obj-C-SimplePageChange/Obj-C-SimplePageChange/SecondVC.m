//
//  SecondVC.m
//  Obj-C-SimplePageChange
//
//  Created by 阿部 潤平 on 2014/07/04.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SecondVC.h"
#import "Entry.h"

@implementation SecondVC

@synthesize delegate;

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 配列を初期化
        _entryList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self accessAPI];
}
// APIへのAccess
- (void)accessAPI
{
    NSURLRequest *request;
    NSString *tmpUrl;
    
    tmpUrl = @"https://qiita.com/api/v1/items";
    
    request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:tmpUrl]];
    
    // APIへAccess
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        // JSONをパース（配列にディクショナリとして格納される）
        NSArray *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        _entryList = [[NSMutableArray alloc] init];
        
        // 配列の展開
        for (NSDictionary *dic in jsonDic) {
            Entry *tmpEntry = [[Entry alloc]init];
            tmpEntry.title = [dic objectForKey: @"title"];
            tmpEntry.url = [dic objectForKey: @"url"];
            [_entryList addObject:tmpEntry];
        }
        // テーブルビューの再描画
        [self.tableView reloadData];
    }];
}
// ****
// # テーブルビュー関連の関数
// ****
- (int)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_entryList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // セルの宣言と初期化
    UITableViewCell *cell;
    cell = [[UITableViewCell alloc] init];

    Entry *entryDtl = _entryList[indexPath.row];

    cell.textLabel.text = entryDtl.title;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

// セルがタップされた時の処理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Entry *entyrDtl = _entryList[indexPath.row];
    
    [self.delegate showDetail: entyrDtl.url];
}
@end