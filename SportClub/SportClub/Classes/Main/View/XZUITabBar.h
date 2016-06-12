//
//  XZUITabBar.h
//  SportClub
//
//  Created by ZengChanghuan on 16/6/12.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XZUITabBar;
@protocol XZTabBarDelegate <UITabBarDelegate>
@optional
- (void)tabBarDidClickPlusButton:(XZUITabBar *)tabBar;

@end


@interface XZUITabBar : UITabBar
@property (nonatomic, weak) id<XZTabBarDelegate>XZTabBarDelegate;
@end
