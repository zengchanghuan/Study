//
//  CBASRViewController.m
//  CallMeASR
//
//  Created by ZengChanghuan on 16/5/26.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "BDVoiceRecognitionClient.h"
#import "BDVRSConfig.h"
#import "Masonry.h"
#import "CBASRViewController.h"
#import "BDVRClientUIManager.h"
#import "XZTextView.h"
#define API_KEY @"P2tajQOfTwTiuTviYGriU20W" // 请修改为您在百度开发者平台申请的API_KEY
#define SECRET_KEY @"a352ef5317b377b2713ce125027cb925" // 请修改您在百度开发者平台申请的SECRET_KEY
#define APPID @"8172021" // 请修改为您在百度开发者平台申请的APP ID
#define VOICE_LEVEL_INTERVAL 0.1 // 音量监听频率为1秒中10次

@interface CBASRViewController ()<MVoiceRecognitionClientDelegate>
{
    UIImageView *_dialog;
    NSTimer *_voiceLevelMeterTimer; // 获取语音音量界别定时器
    XZTextView *_outTextView;
}
@end

@implementation CBASRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor purpleColor];
    [btn setTitle:@"启动引擎" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(120, 45));

    }];
    
    _outTextView = [[XZTextView alloc] init];
    _outTextView.backgroundColor = [UIColor grayColor];
    _outTextView.placeholder = @"输出结果";
    [self.view addSubview:_outTextView];
    [_outTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(100);
    }];
    
}

- (void)btnClick
{
    //设置开发者信息
    [[BDVoiceRecognitionClient sharedInstance] setApiKey:API_KEY withSecretKey:SECRET_KEY];
    
    
    // 设置语音识别模式，默认是输入模式
    [[BDVoiceRecognitionClient sharedInstance] setPropertyList:@[[BDVRSConfig sharedInstance].recognitionProperty]];
    
    //设置语言
    [[BDVoiceRecognitionClient sharedInstance] setLanguage:EVoiceRecognitionLanguageChinese];
    
    //可通过如下方法禁用标点符号,默认为不禁用
    [[BDVoiceRecognitionClient sharedInstance] disablePuncs:YES];
    
    // 是否打开语音音量监听功能，可选
    if ([BDVRSConfig sharedInstance].voiceLevelMeter)
    {
        BOOL res = [[BDVoiceRecognitionClient sharedInstance] listenCurrentDBLevelMeter];
        
        if (res == NO)  // 如果监听失败，则恢复开关值
        {
            [BDVRSConfig sharedInstance].voiceLevelMeter = NO;
        }
    }
    else
    {
        [[BDVoiceRecognitionClient sharedInstance] cancelListenCurrentDBLevelMeter];
    }
    
    // 设置播放开始说话提示音开关，可选
    [[BDVoiceRecognitionClient sharedInstance] setPlayTone:EVoiceRecognitionPlayTonesRecStart isPlay:[BDVRSConfig sharedInstance].playStartMusicSwitch];
    // 设置播放结束说话提示音开关，可选
    [[BDVoiceRecognitionClient sharedInstance] setPlayTone:EVoiceRecognitionPlayTonesRecEnd isPlay:[BDVRSConfig sharedInstance].playEndMusicSwitch];
    
    //设置是否对语音进行端点检测,默认开启。如进行端点检测,SDK 会自动判断说话是否结束,从 而停止录音;否则,需要调用 speakFinish 显式结束识别录音。
    [[BDVoiceRecognitionClient sharedInstance] setNeedVadFlag:YES];
    
    //设置是否对上传的语音进行压缩,默认开启。压缩语音会节约手机流量,但是会消耗 CPU 资源。
    [[BDVoiceRecognitionClient sharedInstance] setNeedCompressFlag:YES];
    
    //设置在线识别的响应等待时间,如果超时,触发同步离线识别
    [[BDVoiceRecognitionClient sharedInstance] setOnlineWaitTime:5];
    
    //在开始识别前,需要加载离线识别引擎, 需要传入授权信息、语言模型文件信息及语法槽信息
    NSString* appCode = APPID;
    NSString* datFilePath = [[NSBundle mainBundle] pathForResource:@"s_1" ofType:@""];
    NSString* LMDatFilePath = nil;
    if ([[BDVRSConfig sharedInstance].recognitionProperty intValue] == EVoiceRecognitionPropertyMap) {
        LMDatFilePath = [[NSBundle mainBundle] pathForResource:@"s_2_Navi" ofType:@""];
    } else if ([[BDVRSConfig sharedInstance].recognitionProperty intValue] == EVoiceRecognitionPropertyInput) {
        LMDatFilePath = [[NSBundle mainBundle] pathForResource:@"s_2_InputMethod" ofType:@""];
    }
    // 识别垂类的语法槽信息
    NSDictionary* recogGrammSlot = @{@"$name_CORE" : @"张三\n李四\n",
                                     @"$song_CORE" : @"小苹果\n朋友\n",
                                     @"$app_CORE" : @"QQ\n百度\n微信\n百度地图\n",
                                     @"$artist_CORE" : @"刘德华\n周华健\n"};
    
    int ret = [[BDVoiceRecognitionClient sharedInstance] loadOfflineEngine:appCode
                                                                   license:nil
                                                                   datFile:datFilePath
                                                                 LMDatFile:LMDatFilePath
                                                                 grammSlot:recogGrammSlot];
    
    if (0 != ret) {
        NSLog(@"load offline engine failed: %d", ret);
        return;
    }
    
    //开始语音识别
    int startStatus = -1;
    startStatus = [[BDVoiceRecognitionClient sharedInstance] startVoiceRecognition:self];
    
    if (startStatus != EVoiceRecognitionStartWorking) // 创建失败则报告错误
    {
        NSString *statusString = [NSString stringWithFormat:@"%d",startStatus];
        [self performSelector:@selector(firstStartError:) withObject:statusString afterDelay:0.3];  // 延迟0.3秒，以便能在出错时正常删除view
        return;
    }
    
    // 是否需要播放开始说话提示音，如果是，则提示用户不要说话，在播放完成后再开始说话, 也就是收到EVoiceRecognitionClientWorkStatusStartWorkIng通知后再开始说话。
    if ([BDVRSConfig sharedInstance].playStartMusicSwitch)
    {
        [self createInitView];
    }
    else
    {
        [self createRecordView];
    }

}
#pragma mark - button action methods

- (void)finishRecord:(id)sender
{
    [[BDVoiceRecognitionClient sharedInstance] speakFinish];
}

- (void)cancel:(id)sender
{
    [[BDVoiceRecognitionClient sharedInstance] stopVoiceRecognition];
    
    if (self.view.superview)
    {
        [self.view removeFromSuperview];
    }
}

#pragma mark - MVoiceRecognitionClientDelegate
- (void)VoiceRecognitionClientErrorStatus:(int)aStatus subStatus:(int)aSubStatus
{
    [self createErrorViewWithErrorType:aSubStatus];
}

- (void)VoiceRecognitionClientNetWorkStatus:(int)aStatus
{
    switch (aStatus)
    {
        case EVoiceRecognitionClientNetWorkStatusStart:
        {
            [self createRunLogWithStatus:aStatus];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
            break;
        }
        case EVoiceRecognitionClientNetWorkStatusEnd:
        {
            [self createRunLogWithStatus:aStatus];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            break;
        }          
    }

}

- (void)VoiceRecognitionClientWorkStatus:(int)aStatus obj:(id)aObj
{
    switch (aStatus)
    {
        case EVoiceRecognitionClientWorkStatusFlushData: // 连续上屏中间结果
        {
            NSString *text = [aObj objectAtIndex:0];
            
            if ([text length] > 0)
            {
                DLog(@"%@",text);
            }
            
            break;
        }
        case EVoiceRecognitionClientWorkStatusFinish: // 识别正常完成并获得结果
        {
            [self createRunLogWithStatus:aStatus];
            
            if ([[BDVoiceRecognitionClient sharedInstance] getRecognitionProperty] != EVoiceRecognitionPropertyInput)
            {
                //  搜索模式下的结果为数组，示例为
                // ["公园", "公元"]
                NSMutableArray *audioResultData = (NSMutableArray *)aObj;
                NSMutableString *tmpString = [[NSMutableString alloc] initWithString:@""];
                
                for (int i=0; i < [audioResultData count]; i++)
                {
                    [tmpString appendFormat:@"%@\r\n",[audioResultData objectAtIndex:i]];
                }
                _outTextView.text = nil;
                if (tmpString == nil || [tmpString isEqualToString:@""]) {
                    _outTextView.text = tmpString;
                } else {
                    _outTextView.text = [tmpString stringByAppendingString:tmpString];
                }
                DLog(@"%@",tmpString);
            }
            else
            {
                NSString *tmpString = [[BDVRSConfig sharedInstance] composeInputModeResult:aObj];
                DLog(@"%@",tmpString);
            }
            
            if (self.view.superview)
            {
                [self.view removeFromSuperview];
            }
            
            break;
        }
        case EVoiceRecognitionClientWorkStatusReceiveData:
        {
            // 此状态只有在输入模式下使用
            // 输入模式下的结果为带置信度的结果，示例如下：
            //  [
            //      [
            //         {
            //             "百度" = "0.6055192947387695";
            //         },
            //         {
            //             "摆渡" = "0.3625582158565521";
            //         },
            //      ]
            //      [
            //         {
            //             "一下" = "0.7665404081344604";
            //         }
            //      ],
            //   ]
            
            NSString *tmpString = [[BDVRSConfig sharedInstance] composeInputModeResult:aObj];
            DLog(@"%@",tmpString);
            
            break;
        }
        case EVoiceRecognitionClientWorkStatusEnd: // 用户说话完成，等待服务器返回识别结果
        {
            [self createRunLogWithStatus:aStatus];
            if ([BDVRSConfig sharedInstance].voiceLevelMeter)
            {
                //[self freeVoiceLevelMeterTimerTimer];
            }
            
            //[self createRecognitionView];
            
            break;
        }
        case EVoiceRecognitionClientWorkStatusCancel:
        {
            if ([BDVRSConfig sharedInstance].voiceLevelMeter)
            {
                //[self freeVoiceLevelMeterTimerTimer];
            }
            
            [self createRunLogWithStatus:aStatus];
            
            if (self.view.superview)
            {
                [self.view removeFromSuperview];
            }
            break;
        }
        case EVoiceRecognitionClientWorkStatusStartWorkIng: // 识别库开始识别工作，用户可以说话
        {
            if ([BDVRSConfig sharedInstance].playStartMusicSwitch) // 如果播放了提示音，此时再给用户提示可以说话
            {
                [self createRecordView];
            }
            
            if ([BDVRSConfig sharedInstance].voiceLevelMeter)  // 开启语音音量监听
            {
                [self startVoiceLevelMeterTimer];
            }
            
            [self createRunLogWithStatus:aStatus];
            
            break;
        }
        case EVoiceRecognitionClientWorkStatusNone:
        case EVoiceRecognitionClientWorkPlayStartTone:
        case EVoiceRecognitionClientWorkPlayStartToneFinish:
        case EVoiceRecognitionClientWorkStatusStart:
        case EVoiceRecognitionClientWorkPlayEndToneFinish:
        case EVoiceRecognitionClientWorkPlayEndTone:
        {
            [self createRunLogWithStatus:aStatus];
            break;
        }
        case EVoiceRecognitionClientWorkStatusNewRecordData:
        {
            break;
        }
        default:
        {
            [self createRunLogWithStatus:aStatus];
            if ([BDVRSConfig sharedInstance].voiceLevelMeter)
            {
                //[self freeVoiceLevelMeterTimerTimer];
            }
            if (self.view.superview)
            {
                [self.view removeFromSuperview];
            }
            
            break;
        }
    }
}
#pragma mark - voice search error result

- (void)firstStartError:(NSString *)statusString {
    [self createErrorViewWithErrorType:[statusString intValue]];
}

- (void)createErrorViewWithErrorType:(int)aStatus
{
    NSString *errorMsg = @"";
    
    switch (aStatus)
    {
        case EVoiceRecognitionClientErrorStatusIntrerruption:
        {
            errorMsg = NSLocalizedString(@"StringVoiceRecognitonInterruptRecord", nil);
            break;
        }
        case EVoiceRecognitionClientErrorStatusChangeNotAvailable:
        {
            errorMsg = NSLocalizedString(@"StringVoiceRecognitonChangeNotAvailable", nil);
            break;
        }
        case EVoiceRecognitionClientErrorStatusUnKnow:
        {
            errorMsg = NSLocalizedString(@"StringVoiceRecognitonStatusError", nil);
            break;
        }
        case EVoiceRecognitionClientErrorStatusNoSpeech:
        {
            errorMsg = NSLocalizedString(@"StringVoiceRecognitonNoSpeech", nil);
            break;
        }
        case EVoiceRecognitionClientErrorStatusShort:
        {
            errorMsg = NSLocalizedString(@"StringVoiceRecognitonNoShort", nil);
            break;
        }
        case EVoiceRecognitionClientErrorStatusException:
        {
            errorMsg = NSLocalizedString(@"StringVoiceRecognitonException", nil);
            break;
        }
        case EVoiceRecognitionClientErrorNetWorkStatusError:
        {
            errorMsg = NSLocalizedString(@"StringVoiceRecognitonNetWorkError", nil);
            break;
        }
        case EVoiceRecognitionClientErrorNetWorkStatusUnusable:
        {
            errorMsg = NSLocalizedString(@"StringVoiceRecognitonNoNetWork", nil);
            break;
        }
        case EVoiceRecognitionClientErrorNetWorkStatusTimeOut:
        {
            errorMsg = NSLocalizedString(@"StringVoiceRecognitonNetWorkTimeOut", nil);
            break;
        }
        case EVoiceRecognitionClientErrorNetWorkStatusParseError:
        {
            errorMsg = NSLocalizedString(@"StringVoiceRecognitonParseError", nil);
            break;
        }
        case EVoiceRecognitionStartWorkNoAPIKEY:
        {
            errorMsg = NSLocalizedString(@"StringAudioSearchNoAPIKEY", nil);
            break;
        }
        case EVoiceRecognitionStartWorkGetAccessTokenFailed:
        {
            errorMsg = NSLocalizedString(@"StringAudioSearchGetTokenFailed", nil);
            break;
        }
        case EVoiceRecognitionStartWorkDelegateInvaild:
        {
            errorMsg = NSLocalizedString(@"StringVoiceRecognitonNoDelegateMethods", nil);
            break;
        }
        case EVoiceRecognitionStartWorkNetUnusable:
        {
            errorMsg = NSLocalizedString(@"StringVoiceRecognitonNoNetWork", nil);
            break;
        }
        case EVoiceRecognitionStartWorkRecorderUnusable:
        {
            errorMsg = NSLocalizedString(@"StringVoiceRecognitonCantRecord", nil);
            break;
        }
        case EVoiceRecognitionStartWorkNOMicrophonePermission:
        {
            errorMsg = NSLocalizedString(@"StringAudioSearchNOMicrophonePermission", nil);
            break;
        }
            //服务器返回错误
        case EVoiceRecognitionClientErrorNetWorkStatusServerNoFindResult:     //没有找到匹配结果
        case EVoiceRecognitionClientErrorNetWorkStatusServerSpeechQualityProblem:    //声音过小
            
        case EVoiceRecognitionClientErrorNetWorkStatusServerParamError:       //协议参数错误
        case EVoiceRecognitionClientErrorNetWorkStatusServerRecognError:      //识别过程出错
        case EVoiceRecognitionClientErrorNetWorkStatusServerAppNameUnknownError: //appName验证错误
        case EVoiceRecognitionClientErrorNetWorkStatusServerUnknownError:      //未知错误
        {
            errorMsg = [NSString stringWithFormat:@"%@-%d",NSLocalizedString(@"StringVoiceRecognitonServerError", nil),aStatus] ;
            break;
        }
        default:
        {
            errorMsg =[NSString stringWithFormat:@"%@：%d", NSLocalizedString(@"StringVoiceRecognitonDefaultError", nil), aStatus];
            break;
        }
    }
    
    DLog(@"%@",errorMsg);
    _outTextView.text = errorMsg;
//    [clientSampleViewController logOutToManualResut:errorMsg];
}
#pragma mark - voice search views

- (void)createInitView
{
    if (_dialog && _dialog.superview)
        [_dialog removeFromSuperview];
    
    UIImageView *tmpImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"recordBackground.png"]];
    tmpImageView.userInteractionEnabled = YES;
    tmpImageView.alpha = 0.6; /* He Liqiang, TAG-130729 */
    _dialog = tmpImageView;
    _dialog.backgroundColor = [UIColor clearColor];
    _dialog.center = self.view.center;
    [self.view addSubview:_dialog];
    
    tmpImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"microphone.png"]];
    tmpImageView.center = [[BDVRClientUIManager sharedInstance] VRRecordBackgroundCenter];
    [_dialog addSubview:tmpImageView];
    
    UILabel *tmpLabel = [[UILabel alloc] initWithFrame:[[BDVRClientUIManager sharedInstance] VRRecordTintWordFrame]];
    tmpLabel.backgroundColor = [UIColor clearColor];
    tmpLabel.font = [UIFont boldSystemFontOfSize:28.0f];
    tmpLabel.textColor = [UIColor whiteColor];
    tmpLabel.text = NSLocalizedString(@"StringVoiceRecognitonInit", nil);
    tmpLabel.textAlignment = NSTextAlignmentCenter;
    tmpLabel.center = [[BDVRClientUIManager sharedInstance] VRTintWordCenter];
    [_dialog addSubview:tmpLabel];
    
    UIButton *tmpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tmpButton.frame = [[BDVRClientUIManager sharedInstance] VRCenterButtonFrame];
    tmpButton.center = [[BDVRClientUIManager sharedInstance] VRCenterButtonCenter];
    tmpButton.backgroundColor = [UIColor clearColor];
    [tmpButton setTitle:NSLocalizedString(@"StringCancel", nil) forState:UIControlStateNormal];
    tmpButton.titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    tmpButton.titleLabel.textColor = [UIColor whiteColor];
    [_dialog addSubview:tmpButton];
    [tmpButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    tmpButton.showsTouchWhenHighlighted = YES;
}

- (void)createRecordView
{
    UIView *tmpView = [[UIView alloc] init];
    tmpView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:tmpView];
    [tmpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 200));
    }];
    
    /*
    if (_dialog && _dialog.superview)
        [_dialog removeFromSuperview];
    
    UIImageView *tmpImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"recordBackground.png"]];
    tmpImageView.userInteractionEnabled = YES;
    tmpImageView.alpha = 0.6;
    _dialog = tmpImageView;
    _dialog.backgroundColor = [UIColor clearColor];
    _dialog.center = self.view.center;
    [self.view addSubview:_dialog];
    
    tmpImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"microphone.png"]];
    tmpImageView.center = [[BDVRClientUIManager sharedInstance] VRRecordBackgroundCenter];
    [_dialog addSubview:tmpImageView];
    
    UILabel *tmpLabel = [[UILabel alloc] initWithFrame:[[BDVRClientUIManager sharedInstance] VRRecordTintWordFrame]];
    tmpLabel.backgroundColor = [UIColor clearColor];
    tmpLabel.font = [UIFont boldSystemFontOfSize:28.0f];
    tmpLabel.textColor = [UIColor whiteColor];
    tmpLabel.text = NSLocalizedString(@"StringVoiceRecognitonPleaseSpeak", nil);
    tmpLabel.textAlignment = NSTextAlignmentCenter;
    tmpLabel.center = [[BDVRClientUIManager sharedInstance] VRTintWordCenter];
    [_dialog addSubview:tmpLabel];
    
    UIButton *tmpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tmpButton.frame = [[BDVRClientUIManager sharedInstance] VRLeftButtonFrame];
    tmpButton.backgroundColor = [UIColor clearColor];
    [tmpButton setTitle:NSLocalizedString(@"StringCancel", nil) forState:UIControlStateNormal];
    tmpButton.titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    tmpButton.titleLabel.textColor = [UIColor whiteColor];
    [_dialog addSubview:tmpButton];
    [tmpButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    tmpButton.showsTouchWhenHighlighted = YES;
    
    tmpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tmpButton.frame = [[BDVRClientUIManager sharedInstance] VRRightButtonFrame];
    [tmpButton setTitle:NSLocalizedString(@"StringVoiceRecognitonRecordFinish", nil) forState:UIControlStateNormal];
    tmpButton.titleLabel.textColor = [UIColor whiteColor];
    tmpButton.titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    [_dialog addSubview:tmpButton];
    [tmpButton addTarget:self action:@selector(finishRecord:) forControlEvents:UIControlEventTouchUpInside];
    tmpButton.showsTouchWhenHighlighted = YES;
    */
}

- (void)createRecognitionView
{
    if (_dialog && _dialog.superview)
        [_dialog removeFromSuperview];
    
    UIImageView *tmpImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"recognitionBackground.png"]];
    tmpImageView.userInteractionEnabled = YES;
    tmpImageView.alpha = 0.6; /* He Liqiang, TAG-130729 */
    _dialog = tmpImageView;
    _dialog.center = self.view.center;
    [self.view addSubview:_dialog];
    
    tmpImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"recognitionIcon.png"]];
    tmpImageView.center = [[BDVRClientUIManager sharedInstance] VRRecognizeBackgroundCenter];
    [_dialog addSubview:tmpImageView];
    
    UILabel *tmpLabel = [[UILabel alloc] initWithFrame:[[BDVRClientUIManager sharedInstance] VRRecognizeTintWordFrame]];
    tmpLabel.backgroundColor = [UIColor clearColor];
    tmpLabel.font = [UIFont boldSystemFontOfSize:28.0f];
    tmpLabel.textColor = [UIColor whiteColor];
    tmpLabel.text = NSLocalizedString(@"StringVoiceRecognitonIdentify", nil);
    tmpLabel.textAlignment = NSTextAlignmentCenter;
    tmpLabel.center = [[BDVRClientUIManager sharedInstance] VRTintWordCenter];
    [_dialog addSubview:tmpLabel];
    
    UIButton *tmpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tmpButton.frame = [[BDVRClientUIManager sharedInstance] VRCenterButtonFrame];
    tmpButton.center = [[BDVRClientUIManager sharedInstance] VRCenterButtonCenter];
    tmpButton.backgroundColor = [UIColor clearColor];
    [tmpButton setTitle:NSLocalizedString(@"StringCancel", nil) forState:UIControlStateNormal];
    tmpButton.titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    tmpButton.titleLabel.textColor = [UIColor whiteColor];
    [_dialog addSubview:tmpButton];
    [tmpButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    tmpButton.showsTouchWhenHighlighted = YES;
    
}
#pragma mark - voice search log
- (void)createRunLogWithStatus:(int)aStatus
{
    NSString *statusMsg = nil;
    switch (aStatus)
    {
        case EVoiceRecognitionClientWorkStatusNone: //空闲
        {
            statusMsg = NSLocalizedString(@"StringLogStatusNone", nil);
            break;
        }
        case EVoiceRecognitionClientWorkPlayStartTone:  //播放开始提示音
        {
            statusMsg = NSLocalizedString(@"StringLogStatusPlayStartTone", nil);
            break;
        }
        case EVoiceRecognitionClientWorkPlayStartToneFinish: //播放开始提示音完成
        {
            statusMsg = NSLocalizedString(@"StringLogStatusPlayStartToneFinish", nil);
            break;
        }
        case EVoiceRecognitionClientWorkStatusStartWorkIng: //识别工作开始，开始采集及处理数据
        {
            statusMsg = NSLocalizedString(@"StringLogStatusStartWorkIng", nil);
            break;
        }
        case EVoiceRecognitionClientWorkStatusStart: //检测到用户开始说话
        {
            statusMsg = NSLocalizedString(@"StringLogStatusStart", nil);
            break;
        }
        case EVoiceRecognitionClientWorkPlayEndTone: //播放结束提示音
        {
            statusMsg = NSLocalizedString(@"StringLogStatusPlayEndTone", nil);
            break;
        }
        case EVoiceRecognitionClientWorkPlayEndToneFinish: //播放结束提示音完成
        {
            statusMsg = NSLocalizedString(@"StringLogStatusPlayEndToneFinish", nil);
            break;
        }
        case EVoiceRecognitionClientWorkStatusReceiveData: //语音识别功能完成，服务器返回正确结果
        {
            statusMsg = NSLocalizedString(@"StringLogStatusSentenceFinish", nil);
            break;
        }
        case EVoiceRecognitionClientWorkStatusFinish: //语音识别功能完成，服务器返回正确结果
        {
            statusMsg = NSLocalizedString(@"StringLogStatusFinish", nil);
            break;
        }
        case EVoiceRecognitionClientWorkStatusEnd: //本地声音采集结束结束，等待识别结果返回并结束录音
        {
            statusMsg = NSLocalizedString(@"StringLogStatusEnd", nil);
            break;
        }
        case EVoiceRecognitionClientNetWorkStatusStart: //网络开始工作
        {
            statusMsg = NSLocalizedString(@"StringLogStatusNetWorkStatusStart", nil);
            break;
        }
        case EVoiceRecognitionClientNetWorkStatusEnd:  //网络工作完成
        {
            statusMsg = NSLocalizedString(@"StringLogStatusNetWorkStatusEnd", nil);
            break;
        }
        case EVoiceRecognitionClientWorkStatusCancel:  // 用户取消
        {
            statusMsg = NSLocalizedString(@"StringLogStatusNetWorkStatusCancel", nil);
            break;
        }
        case EVoiceRecognitionClientWorkStatusError: // 出现错误
        {
            statusMsg = NSLocalizedString(@"StringLogStatusNetWorkStatusErorr", nil);
            break;
        }
        default:
        {
            statusMsg = NSLocalizedString(@"StringLogStatusNetWorkStatusDefaultErorr", nil);
            break;
        }
    }
    
    if (statusMsg)
    {/*
      NSString *logString = self.clientSampleViewController.logCatView.text;
      if (logString && [logString isEqualToString:@""] == NO)
      {
      self.clientSampleViewController.logCatView.text = [logString stringByAppendingFormat:@"\r\n%@", statusMsg];
      }
      else
      {
      self.clientSampleViewController.logCatView.text = statusMsg;
      }
      */
    }
}
#pragma mark - VoiceLevelMeterTimer methods
- (void)startVoiceLevelMeterTimer
{
    [self freeVoiceLevelMeterTimerTimer];
    
    NSDate *tmpDate = [[NSDate alloc] initWithTimeIntervalSinceNow:VOICE_LEVEL_INTERVAL];
    NSTimer *tmpTimer = [[NSTimer alloc] initWithFireDate:tmpDate interval:VOICE_LEVEL_INTERVAL target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    _voiceLevelMeterTimer = tmpTimer;
    [[NSRunLoop currentRunLoop] addTimer:_voiceLevelMeterTimer forMode:NSDefaultRunLoopMode];
}

- (void)freeVoiceLevelMeterTimerTimer
{
    if(_voiceLevelMeterTimer)
    {
        if([_voiceLevelMeterTimer isValid])
            [_voiceLevelMeterTimer invalidate];
        _voiceLevelMeterTimer = nil;
    }
}

- (void)timerFired:(id)sender
{
    // 获取语音音量级别
    int voiceLevel = [[BDVoiceRecognitionClient sharedInstance] getCurrentDBLevelMeter];
    
    NSString *statusMsg = [NSLocalizedString(@"StringLogVoiceLevel", nil) stringByAppendingFormat:@": %d", voiceLevel];
    DLog(@"%@",statusMsg);
//    [clientSampleViewController logOutToLogView:statusMsg];
}

#pragma mark - animation finish

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    //
}
@end
