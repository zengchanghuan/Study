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
#import <SDCycleScrollView/SDCycleScrollView.h>

@interface XZHomeHeaderView ()<SDCycleScrollViewDelegate>

@end
@implementation XZHomeHeaderView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSArray *imageNames = @[@"h1.jpg",
                                @"h2.jpg",
                                @"h3.jpg",
                                @"h4.jpg",
                                @"h7" // 本地图片请填写全名
                                ];
        SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, XZScreenWidth, 180) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
        cycleScrollView.delegate = self;
        cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        [self addSubview:cycleScrollView];
        cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //         --- 轮播时间间隔，默认1.0秒，可自定义
        //cycleScrollView.autoScrollTimeInterval = 4.0;

        
        
        
        self.backgroundColor = [UIColor grayColor];
        XZStatusToolbar *toolBar = [XZStatusToolbar toolbar];
        toolBar.frame = CGRectMake(0, 181, XZScreenWidth, 45);
        [self addSubview:toolBar];
        
    }
    return self;
}


#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
}


/*
 
 // 滚动到第几张图回调
 - (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
 {
 NSLog(@">>>>>> 滚动到第%ld张图", (long)index);
 }
 
 */

@end
