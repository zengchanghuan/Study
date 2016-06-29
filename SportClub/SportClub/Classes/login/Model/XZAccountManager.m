//
//  XZAccountManager.m
//  SportClub
//
//  Created by ZengChanghuan on 16/6/21.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZAccountManager.h"

@implementation XZAccountManager
-(void)getCheckCodeWithMobile:(NSString *)mobile Completed:(void(^)(CommonCallback *ccb, NSDictionary *data))callback
{
    if (mobile == nil || [mobile isEqualToString:@""]) {
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:1];
    [params setObject:mobile forKey:@"mobile"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",SERVERURL,@"/auth/sms/send"];

    
    [XZAccountManager post:url params:params success:^(id json) {
        
    } failure:^(NSError *error) {
        XZLog(@"%@",error);

    }];
}
@end
