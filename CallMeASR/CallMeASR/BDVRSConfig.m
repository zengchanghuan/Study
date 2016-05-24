//
//  BDVRSConfig.m
//  CallMeASR
//
//  Created by ZengChanghuan on 16/5/24.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "BDVRSConfig.h"
#import "BDVoiceRecognitionClient.h"
@implementation BDVRSConfig
- (id)init
{
    self = [super init];
    if (self)
    {
        self.resultContinuousShow = YES;
        self.playStartMusicSwitch = NO;
        self.playEndMusicSwitch = NO;
        _recognitionProperty = [NSNumber numberWithInt: EVoiceRecognitionPropertyInput];
        self.recognitionLanguage = EVoiceRecognitionLanguageChinese;
        self.voiceLevelMeter = NO;
        self.uiHintMusicSwitch = YES;
        self.isNeedNLU = NO;
        
        NSString *tmpString = [[BDVoiceRecognitionClient sharedInstance] libVer];
        _libVersion = [[NSString alloc] initWithString:tmpString];
        _theme = [BDTheme lightBlueTheme];
    }
    return self;
}
+ (BDVRSConfig *)sharedInstance
{
    static BDVRSConfig *_sharedInstance = nil;
    if (_sharedInstance == nil)
    {
        _sharedInstance = [[BDVRSConfig alloc] init];
    }
    
    return _sharedInstance;
}

- (NSString *)composeInputModeResult:(id)aObj
{
    NSMutableString *tmpString = [[NSMutableString alloc] initWithString:@""];
    for (NSArray *result in aObj)
    {
        NSDictionary *dic = [result objectAtIndex:0];
        NSString *candidateWord = [[dic allKeys] objectAtIndex:0];
        [tmpString appendString:candidateWord];
    }
    
    return tmpString;
}


@end
