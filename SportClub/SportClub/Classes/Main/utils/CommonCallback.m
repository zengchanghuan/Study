//
//  CommonCallback.m
//  LayoutFramework
//
//  Created by liuke on 14-3-28.
//  Copyright (c) 2014年 liuke. All rights reserved.
//

#import "CommonCallback.h"

@interface CommonCallback()
{
    BOOL timeout_;
}

@end

@implementation CommonCallback

+ (instancetype) getInstanceWithFailed:(NSString *)reason
{
    CommonCallback* ccb = [[CommonCallback alloc] init];
    ccb.success = NO;
    ccb.reason = reason;
    ccb.err_code = -1;
    return ccb;
}

- (id) init
{
    if ((self = [super init])) {
        self.level = 1;
        timeout_ = NO;
        self.err_code = 0;
    }
    return self;
}

- (BOOL) isTimeout
{
    return timeout_;
}

- (void) setTimeout
{
    self.success = NO;
    timeout_ = YES;
}

- (void) setReason:(NSString *)reason
{
    if (self.level <= 1 ) {
        _reason = reason;
    }
}

@end
