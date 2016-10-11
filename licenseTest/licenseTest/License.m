//
//  CubeLisense.m
//  CubeEngine
//
//  Created by ZengChanghuan on 16/9/1.
//  Copyright © 2016年 Cube Team. All rights reserved.
//

#import "CubeLicense.h"
#import "NSDictionary+KeepNilSafe.h"
@implementation CubeServer

+ (CubeServer *)cubeServerDict:(NSDictionary *)dict
{
    NSString *host = dict[@"Host"];
    NSInteger HTTPPort = [dict[@"HTTPPort"] integerValue];
    NSInteger TCPPort = [dict[@"TCPPort"] integerValue];
    CubeServer *cubeServer = [[CubeServer alloc] init];
    cubeServer.host = host;
    cubeServer.HTTPPort = HTTPPort;
    cubeServer.TCPPort = TCPPort;
    return cubeServer;
}
- (NSMutableDictionary *)toJSON
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:3];
    [dic setObject:_host forKey:@"Host"];
    [dic setObject:[NSNumber numberWithInteger:_HTTPPort] forKey:@"HTTPPort"];
    [dic setObject:[NSNumber numberWithInteger:_TCPPort] forKey:@"TCPPort"];
    return dic;
}

@end

@implementation ICEServer

+ (ICEServer *)ICEServerParse:(NSDictionary *)dict
{
    NSString *host = dict[@"Host"];
    NSString *password = dict[@"Password"];
    NSInteger port = [dict[@"Port"] integerValue];
    NSString *username = dict[@"Username"];
    ICEServer *ICEServerOb = [ICEServer new];
    ICEServerOb.host = host;
    ICEServerOb.password = password;
    ICEServerOb.port = port;
    ICEServerOb.username = username;
    return ICEServerOb;
}
- (NSMutableDictionary *)toJSON
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:4];
    [dic setObject:_host forKey:@"Host"];
    [dic setObject:_password forKey:@"Password"];
    [dic setObject:_username forKey:@"Username"];
    [dic setObject:[NSNumber numberWithInteger:_port] forKey:@"Port"];
    return dic;
}

@end


@implementation CubeHttpServer

+ (CubeHttpServer *)cubeHttpServerParse:(NSDictionary *)dict
{
    NSInteger HTTPPort = [dict[@"HTTPPort"] integerValue];
    NSString *host = dict[@"Host"];
    NSInteger SSLPort = [dict[@"SSLPort"] integerValue];
    CubeHttpServer *cubeHttpServer = [CubeHttpServer new];
    cubeHttpServer.HTTPPort = HTTPPort;
    cubeHttpServer.host = host;
    cubeHttpServer.SSLPort = SSLPort;
    return cubeHttpServer;
}
- (NSMutableDictionary *)toJSON
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:3];
    [dic setObject:[NSNumber numberWithInteger:_HTTPPort] forKey:@"HTTPPort"];
    [dic setObject:_host forKey:@"Host"];
    [dic setObject:[NSNumber numberWithInteger:_SSLPort] forKey:@"SSLPort"];
    
    return dic;
}

@end

@implementation BackupServer

+ (BackupServer *)backupServerParse:(NSDictionary *)dict
{
    NSInteger HTTPPort = [dict[@"HTTPPort"] integerValue];
    NSString *host = dict[@"Host"];
    NSInteger TCPPort = [dict[@"TCPPort"] integerValue];
    
    BackupServer *object = [BackupServer new];
    object.HTTPPort = HTTPPort;
    object.host = host;
    object.TCPPort = TCPPort;
    
    return object;
}
- (NSMutableDictionary *)toJSON
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:3];
    
    [dic setObject:[NSNumber numberWithInteger:_HTTPPort] forKey:@"HTTPPort"];
    [dic setObject:_host forKey:@"Host"];
    [dic setObject:[NSNumber numberWithInteger:_TCPPort] forKey:@"TCPPort"];
    return dic;
}

@end
@implementation BackupHttpServer

+ (BackupHttpServer *)backupHttpServerParse:(NSDictionary *)dict
{
    
    NSInteger HTTPPort = [dict[@"HTTPPort"] integerValue];
    NSString *host = dict[@"Host"];
    NSInteger SSLPort = [dict[@"SSLPort"] integerValue];
    
    BackupHttpServer *object = [BackupHttpServer new];
    object.HTTPPort = HTTPPort;
    object.host = host;
    object.SSLPort = SSLPort;
    return object;
}
- (NSMutableDictionary *)toJSON
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:2];
    [dic setObject:[NSNumber numberWithInteger:_HTTPPort] forKey:@"HTTPPort"];
    [dic setObject:_host forKey:@"Host"];
    [dic setObject:[NSNumber numberWithInteger:_SSLPort] forKey:@"SSLPort"];
    
    return dic;
}

@end
@implementation CubeLicense
+ (CubeLicense *)licenseParse:(NSDictionary *)dict
{
    NSLog(@"dict = %@",dict);
    NSString *ConfigVersion = dict[@"ConfigVersion"];
    NSString *AppKey = dict[@"AppKey"];
    NSString *AppId = dict[@"AppId"];
    long BeginNumber = [dict[@"BeginNumber"] longValue];
    long EndNumber = [dict[@"EndNumber"] longValue];
    long long BeginDate = [dict[@"BeginDate"] longLongValue];
    long long EndDate = [dict[@"EndDate"] longLongValue];
    
    CubeServer *cubeServer = [CubeServer cubeServerDict:dict[@"CubeServer"]];
    CubeHttpServer *cubeHTTPServer = [CubeHttpServer cubeHttpServerParse:dict[@"CubeHttpServer"]];
    NSDictionary *ConferenceDic = dict[@"Conference"];
    BackupServer *backupServer = [BackupServer backupServerParse:dict[@"BackupServer"]];
    BackupHttpServer *backupHttpServer = [BackupHttpServer backupHttpServerParse:dict[@"BackupHttpServer"]];
    NSDictionary *backupConferenceDic = dict[@"BackupConference"];
    NSArray *permissionArray = dict[@"Permissions"];
    NSDictionary *companyDic = dict[@"Company"];
    NSString *version = dict[@"Version"];
    NSString *createTime = dict[@"CreateTime"];
    NSMutableArray *ICEServerArray = [[NSMutableArray alloc] initWithCapacity:2];
    for (NSDictionary *iceServerDic in dict[@"ICEServers"])
    {
        ICEServer *ICEServerObject = [ICEServer ICEServerParse:iceServerDic];
        [ICEServerArray addObject:ICEServerObject];
        
    }
    
    CubeLicense *license = [[CubeLicense alloc] init];
    license.configVersion = ConfigVersion;
    license.appKey = AppKey;
    license.appId = AppId;
    license.beginNumber = BeginNumber;
    license.endNumber = EndNumber;
    license.beginDate = BeginDate;
    license.endDate = EndDate;
    license.cubeServer = cubeServer;
    license.cubeHttpServer = cubeHTTPServer;
    license.conferenceDic = ConferenceDic;
    license.backupServer = backupServer;
    license.backupHttpServer = backupHttpServer;
    license.backupConferenceDic = backupConferenceDic;
    license.permissionArray = permissionArray;
    license.companyDic = companyDic;
    license.version = version;
    license.createTime = [createTime longLongValue];
    license.ICEServers = ICEServerArray;
    
    
    return license;
}
- (NSMutableDictionary *)toJSON
{
    NSMutableDictionary *licenseDic = [[NSMutableDictionary alloc] init];
    [licenseDic setObject:_configVersion forKey:@"ConfigVersion"];
    [licenseDic setObject:_appKey forKey:@"AppKey"];
    [licenseDic setObject:_appId forKey:@"AppId"];
    [licenseDic setObject:[NSNumber numberWithLong:_beginNumber] forKey:@"BeginNumber"];
    [licenseDic setObject:[NSNumber numberWithLong:_endNumber] forKey:@"EndNumber"];
    [licenseDic setObject:[NSNumber numberWithLongLong:_beginDate] forKey:@"BeginDate"];
    [licenseDic setObject:[NSNumber numberWithLongLong:_endDate] forKey:@"EndDate"];
    [licenseDic setObject:[_cubeServer toJSON] forKey:@"CubeServer"];
    [licenseDic setObject:[_cubeHttpServer toJSON] forKey:@"CubeHttpServer"];
    [licenseDic setObject:_conferenceDic forKey:@"Conference"];

    [licenseDic setObject:[_backupHttpServer toJSON] forKey:@"BackupHttpServer"];
    [licenseDic setObject:_backupConferenceDic forKey:@"BackupConference"];
    [licenseDic setObject:_permissionArray forKey:@"Permissions"];
    [licenseDic setObject:_companyDic forKey:@"Company"];
    [licenseDic setObject:_version forKey:@"Version"];
    [licenseDic setObject:[NSNumber numberWithLongLong:_createTime] forKey:@"CreateTime"];
    
    NSMutableArray *ICEArray = [NSMutableArray arrayWithCapacity:2];
    for (ICEServer *ICEServerObject in _ICEServers) {
        [ICEArray addObject:[ICEServerObject toJSON]];
    }
    [licenseDic setObject:ICEArray forKey:@"ICEServers"];
    
    return licenseDic;
}

@end

