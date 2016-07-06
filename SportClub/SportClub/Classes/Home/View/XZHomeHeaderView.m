//
//  XZHomeHeaderView.m
//  SportClub
//
//  Created by ZengChanghuan on 16/6/29.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZHomeHeaderView.h"
#import "XZHeaderTab.h"
#import "XZStatusToolbar.h"
@implementation XZHomeHeaderView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        XZStatusToolbar *toolBar = [XZStatusToolbar toolbar];
        toolBar.frame = CGRectMake(0, 181, XZScreenWidth, 45);
        [self addSubview:toolBar];
        
    }
    return self;
}

@end
