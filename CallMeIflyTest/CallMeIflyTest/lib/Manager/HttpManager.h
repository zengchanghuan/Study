//
//  HttpaManager.h
//  CallMeIflyTest
//
//  Created by ZengChanghuan on 16/5/30.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpManager : NSObject
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
@end
