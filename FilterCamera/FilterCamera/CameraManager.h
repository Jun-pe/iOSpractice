//
//  CameraManager.h
//  FilterCamera
//
//  Created by 野田 潤平 on 2014/05/22.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import "GPUImage.h"
#import <Foundation/Foundation.h>

@interface CameraManager : NSObject

+ (instancetype)sharedManager;

// カメラキャプチャの開始・停止
- (void)startCamera:(GPUImageView *)imageView;
- (void)stopCamera;

// 前面・背面カメラを切り替え
- (void)switchCameraPosition:(GPUImageView *)imageView;

// 次のフィルタ・前のフィルタへ切り替え
- (void)setPreviousFilter:(GPUImageView *)imageView;
- (void)setNextFilter:(GPUImageView *)imageView;

// 写真を撮影して保存する
- (void)takePhoto;
@end
