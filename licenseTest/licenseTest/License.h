//
//  CubeLisense.h
//  CubeEngine
//
//  Created by ZengChanghuan on 16/9/1.
//  Copyright © 2016年 Cube Team. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface CubeServer : NSObject

@property (nonatomic, copy) NSString *host;
@property (nonatomic, assign) NSInteger HTTPPort;
@property (nonatomic, assign) NSInteger TCPPort;

+ (CubeServer *)cubeServerDict:(NSDictionary *)dict;;
- (NSMutableDictionary *)toJSON;

@end

@interface ICEServer : NSObject
@property (nonatomic, copy) NSString *host;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, assign) NSInteger port;
@property (nonatomic, copy) NSString *username;
+ (ICEServer *)ICEServerParse:(NSDictionary *)dict;
- (NSMutableDictionary *)toJSON;
@end

@interface CubeHttpServer : NSObject

@property (nonatomic, assign) NSInteger HTTPPort;
@property (nonatomic, copy) NSString *host;
@property (nonatomic, assign) NSInteger SSLPort;

+ (CubeHttpServer *)cubeHttpServerParse:(NSDictionary *)dict;
- (NSMutableDictionary *)toJSON;
@end

@interface BackupServer: NSObject

@property (nonatomic, assign) NSInteger HTTPPort;
@property (nonatomic, copy) NSString *host;
@property (nonatomic, assign) NSInteger TCPPort;
+ (BackupServer *)backupServerParse:(NSDictionary *)dict;
- (NSMutableDictionary *)toJSON;
@end

@interface BackupHttpServer: NSObject

@property (nonatomic, assign) NSInteger HTTPPort;
@property (nonatomic, copy) NSString *host;
@property (nonatomic, assign) NSInteger SSLPort;
+ (BackupHttpServer *)backupHttpServerParse:(NSDictionary *)dict;
- (NSMutableDictionary *)toJSON;
@end

@interface CubeLicense : NSObject

@property (nonatomic, copy) NSString *configVersion;
@property (nonatomic, copy) NSString *appKey;
@property (nonatomic, copy) NSString *appId;
@property (nonatomic, assign) long beginNumber;
@property (nonatomic, assign) long endNumber;
@property (nonatomic, assign) long long beginDate;
@property (nonatomic, assign) long long endDate;
@property (nonatomic, strong) CubeServer *cubeServer;
@property (nonatomic, strong) CubeHttpServer *cubeHttpServer;
@property (nonatomic, strong) NSDictionary *conferenceDic;
@property (nonatomic, strong) BackupServer *backupServer;
@property (nonatomic, strong) BackupHttpServer *backupHttpServer;
@property (nonatomic, strong) NSDictionary *backupConferenceDic;
@property (nonatomic, strong) NSArray *permissionArray;
@property (nonatomic, strong) NSDictionary *companyDic;
@property (nonatomic, copy) NSString *version;
@property (nonatomic, assign) long long createTime;
@property (nonatomic, strong) NSArray<ICEServer *> *ICEServers;

+ (CubeLicense *)licenseParse:(NSDictionary *)dict;
- (NSMutableDictionary *)toJSON;

@end