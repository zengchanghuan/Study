//
//  NSString+MD5.h
//  SportClub
//
//  Created by ZengChanghuan on 16/6/23.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (MD5)
- (NSData*)MD5CharData;
- (NSString*)MD5;

@end
