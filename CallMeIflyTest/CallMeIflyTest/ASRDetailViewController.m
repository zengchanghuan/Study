//
//  ASRDetailViewController.m
//  CallMeIflyTest
//
//  Created by ZengChanghuan on 16/6/7.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "ASRDetailViewController.h"
#import "XZTextView.h"
#import "IATConfig.h"
#import "iflyMSC/iflyMSC.h"
#import "PopupView.h"
#import "ISRDataHelper.h"

@interface ASRDetailViewController ()<IFlySpeechRecognizerDelegate,IFlyRecognizerViewDelegate>
{
    XZTextView *_textView;
    //不带界面的识别对象
    IFlySpeechRecognizer *_iFlySpeechRecognizer;
    IFlyRecognizerView *_iflyRecognizerView;//带界面的识别对象
    PopupView *_popUpView;
    UIButton *_startBtn;

    float _volume;


    
}
@property (nonatomic, strong) CABasicAnimation *animation;
@property (nonatomic, strong) UIView *animationView;
@property (nonatomic, assign) BOOL isCanceled;
@property (nonatomic, copy) NSString *result;

@end

@implementation ASRDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _animationView = [UIView new];
    _animationView.frame = CGRectMake(0, 0, 100, 100);
    _animationView.center = self.view.center;
    _animationView.backgroundColor = [UIColor grayColor];
    _animationView.layer.cornerRadius = CGRectGetWidth(_animationView.frame) * 0.5;
    [self.view addSubview:_animationView];
    
    _animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    _animation.duration = 1.5;
    _animation.autoreverses = YES;
    _animation.fromValue = @(1.0);
    _animation.toValue = @(2.0);
    _animation.repeatCount = 9999;
    
    [_animationView.layer addAnimation:_animation forKey:@"animationView.scale"];
    
//    _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_startBtn setTitle:@"点我" forState:UIControlStateNormal];
//    [_startBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    _startBtn.frame = CGRectMake(self.view.frame.size.width * 0.5, 20, 100, 30);
//    [self.view addSubview:_startBtn];
    [self createTextView];

    [self startRecoed];

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self initRecognizer];
}
- (void)btnClick
{
    
}
- (void)createTextView
{
    _textView = [[XZTextView alloc] init];
    _textView.frame = CGRectMake(20, 64, [UIScreen mainScreen].bounds.size.width-40, 120);
    
    _textView.placeholder = @"我在聆听中……";
    
    _textView.placeholderColor = [UIColor grayColor];
    [self.view addSubview:_textView];
    
}
- (void)startRecoed
{
    /*
     _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
     _iFlySpeechRecognizer.delegate = self;
     
     //设置听写模式
     [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
     
     //asr_audio_path是录音文件名,设置value为nil或者为空取消保存,默认保存目录在 Library/cache下。
     [_iFlySpeechRecognizer setParameter:@"asrview.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
     
     //启动识别服务
     [_iFlySpeechRecognizer startListening];
     
     */
    //声音小放小倍数，时间长，就会缓
    if ([IATConfig sharedInstance].haveView == NO) {//无界面
        
        [_textView setText:@""];
        [_textView resignFirstResponder];
        self.isCanceled = NO;
        
        if(_iFlySpeechRecognizer == nil)
        {
            [self initRecognizer];
        }
        
        [_iFlySpeechRecognizer cancel];
        
        //设置音频来源为麦克风
        [_iFlySpeechRecognizer setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
        
        //设置听写结果格式为json
        [_iFlySpeechRecognizer setParameter:@"json" forKey:[IFlySpeechConstant RESULT_TYPE]];
        
        //保存录音文件，保存在sdk工作路径中，如未设置工作路径，则默认保存在library/cache下
        [_iFlySpeechRecognizer setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
        
        [_iFlySpeechRecognizer setDelegate:self];
        
        BOOL ret = [_iFlySpeechRecognizer startListening];
        
        if (ret) {
            //            [_audioStreamBtn setEnabled:NO];
            //            [_upWordListBtn setEnabled:NO];
            //            [_upContactBtn setEnabled:NO];
        }else{
            [_popUpView showText: @"启动识别服务失败，请稍后重试"];//可能是上次请求未结束，暂不支持多路并发
        }
    }else {
        
        if(_iflyRecognizerView == nil)
        {
            [self initRecognizer ];
        }
        
        [_textView setText:@""];
        [_textView resignFirstResponder];
        
        //设置音频来源为麦克风
        [_iflyRecognizerView setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
        
        //设置听写结果格式为json
        [_iflyRecognizerView setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
        
        //保存录音文件，保存在sdk工作路径中，如未设置工作路径，则默认保存在library/cache下
        [_iflyRecognizerView setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
        
        [_iflyRecognizerView start];
    }
    
    
//    _animation.duration = arc4random_uniform(100) / 100.0 + 0.1;
//    _animation.toValue = @(arc4random_uniform(6) * 1.0 + 2.0);
//    [_animationView.layer addAnimation:_animation forKey:@"animationView.scale"];

    
}
/**
 *  停止录音
 */
- (void)stopRecoed
{
    [_iFlySpeechRecognizer stopListening];
    [_textView resignFirstResponder];
    [_animationView.layer removeAllAnimations];
}

- (void)cancelRecoed
{
    self.isCanceled = YES;
    [_iFlySpeechRecognizer cancel];
    [_popUpView removeFromSuperview];
    [_textView resignFirstResponder];
    [_animationView.layer removeAllAnimations];
}
#pragma mark -IFlySpeechRecognizerDelegate
/**
 *  识别结果返回代理
 *
 *  @param results 识别结果
 *  @param isLast  表示是否最后一次结果
 */
- (void) onResults:(NSArray *) results isLast:(BOOL)isLast
{
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    
    _result = [NSString stringWithFormat:@"%@%@",_textView.text,resultString];
    NSString *resultFromJson = [ISRDataHelper stringFromJson:resultString];
    _textView.text = [NSString stringWithFormat:@"%@%@",_textView.text,resultFromJson];
    
    if (isLast) {
//        NSLog(@"听写结果(json)：%@测试",  _result);
        [self stopRecoed];
        
    }
    
    
}
/*!
 *  识别结束回调
 *
 *  @param error 识别结束错误码 0表示正常结束 非0表示发生错误
 */
- (void)onError: (IFlySpeechError *) error
{
    
    if ([IATConfig sharedInstance].haveView == NO) {
        NSString *text = @"";
        
        if (self.isCanceled) {
            text = @"识别取消";
        } else if (error.errorCode == 0) {
            if (_result.length == 0) {
                text = @"无识别结果";
            } else {
                text = @"识别成功";
            }
        }else {
            text = [NSString stringWithFormat:@"发生错误：%d %@",error.errorCode,error.errorDesc];
//            NSLog(@"%@",text);
        }
        [_popUpView showText:text];
    } else {
        [_popUpView showText:@"识别结束"];
    }
    
    _startBtn.enabled = YES;
    
}

/**
 *  开如识别回调
 */
- (void) onBeginOfSpeech{
    [_popUpView showText:@"正在录音"];
}
/**
 *  停止录音回调
 */
- (void) onEndOfSpeech{
    [_popUpView showText:@"停止录音"];
    
}

/**
 *  在录音过程中，回调音频的音量
 *
 *  @param volume  -[out] 音量，范围从0-30
 */
- (void) onVolumeChanged: (int)volume
{
    if (self.isCanceled) {
        [_popUpView removeFromSuperview];
        return;
        
    }
    _volume = 1.0 + (volume*1.0) / 30.0;
    NSLog(@"音量大小=%f",_volume);

    _animation.fromValue = @(1.0);
    _animation.toValue = [NSNumber numberWithFloat:_volume];
    _animation.repeatCount = 9999;
    [_animationView.layer addAnimation:_animation forKey:@"animationView.scale"];
    
    
    NSString *vol = [NSString stringWithFormat:@"音量 %d",volume];
    [_popUpView showText:vol];
    
}

/**
 *  取消识别回调
 */
- (void) onCancel
{
    
}

/**
 *  返回音频Key
 *
 *  @param key 音频Key
 */
- (void) getAudioKey:(NSString *)key{
    NSLog(@"%s[IN]",__func__);
    
}


/**
 *  扩展事件回调
 *  根据事件类型返回额外的数据
 *
 *  @param eventType 事件类型，具体参见IFlySpeechEventType的IFlySpeechEventTypeVoiceChangeResult枚举。
 *  @param arg0      arg0
 *  @param arg1      arg1
 *  @param eventData 事件数据
 */
- (void) onEvent:(int)eventType arg0:(int)arg0 arg1:(int)arg1 data:(NSData *)eventData{
    
}

#pragma mark -设置识别参数
/**
 设置识别参数
 ****/
-(void)initRecognizer
{
    
    if ([IATConfig sharedInstance].haveView == NO) {//无界面
        
        //单例模式，无UI的实例
        if (_iFlySpeechRecognizer == nil) {
            _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
            
            [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
            
            //设置听写模式
            [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
        }
        _iFlySpeechRecognizer.delegate = self;
        
        if (_iFlySpeechRecognizer != nil) {
            IATConfig *instance = [IATConfig sharedInstance];
            
            //设置最长录音时间
            [_iFlySpeechRecognizer setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
            //设置后端点
            [_iFlySpeechRecognizer setParameter:instance.vadEos forKey:[IFlySpeechConstant VAD_EOS]];
            //设置前端点
            [_iFlySpeechRecognizer setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
            //网络等待时间
            [_iFlySpeechRecognizer setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
            
            //设置采样率，推荐使用16K
            [_iFlySpeechRecognizer setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
            
            if ([instance.language isEqualToString:[IATConfig chinese]]) {
                //设置语言
                [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
                //设置方言
                [_iFlySpeechRecognizer setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
            }else if ([instance.language isEqualToString:[IATConfig english]]) {
                [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
            }
            //设置是否返回标点符号
            [_iFlySpeechRecognizer setParameter:instance.dot forKey:[IFlySpeechConstant ASR_PTT]];
            
        }
    }else  {//有界面
        
        //单例模式，UI的实例
        if (_iflyRecognizerView == nil) {
            //UI显示剧中
            _iflyRecognizerView= [[IFlyRecognizerView alloc] initWithCenter:self.view.center];
            
            [_iflyRecognizerView setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
            
            //设置听写模式
            [_iflyRecognizerView setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
            
        }
        _iflyRecognizerView.delegate = self;
        
        if (_iflyRecognizerView != nil) {
            IATConfig *instance = [IATConfig sharedInstance];
            //设置最长录音时间
            [_iflyRecognizerView setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
            //设置后端点
            [_iflyRecognizerView setParameter:instance.vadEos forKey:[IFlySpeechConstant VAD_EOS]];
            //设置前端点
            [_iflyRecognizerView setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
            //网络等待时间
            [_iflyRecognizerView setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
            
            //设置采样率，推荐使用16K
            [_iflyRecognizerView setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
            if ([instance.language isEqualToString:[IATConfig chinese]]) {
                //设置语言
                [_iflyRecognizerView setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
                //设置方言
                [_iflyRecognizerView setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
            }else if ([instance.language isEqualToString:[IATConfig english]]) {
                //设置语言
                [_iflyRecognizerView setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
            }
            //设置是否返回标点符号
            [_iflyRecognizerView setParameter:instance.dot forKey:[IFlySpeechConstant ASR_PTT]];
            
        }
    }
}

#pragma mark -IFlyRecognizerViewDelegate
/*!
 *  回调返回识别结果
 *
 *  @param resultArray 识别结果，NSArray的第一个元素为NSDictionary，NSDictionary的key为识别结果，sc为识别结果的置信度
 *  @param isLast      -[out] 是否最后一个结果
 */

- (void)onResult:(NSArray *)resultArray isLast:(BOOL) isLast
{
    
    NSMutableString *result = [[NSMutableString alloc] init];
    NSDictionary *dic = [resultArray objectAtIndex:0];
    
    for (NSString *key in dic) {
        [result appendFormat:@"%@",key];
    }
    _textView.text = [NSString stringWithFormat:@"%@ %@",_textView.text, result];
}
@end
