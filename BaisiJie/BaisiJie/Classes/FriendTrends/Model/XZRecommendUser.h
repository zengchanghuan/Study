//
//  XMGRecommendUser.h
//  BaisiJie
//
//  Created by ZengChanghuan on 16/6/28.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XZRecommendUser : NSObject
/** 头像 */
@property (nonatomic, copy) NSString *header;
/** 粉丝数(有多少人关注这个用户) */
@property (nonatomic, assign) NSInteger fans_count;
/** 昵称 */
@property (nonatomic, copy) NSString *screen_name;


@end
