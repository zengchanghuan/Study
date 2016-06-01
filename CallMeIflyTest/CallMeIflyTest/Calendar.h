//
//  Calendar.h
//  CallMeIflyTest
//
//  Created by ZengChanghuan on 16/5/31.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Segment.h"
@interface Calendar : NSObject
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) NSNumber *clock;
@property (nonatomic, strong) NSNumber *day;
@property (nonatomic, strong) NSNumber *month;
@property (nonatomic, strong) NSNumber *year;
@property (nonatomic, strong) NSArray *segments;
@end
