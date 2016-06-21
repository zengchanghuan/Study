//
//  CommonCallback.h
//  LayoutFramework
//
//  Created by liuke on 14-3-28.
//  Copyright (c) 2014年 liuke. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  作为统一的格式作为block返回参数
 */
@interface CommonCallback : NSObject

+ (instancetype) getInstanceWithFailed:(NSString*)reason;

/**
 *  分别3级，最高为3，最低为1。3为网络反馈；2为字符串合法反馈；1为正常biz反馈
 */
@property (nonatomic) NSUInteger level;

/**
 *  操作是否成功
 */
@property (nonatomic) BOOL success;
/**
 *  失败的原因，需要提示给UI时使用。已进行国际化
 */
@property (nonatomic, strong) NSString* reason;

/**
 *  失败的错误码
 */
@property (nonatomic, strong) NSString* code;
//如果是网络问题，err_code默认为-1
@property (nonatomic) int err_code;

@property (nonatomic, strong) NSString* err_msg;

/**
 *  关闭标志
 */
@property (nonatomic, strong) NSString* closed;

- (BOOL) isTimeout;

- (void) setTimeout;

@end
