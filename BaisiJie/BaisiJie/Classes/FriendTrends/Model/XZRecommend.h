//
//  XZRecommendList.h
//  BaisiJie
//
//  Created by ZengChanghuan on 16/6/28.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XZRecommend : NSObject
/** id */
@property (nonatomic, assign) NSInteger id;
/** 总数 */
@property (nonatomic, assign) NSInteger count;
/** 名字 */
@property (nonatomic, copy) NSString *name;
@end
