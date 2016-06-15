//
//  XZDock.m
//  Menu
//
//  Created by ZengChanghuan on 16/6/15.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZDock.h"
#import "XZIconView.h"
#import "XZTabBar.h"
#import "XZToolBar.h"
@interface XZDock ()

@property (nonatomic, strong) XZIconView *iconView;
@property (nonatomic, strong) XZTabBar *tabBar;
@property (nonatomic, strong) XZToolBar *toolBar;

@end

@implementation XZDock

-(instancetype)initWithFrame:(CGRect)frame
{
  
    if (self = [super initWithFrame:frame]) {
        _iconView = [XZIconView new];
        [self addSubview:_iconView];
        
        _tabBar = [XZTabBar new];
        [self addSubview:_tabBar];
        
        _toolBar = [XZToolBar new];
        [self addSubview:_toolBar];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.toolBar.width = self.width;
    self.tabBar.width = self.width;
    self.tabBar.height = self.tabBar.subviews.count * HMDockPW;
    
    if (Lanscape) { // 横屏
        self.toolBar.height = self.width / self.toolBar.subviews.count;
        
        self.iconView.width = self.width * 0.4;
        self.iconView.height = self.iconView.width + 40;
        self.iconView.x = (self.width - self.iconView.width) * 0.5;
        self.iconView.y = 70;
    } else { // 竖屏
        self.toolBar.height = self.width * self.toolBar.subviews.count;
        
        self.iconView.x = 5;
        self.iconView.y = 50;
        self.iconView.width = self.width - 2 * self.iconView.x;
        self.iconView.height = self.iconView.width;
    }
    self.toolBar.y = self.height - self.toolBar.height;
    self.tabBar.y = self.toolBar.y - self.tabBar.height;
}
@end
