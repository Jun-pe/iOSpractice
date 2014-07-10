//
//  MainView.h
//  StopWatch
//
//  Created by 阿部 潤平 on 2014/07/08.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface MainView : UIView

@property UILabel *timerCounter;
@property int timerNum;
@property NSTimer *timer;
- (void)addTimerCount:(UIButton *)sender;
- (void)resetTimeCount;


@end
