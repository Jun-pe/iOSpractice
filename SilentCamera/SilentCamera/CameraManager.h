//
//  CameraManager.h
//  SilentCamera
//
//  Created by 野田 潤平 on 2014/05/21.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CameraManager : NSObject
<
    AVCaptureVideoDataOutputSampleBufferDelegate
>

+ (instancetype)sharedManager;
- (void)takePhoto;

@end
