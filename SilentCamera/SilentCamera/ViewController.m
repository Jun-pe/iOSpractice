//
//  ViewController.m
//  SilentCamera
//
//  Created by 野田 潤平 on 2014/05/21.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import "ViewController.h"
#import "CameraManager.h"

// 最初に表示するページのURL
#define kHomePageURL @"http://www.apple.com/jp/"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *urlField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self navigate:kHomePageURL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -IBAction

// 撮影ボタン
- (IBAction)performCameraButton:(id)sender
{
    // 撮影
    [[CameraManager sharedManager] takePhoto];
}

// 開くボタン
- (IBAction)performNavigateButtonAction:(id)sender
{
    [self navigate:self.urlField.text];
}

// 戻るボタン
- (IBAction)performBackButtonAction:(id)sender
{
    [self.webView goBack];
}

// 進むボタン
- (IBAction)performNextButtonAction:(id)sender
{
    [self.webView goForward];
}

#pragma mark - User Interface

// 戻る・進むができるときのみボタンを有効化
- (void)enableBUttons
{
    self.backButton.enabled = self.webView.canGoBack;
    self.nextButton.enabled = self.webView.canGoForward;
}

// キーボードのReturnが押されたとき
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // 読み込みを開始
    [self navigate:self.urlField.text];
    
    return YES;
}

#pragma mark - Web View

// 指定したURLをWeb Viewで開く
- (void)navigate:(NSString *)strUrl
{
    // キーボードを閉じる
    [self.urlField resignFirstResponder];
    
    // URLの文字列からリクエストを作成
    NSURL *url = [NSURL URLWithString:strUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // リクエスト開始
    [self.webView loadRequest:request];
}

// Web Viewが読み込みを開始した時
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // インジケータを表示
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

// Web Viewのエラー時
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    // インジケータを表示
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    // エラーを表示
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    
    // ボタンの有効・無効を切り替え
    [self enableBUttons];
}

// Web Viewの読み込みが完了したとき
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // インジケータを隠す
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    // 現在のURLをテキストボックスに反映
    self.urlField.text = webView.request.URL.absoluteString;
    
    // ボタンの有効・無効を切り替え
    [self enableBUttons];
}
@end
