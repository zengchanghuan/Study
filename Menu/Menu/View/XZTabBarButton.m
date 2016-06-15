
//
//  XZTabBarButton.m
//  Menu
//
//  Created by ZengChanghuan on 16/6/15.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZTabBarButton.h"

@implementation XZTabBarButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar_separate_selected_bg"] forState:UIControlStateDisabled];
        self.imageView.contentMode = UIViewContentModeCenter;
        
        self.adjustsImageWhenDisabled = NO;
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}
- (void)setHighlighted:(BOOL)highlighted {}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (Lanscape) {
        self.imageView.height = self.height;
        self.imageView.width = self.width * 0.4;
        self.imageView.x = 0;
        self.imageView.y = 0;
        
        self.titleLabel.hidden = NO;
        self.titleLabel.y = 0;
        self.titleLabel.x = self.imageView.width;
        self.titleLabel.width = self.width - self.imageView.width;
        self.titleLabel.height = self.height;
    } else {
        self.titleLabel.hidden = YES;
        // 如果设置宽度或者高度为0,某个控件还是会显示一部分, 可以尝试设置控件的width或者height为负数
        //        self.titleLabel.frame = CGRectMake(0, 0, -1, 0);
        self.imageView.frame = self.bounds;
    }
}

@end
