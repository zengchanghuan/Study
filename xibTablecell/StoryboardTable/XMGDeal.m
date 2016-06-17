//
//  XMGDeal.m
//  StoryboardTable
//
//  Created by ZengChanghuan on 16/6/17.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XMGDeal.h"

@implementation XMGDeal
+ (instancetype)dealWithDict:(NSDictionary *)dict
{
    XMGDeal *deal = [[self alloc] init];
    
    //    deal.title = dict[@"title"];
    //    deal.icon = dict[@"icon"];
    //    deal.buyCount = dict[@"buyCount"];
    //    deal.price = dict[@"price"];
    
    // KVC - Key Value Coding
    [deal setValuesForKeysWithDictionary:dict];
    
    return deal;
}
@end
