//
//  XZTabBar.m
//  Menu
//
//  Created by ZengChanghuan on 16/6/15.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZTabBar.h"
#import "XZTabBarButton.h"

@interface XZTabBar ()
@property (nonatomic, weak) XZTabBarButton *selelctedButton;

@end

@implementation XZTabBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 创建按钮
        XZTabBarButton *firstButton = [self setupButton:@"tab_bar_friend_icon" title:@"aaaa"];
        firstButton.enabled = NO;
        self.selelctedButton = firstButton;
        
        [self setupButton:@"tab_bar_friend_icon" title:@"bbb"];
        [self setupButton:@"tab_bar_friend_icon" title:@"cc"];
        [self setupButton:@"tab_bar_friend_icon" title:@"77567"];
        [self setupButton:@"tab_bar_friend_icon" title:@"987"];
        [self setupButton:@"tab_bar_friend_icon" title:@"6757"];
    }
    return self;
}
- (XZTabBarButton *)setupButton:(NSString *)icon title:(NSString *)title
{
    XZTabBarButton *button = [[XZTabBarButton alloc] init];
    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:button];
    return button;

}
- (void)buttonClick:(XZTabBarButton *)button
{
    self.selelctedButton.enabled = YES;
    button.enabled = NO; // button进入highlighted\disabled,图标默认会变灰
    self.selelctedButton = button;
    
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:HMTabBarDidSelectNotification object:nil userInfo:@{HMTabBarSelectIndex : @(button.tag)}];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int count = self.subviews.count;
    for (int i = 0; i<count; i++) {
        XZTabBarButton *button = self.subviews[i];
        button.height = self.height / count;
        button.width = self.width;
        button.x = 0;
        button.y = button.height * i;
        button.tag = i;
    }
}
@end
