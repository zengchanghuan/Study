//
//  XZAccountManager.h
//  SportClub
//
//  Created by ZengChanghuan on 16/6/21.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZNetManager.h"

@interface XZAccountManager : XZNetManager


-(void)getCheckCodeWithMobile:(NSString *)mobile Completed:(void(^)(CommonCallback *ccb, NSDictionary *data))callback;

@end
