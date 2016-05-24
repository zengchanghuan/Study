//
//  BDVRSConfig.h
//  CallMeASR
//
//  Created by ZengChanghuan on 16/5/24.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDTheme.h"
@interface BDVRSConfig : NSObject

@property (nonatomic) BOOL playStartMusicSwitch;
@property (nonatomic) BOOL playEndMusicSwitch;
@property (nonatomic, strong) NSNumber *recognitionProperty;
@property (nonatomic,assign) int recognitionLanguage;
@property (nonatomic) BOOL resultContinuousShow;
@property (nonatomic) BOOL voiceLevelMeter;
@property (nonatomic) BOOL uiHintMusicSwitch;
@property (nonatomic) BOOL isNeedNLU;
@property (nonatomic, copy) NSString *libVersion;
@property (nonatomic, strong) BDTheme *theme;

// --类方法
+ (BDVRSConfig *)sharedInstance;

// 组织输入模式下返回
- (NSString *)composeInputModeResult:(id)aObj;
@end
