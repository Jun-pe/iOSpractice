//
//  MainView.m
//  StopWatch
//
//  Created by 阿部 潤平 on 2014/07/08.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import "MainView.h"

@implementation MainView

UIButton *btnOneM;
UIButton *btnFiveM;
UIButton *btnTenM;
UIButton *btnReset;
UIButton *startBtn;

int timerSecond;
int lapseCount;
_Bool resetFlag;
_Bool alertFlag;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    // 値の初期化
    self.timerNum = 0;  // スタート時のカウンター
    resetFlag = YES;
    
    if (self) {
        self.frame = frame;
        
        self.backgroundColor = [UIColor whiteColor];
        
        // 1分ボタン
        btnOneM = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btnOneM.frame = CGRectMake(20, 50, 62.5, 40);
        btnOneM.layer.borderColor = [UIColor grayColor].CGColor;
        btnOneM.layer.borderWidth = 1.0f;
        btnOneM.layer.cornerRadius = 7.5f;
        btnOneM.tag = 1;
        
        [btnOneM setTitle:@"1分" forState:UIControlStateNormal];
        [btnOneM setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btnOneM addTarget:self action:@selector(addTimerCount:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnOneM];
        
        // 5分ボタン
        btnFiveM = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btnFiveM.frame = CGRectMake(92.5, 50, 62.5, 40);
        btnFiveM.layer.borderColor = [UIColor grayColor].CGColor;
        btnFiveM.layer.borderWidth = 1.0f;
        btnFiveM.layer.cornerRadius = 7.5f;
        btnFiveM.tag = 5;
        
        [btnFiveM setTitle:@"5分" forState:UIControlStateNormal];
        [btnFiveM setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btnFiveM addTarget:self action:@selector(addTimerCount:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btnFiveM];
        
        // 10分ボタン
        btnTenM = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btnTenM.frame = CGRectMake(165, 50, 62.5, 40);
        btnTenM.layer.borderColor = [UIColor grayColor].CGColor;
        btnTenM.layer.borderWidth = 1.0f;
        btnTenM.layer.cornerRadius = 7.5f;
        btnTenM.tag = 10;
        
        [btnTenM setTitle:@"10分" forState:UIControlStateNormal];
        [btnTenM setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btnTenM addTarget:self action:@selector(addTimerCount:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btnTenM];
        
        // リセットボタン
        btnReset = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btnReset.frame = CGRectMake(237.5, 50, 62.5, 40);
        btnReset.layer.borderColor = [UIColor grayColor].CGColor;
        btnReset.layer.borderWidth = 1.0f;
        btnReset.layer.cornerRadius = 7.5f;
        
        [btnReset setTitle:@"リセット" forState:UIControlStateNormal];
        [btnReset setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btnReset addTarget:self action:@selector(resetTimeCount) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btnReset];
        
        // 時間表示ラベル
        self.timerCounter = [[UILabel alloc]initWithFrame:CGRectMake(20, 110, 280, 70)];
        self.timerCounter.text = @"00:00";
        self.timerCounter.textColor = [UIColor blackColor];
        self.timerCounter.textAlignment = NSTextAlignmentCenter;
        self.timerCounter.font = [UIFont boldSystemFontOfSize:80];
        
        [self addSubview:self.timerCounter];
        
        // スタートボタン
        UIImage *img = [UIImage imageNamed:@"start_btn.jpg"];
        startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        startBtn.frame = CGRectMake(20, 200, 280, 280);
        [startBtn setBackgroundImage:img forState:UIControlStateNormal];
        
        [startBtn addTarget:self action:@selector(timerControl) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:startBtn];
        
    }
    return self;
}

// *****
// * タップ処理制御
// *****
// 時間設定ボタンがタップされたときの処理
- (void)addTimerCount:(UIButton *)sender
{
    // タイマー作動中は処理しない
    if ([self.timer isValid] == 0) {
        // 時間設定をした場合、タイマー状態はリセットする
        resetFlag = YES;

        UIButton *tmpBtn = (UIButton *)sender;
        
        // タップされたボタンによって、カウンターの値に加算する（60以上になる場合は60を設定）
        self.timerNum = self.timerNum + tmpBtn.tag;
        if (self.timerNum > 60) {
            self.timerNum = 60;
        }
        
        [self setTimerLabel];
    }
}
// リセットボタンタップ時の処理
- (void)resetTimeCount
{
    // タイマー作動中は処理しない
    if ([self.timer isValid] == 0) {
        self.timerNum = 0;
        self.timerCounter.text = @"00:00";
    }
}
// スタートボタンタップ時の処理
- (void)timerControl
{
    // タイマーの動作状況によって処理を切り分ける
    if (self.timerNum > 0) {
        if ([self.timer isValid] == 0) {
            [self setButtonDisable: NO];
            if (resetFlag) {
                timerSecond = self.timerNum * 5;
                lapseCount = 0;
            } else {
                // タイマーが手動ストップされていた場合はタイマー再開
                [self.timer fire];
            }
            
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerCount) userInfo:nil repeats:YES];
        } else {
            // 手動ストップの場合はタイマー再開
            resetFlag = NO;
            [self.timer invalidate];
            
            [self setButtonDisable: YES];
        }
    }
}


// *****
// * タイマーの設定
// *****
// タイマー作動時に呼ばれる処理
- (void)timerCount
{
    int tmpMinut;
    int tmpSecond;
    NSString *tmpStrMinut;
    NSString *tmpStrSecond;
    
    // 経過時間を記録
    lapseCount++;
    
    // 分秒の表示計算
    tmpMinut = self.timerNum - (lapseCount / 60 + 1);
    tmpSecond = 60 - (lapseCount % 60);
    
    // 分の表示を制御
    if (tmpSecond == 60) {
        tmpMinut++;
    }
    tmpStrMinut = [NSString stringWithFormat:@"%d", tmpMinut];
    if (tmpMinut <= 0) {
        tmpStrMinut = @"00";
    } else if (tmpMinut < 10) {
        tmpStrMinut = [NSString stringWithFormat:@"0%d", tmpMinut];
    }
    
    // 秒の表示を制御
    tmpStrSecond = [NSString stringWithFormat:@"%d", tmpSecond];
    if (tmpSecond <= 0 || tmpSecond >= 60) {
        tmpStrSecond = @"00";
    } else if (tmpSecond < 10) {
        tmpStrSecond = [NSString stringWithFormat:@"0%d", tmpSecond];
    }
    
    // 残時間表示ラベルを書き換え
    self.timerCounter.text = [NSString stringWithFormat:@"%@:%@", tmpStrMinut, tmpStrSecond];
    
    // 残り時間毎のイベント
    if ((timerSecond - lapseCount) == 60) {
        // 残り１分になったらお知らせ
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    } else if (timerSecond <= lapseCount) {
        // 設定時間が経過したらタイマーストップ
        [self.timer invalidate];
        resetFlag = YES;
        
        // 時間経過の通知を繰り返し行う
        alertFlag = YES;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerStop) userInfo:nil repeats:YES];
    }
}
// 設定時間経過時に繰り返し呼ばれる処理
- (void)timerStop
{
    // 震える
    if (alertFlag) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }

}
// 画面タップ時に呼ばれる処理
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 終了アラームがなっている時に画面をタップするとアラームが止まる
    if (alertFlag) {
        [self.timer invalidate];
        alertFlag = NO;
        
        // アラームを止めると同時に時間をスタート時の表示に戻し、ボタンのDisableを外す
        [self setButtonDisable: YES];
        [self setTimerLabel];
    }
}

// タイマー表示ラベルの制御
- (void)setTimerLabel
{
    NSString *tmpTime;
    
    // タイマー表示ラベルに残時間を表示する
    tmpTime = [NSString stringWithFormat:@"%d", self.timerNum];
    if (self.timerNum < 10) {
        tmpTime = [NSString stringWithFormat:@"0%d", self.timerNum];
    }
    self.timerCounter.text = [NSString stringWithFormat:@"%@:00", tmpTime];
}
// ボタンのDisable設定
- (void)setButtonDisable:(BOOL)flg
{
    btnOneM.enabled = flg;
    btnFiveM.enabled = flg;
    btnTenM.enabled = flg;
    btnReset.enabled = flg;
}
@end
