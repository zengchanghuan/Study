//
//  XMGDeal.h
//  StoryboardTable
//
//  Created by ZengChanghuan on 16/6/17.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGDeal : NSObject
@property (strong, nonatomic) NSString *buyCount;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *icon;

+ (instancetype)dealWithDict:(NSDictionary *)dict;
@end
