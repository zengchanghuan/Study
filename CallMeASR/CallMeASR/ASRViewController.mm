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
#import "BDVRRawDataRecognizer.h"
#import "BDVRFileRecognizer.h"
#import "Masonry.h"
#import "BDVRSConfig.h"
#import "BDVRDataUploader.h"



#define API_KEY @"P2tajQOfTwTiuTviYGriU20W" // 请修改为您在百度开发者平台申请的API_KEY
#define SECRET_KEY @"a352ef5317b377b2713ce125027cb925" // 请修改您在百度开发者平台申请的SECRET_KEY
#define APPID @"8172021" // 请修改为您在百度开发者平台申请的APP ID
@interface ASRViewController ()<BDRecognizerViewDelegate,MVoiceRecognitionClientDelegate>
@property (nonatomic, strong) BDRecognizerViewController *recognizerViewController;
@property (nonatomic, strong) BDVRRawDataRecognizer *rawDataRecognizer;
@property (nonatomic, strong) BDVRFileRecognizer *fileRecognizer;
@property (nonatomic, strong) BDVRDataUploader *contactsUploader;
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
    [recognitionBtn addTarget:self action:@selector(startRecognitionAction) forControlEvents:UIControlEventTouchUpInside];
    
    [recognitionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 60));
        make.left.mas_equalTo(60);
        make.top.mas_equalTo(64);
    }];
}
- (void)startRecognitionAction
{
    //创建识别控件对象 识别控件起始位置
    BDRecognizerViewController *recognizerViewController = [[BDRecognizerViewController alloc] initWithOrigin:CGPointMake(9, 128) withTheme:[BDTheme defaultTheme]];
    recognizerViewController.enableFullScreenMode = NO;
    
    //识别控件主题
    BDTheme *theme = [BDTheme defaultTheme];
    
    //設置識別參數
    BDRecognizerViewParamsObject *params = [BDRecognizerViewParamsObject new];
    params.apiKey = API_KEY;
    params.secretKey = SECRET_KEY;
    params.appCode = APPID;
    
    //设置代理
    recognizerViewController.delegate = self;
    
    //启动识别
    [recognizerViewController startWithParams:params];
    
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
    
}
/**
 * @brief 录音数据返回
 *
 * @param recordData 录音数据
 * @param sampleRate 采样率
 */
- (void)onRecordDataArrived:(NSData *)recordData sampleRate:(int)sampleRate
{
    
}

/**
 * @brief 录音结束
 */
- (void)onRecordEnded
{
    
}

/**
 * @brief 返回中间识别结果
 *
 * @param results 中间识别结果
 */
- (void)onPartialResults:(NSString *)results
{
    
}

/**
 * @brief 发生错误
 *
 * @param errorCode
 *            错误码
 */
- (void)onError:(int)errorCode
{
    
}

/**
 * @brief 提示语出现
 */
- (void)onTipsShow
{
    
}

- (void)onSpeakFinish
{
    
}

- (void)onRetry
{
    
}

/**
 * @brief 弹窗关闭
 */
- (void)onClose
{
    
}
#pragma mark -MVoiceRecognitionClientDelegate
- (void)VoiceRecognitionClientWorkStatus:(int) aStatus obj:(id)aObj{
    
}
- (void)VoiceRecognitionClientErrorStatus:(int) aStatus subStatus:(int)aSubStatus{
    
}

- (void)VoiceRecognitionClientNetWorkStatus:(int) aStatus
{
    
}

@end
