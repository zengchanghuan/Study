//
//  XZRecommendList.m
//  BaisiJie
//
//  Created by ZengChanghuan on 16/6/28.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZRecommend.h"

@implementation XZRecommend
-(NSMutableArray *)users{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}
@end
