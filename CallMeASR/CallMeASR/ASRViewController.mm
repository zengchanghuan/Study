//
//  ASRViewController.m
//  CallMeASR
//
//  Created by ZengChanghuan on 16/5/24.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "ASRViewController.h"
#import "BDRecognizerViewController.h"
#import "BDRecognizerViewDelegate.h"
#import "BDVoiceRecognitionClient.h"
#import "Masonry.h"
#import "BDVRSConfig.h"



#define API_KEY @"P2tajQOfTwTiuTviYGriU20W" // 请修改为您在百度开发者平台申请的API_KEY
#define SECRET_KEY @"a352ef5317b377b2713ce125027cb925" // 请修改您在百度开发者平台申请的SECRET_KEY
#define APPID @"8172021" // 请修改为您在百度开发者平台申请的APP ID
@interface ASRViewController ()<BDRecognizerViewDelegate,MVoiceRecognitionClientDelegate>
@property (nonatomic, strong) BDRecognizerViewController *recognizerViewController;
@end

@implementation ASRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatRecognitionButton];
    
}

- (void)creatRecognitionButton
{
    //__weak typeof(self) weakSelf = self;
    UIButton *recognitionBtn = [[UIButton alloc] init];
    recognitionBtn.backgroundColor = [UIColor grayColor];
    [self.view addSubview:recognitionBtn];
    [recognitionBtn addTarget:self action:@selector(startVoiceRecognitionAction) forControlEvents:UIControlEventTouchUpInside];
    
    [recognitionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 60));
        make.left.mas_equalTo(60);
        make.top.mas_equalTo(64);
    }];
}
//UI语音识别
- (void)startRecognitionAction
{
    // 创建识别控件
    BDRecognizerViewController *tmpRecognizerViewController = [[BDRecognizerViewController alloc] initWithOrigin:CGPointMake(9, 128) withTheme:[BDVRSConfig sharedInstance].theme];
    
    // 全屏UI
    if ([[BDVRSConfig sharedInstance].theme.name isEqualToString:@"全屏亮蓝"]) {
        tmpRecognizerViewController.enableFullScreenMode = YES;
    }
    
    tmpRecognizerViewController.delegate = self;
    self.recognizerViewController = tmpRecognizerViewController;
    
    // 设置识别参数
    BDRecognizerViewParamsObject *paramsObject = [[BDRecognizerViewParamsObject alloc] init];
    
    // 开发者信息，必须修改API_KEY和SECRET_KEY为在百度开发者平台申请得到的值，否则示例不能工作
    paramsObject.apiKey = API_KEY;
    paramsObject.secretKey = SECRET_KEY;
    
    // 设置是否需要语义理解，只在搜索模式有效
    paramsObject.isNeedNLU = [BDVRSConfig sharedInstance].isNeedNLU;
    
    // 设置识别语言
    paramsObject.language = BDVoiceRecognitionLanguageChinese;
    
    // 设置识别模式，分为搜索和输入
    paramsObject.recogPropList = @[[BDVRSConfig sharedInstance].recognitionProperty];
    
    // 设置城市ID，当识别属性包含EVoiceRecognitionPropertyMap时有效
    paramsObject.cityID = 1;
    
    // 开启联系人识别
    //    paramsObject.enableContacts = YES;
    
    // 设置显示效果，是否开启连续上屏
    if ([BDVRSConfig sharedInstance].resultContinuousShow)
    {
        paramsObject.resultShowMode = BDRecognizerResultShowModeContinuousShow;
    }
    else
    {
        paramsObject.resultShowMode = BDRecognizerResultShowModeWholeShow;
    }
    
    // 设置提示音开关，是否打开，默认打开
    if ([BDVRSConfig sharedInstance].uiHintMusicSwitch)
    {
        paramsObject.recordPlayTones = EBDRecognizerPlayTonesRecordPlay;
    }
    else
    {
        paramsObject.recordPlayTones = EBDRecognizerPlayTonesRecordForbidden;
    }
    
    paramsObject.isShowTipAfter3sSilence = NO;
    paramsObject.isShowHelpButtonWhenSilence = NO;
    paramsObject.tipsTitle = @"可以使用如下指令记账";
    paramsObject.tipsList = [NSArray arrayWithObjects:@"我要记账", @"买苹果花了十块钱", @"买牛奶五块钱", @"第四行滚动后可见", @"第五行是最后一行", nil];
    
    paramsObject.appCode = APPID;
    paramsObject.licenseFilePath= [[NSBundle mainBundle] pathForResource:@"bdasr_temp_license" ofType:@"dat"];
    paramsObject.datFilePath = [[NSBundle mainBundle] pathForResource:@"s_1" ofType:@""];
    if ([[BDVRSConfig sharedInstance].recognitionProperty intValue] == EVoiceRecognitionPropertyMap) {
        paramsObject.LMDatFilePath = [[NSBundle mainBundle] pathForResource:@"s_2_Navi" ofType:@""];
    } else if ([[BDVRSConfig sharedInstance].recognitionProperty intValue] == EVoiceRecognitionPropertyInput) {
        paramsObject.LMDatFilePath = [[NSBundle mainBundle] pathForResource:@"s_2_InputMethod" ofType:@""];
    }
    
    paramsObject.recogGrammSlot = @{@"$name_CORE" : @"张三\n李四\n",
                                    @"$song_CORE" : @"小苹果\n朋友\n",
                                    @"$app_CORE" : @"QQ\n百度\n微信\n百度地图\n",
                                    @"$artist_CORE" : @"刘德华\n周华健\n"};
    DLog(@"%@",paramsObject);
    
    [_recognizerViewController startWithParams:paramsObject];
}

- (void)startVoiceRecognitionAction
{
    [[BDVoiceRecognitionClient sharedInstance] setApiKey:API_KEY withSecretKey:SECRET_KEY];
    int startStatus = -1;
    startStatus = [[BDVoiceRecognitionClient sharedInstance] startVoiceRecognition:self];
    if (startStatus != EVoiceRecognitionStartWorking) {
        DLog(@"启动出错");
    }
    
}
#pragma mark -MVoiceRecognitionClientDelegate
- (void)VoiceRecognitionClientErrorStatus:(int)aStatus subStatus:(int)aSubStatus
{
    DLog(@"处理网络出错");
}

- (void)VoiceRecognitionClientNetWorkStatus:(int)aStatus
{
    DLog(@"处理网络状态变化");
}

- (void)VoiceRecognitionClientWorkStatus:(int)aStatus obj:(id)aObj
{
    DLog(@"处理网络状态变化");
}
#pragma mark -BDRecognizerViewDelegate
/**
 * @brief 语音识别结果返回，搜索和输入模式结果返回的结构不相同
 *
 * @param aBDRecognizerView 弹窗UI
 * @param aResults 返回结果，搜索结果为数组，输入结果也为数组，但元素为字典
 */
- (void)onEndWithViews:(BDRecognizerViewController *)aBDRecognizerViewController withResults:(NSArray *)aResults
{
    
    DLog(@"%@",aResults);
    
    
    
    /*
    
    if ([[BDVoiceRecognitionClient sharedInstance] getRecognitionProperty] != EVoiceRecognitionPropertyInput)
    {
        // 搜索模式下的结果为数组，示例为
        // ["公园", "公元"]
        NSMutableArray *audioResultData = (NSMutableArray *)aResults;
        NSMutableString *tmpString = [[NSMutableString alloc] initWithString:@""];
        
        for (int i=0; i < [audioResultData count]; i++)
        {
            [tmpString appendFormat:@"%@\r\n",[audioResultData objectAtIndex:i]];
        }
        

        NSLog(@"%@",tmpString);
    }
    else
    {
        NSString *tmpString = [[BDVRSConfig sharedInstance] composeInputModeResult:aResults];
        NSLog(@"%@",tmpString);
        
    }
     */
}

@end
