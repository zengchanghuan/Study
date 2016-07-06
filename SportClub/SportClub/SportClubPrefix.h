//
//  SportClubPrefix.h
//  SportClub
//
//  Created by ZengChanghuan on 16/6/12.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#ifndef SportClubPrefix_h
#define SportClubPrefix_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "UIView+Extension.h"
#import "UIBarButtonItem+Extension.h"
#import "CommonCallback.h"
#import "MBProgressHUD+MJ.h"
#import "XZNetManager.h"


//服务器地址
#define SERVERURL @"http://114.112.98.72:8089"

#ifdef DEBUG // 处于开发阶段
#define XZLog(...) NSLog(__VA_ARGS__)
#else // 处于发布阶段
#define XZLog(...)
#endif
// RGB颜色
#define XZColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

//通知中心
#define XZNotificationCenter [NSNotificationCenter defaultCenter]

#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

//随机色

#define XZRandomColor XZColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

//屏幕总宽度
#define XZScreenWidth [UIScreen mainScreen].bounds.size.width

#define XZScreenHeight [UIScreen mainScreen].bounds.size.height

#endif /* SportClubPrefix_h */
