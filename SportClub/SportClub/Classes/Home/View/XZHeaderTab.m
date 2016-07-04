//
//  XZHeaderTab.m
//  SportClub
//
//  Created by ZengChanghuan on 16/7/1.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZHeaderTab.h"

@implementation XZHeaderTab

+ (instancetype)headTab
{

    return [[[NSBundle mainBundle] loadNibNamed:@"XZHeaderTab" owner:nil options:nil] lastObject];
}

@end
