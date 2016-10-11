//
//  NSDictionary+NilSafe.h
//  licenseTest
//
//  Created by ZengChanghuan on 16/10/10.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSObject (Swizzling)
+ (BOOL)gl_swizzleMethod:(SEL)origSel withMethod:(SEL)altSel;
+ (BOOL)gl_swizzleClassMethod:(SEL)origSel withMethod:(SEL)altSel;

@end

@interface NSDictionary (NilSafe)
+ (void)load;
+ (instancetype)gl_dictionaryWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt;
- (instancetype)gl_initWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt;
@end

@interface NSMutableDictionary (NilSafe)

+ (void)load;
- (void)gl_setObject:(id)anObject forKey:(id<NSCopying>)aKey;
- (void)gl_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key;

@end

@interface NSNull (NilSafe)

+ (void)load;
- (NSMethodSignature *)gl_methodSignatureForSelector:(SEL)aSelector;
- (void)gl_forwardInvocation:(NSInvocation *)anInvocation;
@end
