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
@interface ASRViewController ()<BDRecognizerViewDelegate>
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
    
}
@end
