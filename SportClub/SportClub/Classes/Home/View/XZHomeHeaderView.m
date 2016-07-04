//
//  XZHomeHeaderView.m
//  SportClub
//
//  Created by ZengChanghuan on 16/6/29.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZHomeHeaderView.h"
#import "XZHeaderTab.h"
@implementation XZHomeHeaderView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        XZHeaderTab *tabView = [XZHeaderTab headTab];
        tabView.frame = CGRectMake(0, 181, screenWidth, 45);
        [self addSubview:tabView];
        
    }
    return self;
}

@end
