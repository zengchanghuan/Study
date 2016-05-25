//
//  BDVRViewController.h
//  BDVRClientSample
//
//  Created by Baidu on 13-9-24.
//  Copyright (c) 2013年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDRecognizerViewController.h"
#import "BDRecognizerViewDelegate.h"
#import "BDVRFileRecognizer.h"
#import "BDVRDataUploader.h"

// 枚举
enum TDemoButtonType
{
	EDemoButtonTypeSetting = 0,
	EDemoButtonTypeVoiceRecognition,
    EDemoButtonTypeSDKUI
};

@class BDVRCustomRecognitonViewController;

// @class - BDVRViewController
// @brief - Sample主界面的实现类
@interface BDVRViewController : UIViewController<BDRecognizerViewDelegate, MVoiceRecognitionClientDelegate, BDVRDataUploaderDelegate>
{
}

@property (nonatomic, retain) BDRecognizerViewController *recognizerViewController;


// --UI中按钮动作
- (IBAction)sdkUIRecognitionAction;

@end
