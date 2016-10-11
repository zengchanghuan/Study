//
//  ViewController.m
//  CubeTest
//
//  Created by ZengChanghuan on 16/8/1.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "ViewController.h"
#import "ZipArchiveUtils.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#define CACHE_DIR_PATH [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

@interface ViewController ()
{
    NSString *_licensejsonCachePath;
    //音效声音的唯一标示ID
    SystemSoundID mysound;
    ViewController __weak *weakSelf;
}
@end

@implementation ViewController

long long factorial(long value)
{
    if (value == 1) {
        return value;
    } else {
        return value * factorial(value - 1);
    }
}

int64_t f(int *a)
{
    int64_t sum = 0;
    for (int i = 99; i > -1;i--)
    {
        sum += a[i];
    }
    return sum;
}

int64_t g(int *a)
{
    int64_t sum = 0;
    for (int i = 0; i < 100; i++) {
        sum += a[i];
    }
    return sum;
}
- (void)testBlock
{
    static int count = 1;
    __weak __typeof(self) weak_self = self;
    [UIView animateWithDuration:0 animations:^{
        //比如这里请求成功
    } completion:^(BOOL finished) {
        //这里请求失败
        if (count <= 3)
        {
            NSLog(@"请求的第%d次",count);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                count++;
                [weak_self testBlock];
            });
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //可以使用AVAudioSession这个类提供的中断通知来处理各种音频的中断事件.并且系统提供了AVAudioPlayer和AVAudioRecorder的代理.
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *activationError = nil;

    //AVAudioSessionCategoryPlayAndRecord 或 kAudioSessionCategory_PlayAndRecord——用于既需要播放声音又需要录音的应用，语音聊天应用(如微信）应该使用这个category。
    

    //配置你的AudioSession使他允许混音,使用AVAudioSessionCategoryAmbient这个类别
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&activationError];
    BOOL success = [session setActive:YES error:&activationError];
    if (!success) {
        NSLog(@"sessionError = %@",activationError);
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AudioInterruption:) name:AVAudioSessionInterruptionNotification object:session];

    weakSelf = self;

    [self playSoundEffect];
    [self timer];

//    NSDate* tmpStartData = [NSDate date];
//    //You code here...
//    int a = 1;
//    NSLog(@" f = %lld",f(&a));
//    double deltaTime = [[NSDate date] timeIntervalSinceDate:tmpStartData];
//    NSLog(@"cost time = %f", deltaTime);
    
//    NSDate* tmpStartData2 = [NSDate date];
//    //You code here...
//    NSLog(@" g = %lld",g(&a));
//    double deltaTime2 = [[NSDate date] timeIntervalSinceDate:tmpStartData];
//    NSLog(@"cost time = %f", deltaTime2);
 
}
- (void)AudioInterruption:(id)notification
{
    NSLog(@"notification = %@",notification);
    AVAudioSessionInterruptionType interruptionType = [[[notification userInfo]
                                                        objectForKey:AVAudioSessionInterruptionTypeKey] unsignedIntegerValue];
    
    if (AVAudioSessionInterruptionTypeBegan == interruptionType)
    {
        NSLog(@"Session interrupted: --- Begin Interruption ---");
    }
    else if (AVAudioSessionInterruptionTypeEnded == interruptionType)
    {
        NSLog(@"Session interrupted: --- End Interruption ---");
    }
}
#pragma mark -音效
/* 音效播放完成的回调函数，这个是C语言函数，第一个参数是音效ID，第二个是万能参数 */
void soundCompleteCallBack(SystemSoundID mysound, void *clientData)
{
    
    NSLog(@"播放完成");
//    AudioServicesPlaySystemSound(mysound);
}
- (void)playSoundEffect
{
    NSString *name = @"oldphone.wav";
    
    //获取音效文件路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    //创建音效文件URL
    NSURL *fileUrl = [NSURL URLWithString:filePath];
    //音效声音的唯一标示ID
    mysound = 0;
    //将音效加入到系统音效服务中，NSURL需要桥接成CFURLRef，会返回一个长整形ID，用来做音效的唯一标示
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &mysound);
    //设置音效播放完成后的回调C语言函数
    AudioServicesAddSystemSoundCompletion(mysound,NULL,NULL,soundCompleteCallBack,NULL);
    
//    AudioServicesPlaySystemSound(mysound);

    
}
- (void)timer
{
     NSTimer *timer = [NSTimer timerWithTimeInterval:2.5 target:self selector:@selector(play) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

}
- (void)play
{
    //开始播放音效
    AudioServicesPlaySystemSound(mysound);
}
- (void)dealloc
{
    AudioServicesDisposeSystemSoundID(mysound);
}
- (void)scsAudioTest
{
    SystemSoundID soundID = 1;
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)([[NSBundle mainBundle] URLForResource:@"oldphone.wav" withExtension:nil]), &soundID);
    AudioServicesPlayAlertSound(soundID);

}
- (void)base64Test
{
    /*
     NSString *base64Encoded = [self stringEncode];
     NSString *base64Decoded = [self stingDecode:base64Encoded];
     
     NSString *name = [NSString stringWithFormat:@"%s", __FILE__];
     NSRange range = [name rangeOfString:[name lastPathComponent]];
     NSString *jsonPath = [[name substringToIndex:range.location] stringByAppendingString:@"CubeEncipher.license"];
     NSData *data = [NSData dataWithContentsOfFile:jsonPath];
     NSString *licenseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
     NSLog(@"licenseString = %@",licenseString);
     
     NSString *base64DecodedString = [self stingDecode:licenseString];
     NSLog(@"base64DecodedString = %@",base64DecodedString);
     */
}
- (NSString *)stringEncode
{
    NSString *name = [NSString stringWithFormat:@"%s", __FILE__];
    NSRange range = [name rangeOfString:[name lastPathComponent]];
    NSString *jsonPath = [[name substringToIndex:range.location] stringByAppendingString:@"cube.license.original"];
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    NSString *licenseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    //    NSLog(@"jsonDict = %@", jsonDict);
        NSLog(@"licenseString = %@",licenseString);
    
    // Create NSData object
    NSData *licenseData = [licenseString dataUsingEncoding:NSUTF8StringEncoding];
    
    // Get NSString from NSData object in Base64
    NSString *base64Encoded = [licenseData base64EncodedStringWithOptions:0];
    
    // Print the Base64 encoded string
    NSLog(@"Encoded: %@", base64Encoded);
    return base64Encoded;

}

- (NSString *)stingDecode:(NSString *)base64Encoded
{
    // NSData from the Base64 encoded str
    NSData *nsdataFromBase64String = [[NSData alloc]
                                      initWithBase64EncodedString:base64Encoded options:0];
    
    // Decoded NSString from the NSData
    NSString *base64Decoded = [[NSString alloc]
                               initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
    NSLog(@"Decoded: %@", base64Decoded);
    return base64Decoded;
}
//- (void)decrypt:(NSString *)path {
//    //解密
//    char key[9] = {'c', 'u', 'b', 'e', 't', 'e', 'a', 'm', '\0'};
//    
//}
-(void)urlRequestOperation{
    NSString *URLTmp = @"http://ip.taobao.com/service/getIpInfo.php?ip=myip";
    NSString *URLTmp1 = [URLTmp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];  //转码成UTF-8  否则可能会出现错误
    //    [URLTmp stringByAddingPercentEncodingWithAllowedCharacters:(nonnull NSCharacterSet *)]
    URLTmp = URLTmp1;
    NSURLRequest *request =
    [NSURLRequest requestWithURL:[NSURL URLWithString: URLTmp]];
    NSData *receiveData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *dataString = [[NSString alloc] initWithData:receiveData encoding:NSUTF8StringEncoding];
    NSData *resData = [[NSData alloc] initWithData:[dataString dataUsingEncoding:NSUTF8StringEncoding]];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
    NSString *city = [[dic objectForKey:@"data"] objectForKey:@"city"];
    NSLog(@"VC CICY = %@",city);
    
    
}

- (void)test5
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cube" ofType:@"license"];
    
    NSData *base64Data = [NSData dataWithContentsOfFile:path];
    
    NSString *str = [[NSString alloc] initWithData:base64Data encoding:NSUTF8StringEncoding];
}
- (void)test4
{
    NSData *dataTake2 =
    [@"iOS Developer Tips" dataUsingEncoding:NSUTF8StringEncoding];
    
    // Convert to Base64 data
    NSData *base64Data = [dataTake2 base64EncodedDataWithOptions:0];
    NSLog(@"%@", [NSString stringWithUTF8String:[base64Data bytes]]);
    
    // Do something with the data
    // ...
    
    // Now convert back from Base64
    NSData *nsdataDecoded = [base64Data initWithBase64EncodedData:base64Data options:0];
    NSString *str = [[NSString alloc] initWithData:nsdataDecoded encoding:NSUTF8StringEncoding];
    NSLog(@"%@", str);
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cube" ofType:@"license"];
    NSData *base64Data2 = [NSData dataWithContentsOfFile:path];
    
    NSData *nsdataDecoded2 = [base64Data2 initWithBase64EncodedData:base64Data2 options:0];
}
- (void)test3{
    NSString *string = @"滴滴和Uber合并后已没有明显的竞争对手，首要任务当然是内部消化，集中力量应对新政，但长远战略未必聚焦于专车，新政已将出租车定义为城市公共交通的补充，网约车则是差异化服务，不仅数量要控制，更要给出租车留下生存空间，这也意味着低端化专快车产品的商业前景有限，不足以支撑新公司估值的增长空间，未来滴滴和Uber必然加速转向汽车衍生业务。";
    [self writeFileNoFolder:string];
    [self unzipTestOk];
    NSLog(@"timestamp = %@",[self timestamp]);

}
- (NSString *)timestamp
{
     NSString *timestamp = [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]*1000];
    return timestamp;
    
}
- (void)writeFileNoFolder:(NSString *)str
{
    NSString *fileName = [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]*1000];
    NSString *tmpPath = [self dirTmp];
    NSLog(@"tmpPath = %@",tmpPath);
    BOOL finish = [str writeToFile:[tmpPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.wb",fileName]] atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if (finish) {
        NSLog(@"createWhiteboardMessageFile 写入成功");
        
        //读内容
        NSString *path = [tmpPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.wb",fileName]];
//        NSLog(@"path = %@",path);
        NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"content = %@",content);
    }else{
        NSLog(@"createWhiteboardMessageFile 写入错误");
    }
}

- (void)readFile:(NSString *)path
{
    
}
//先创建以前时间命名的文件夹，然后在文件夹写入以当前时间命名的文件，测试ok
- (void)writeFile:(NSString *)whileboardMessage
{
    NSString *fileName = [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
    NSString *tmpPath = [self dirTmp];
    NSString *path = [tmpPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",fileName]];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        BOOL finish = [fileManager createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
        if (finish) {
            NSLog(@"createWhiteboardMessageFile 创建成功");
        }else{
            
            NSLog(@"createWhiteboardMessageFile 失败");
            
        }
    }
    NSError *error = nil;
    BOOL finish = [whileboardMessage writeToFile:[path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.wb",fileName]] atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (finish) {
        NSLog(@"createWhiteboardMessageFile 写入成功");
        [self iszipTestok:path withZipFolderName:fileName];
    }else{
        NSLog(@"createWhiteboardMessageFile 写入错误%@", error);
    }

}
//压缩测试ok
- (void)iszipTestok:(NSString *)path withZipFolderName:(NSString *)folderName
{
    NSString *tmpPath = [self dirTmp];
//    NSString *path = [tmpPath stringByAppendingPathComponent:@"1470106391"];
    NSString *file = [tmpPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.cwb",folderName]];
    
    BOOL isZip = [ZipArchiveUtils createZipFileAtPath:file withContentsOfDirectory:path keepParentDirectory:YES];
    if (isZip) {
        NSLog(@"ok");
    } else {
        NSLog(@"fail");
    }

}
//解压缩测试ok
- (void)unzipTestOk
{
    NSString *tmpPath = [self dirTmp];
    NSString *path = [tmpPath stringByAppendingPathComponent:@"1470400712.wb"];
    
    NSString *file = [tmpPath stringByAppendingPathComponent:[NSString stringWithFormat:@"1470400712/%@",@"1470400712.wb"]];
    NSLog(@"file = %@",file);
    BOOL isUnzip = [ZipArchiveUtils unzipFileAtPath:path toDestination:tmpPath];
    if (isUnzip) {
        NSLog(@"ok");
        NSString *str = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"str = %@",str);
    } else {
        NSLog(@"fail");
    }

}



- (NSString *)dirTmp
{
    return NSTemporaryDirectory();

}
- (void)test2
{
    NSString *flodName = [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
    
    NSString *dirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:flodName];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:dirPath]) {
        BOOL finish = [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:NO attributes:nil error:nil];
        if (finish) {
            NSLog(@"创建成功");
        }else{
            NSLog(@"失败");
        }
    }
    
    NSError *error = nil;
    BOOL finish = [@"my name is hahah" writeToFile:[dirPath stringByAppendingPathComponent:@"zengchanghuan.txt"] atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (finish) {
        NSLog(@"成功");
    }else{
        NSLog(@"%@", error);
    }

}
- (NSString *)getFolderName
{
    long time = [[NSDate date]timeIntervalSince1970]*1000;
    
    return [[NSNumber numberWithLong:time]stringValue];
    
}
- (void)test
{
    //对于错误信息
    
    NSError *error;
    
    // 创建文件管理器
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    //指向文件目录
    
    NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    
    //创建一个目录
    
    [fileMgr createDirectoryAtPath: [NSString stringWithFormat:@"%@/myFolder", NSHomeDirectory()] attributes:nil];
    
    
    // File we want to create in the documents directory我们想要创建的文件将会出现在文件目录中
    
    // Result is: /Documents/file1.txt结果为：/Documents/file1.txt
    
    NSString *filePath= [documentsDirectory stringByAppendingPathComponent:@"file2.txt"];
    NSLog(@"filePath = %@",filePath);
    
    //需要写入的字符串
    
    NSString *str= @"iPhoneDeveloper Tips\n,com";
    
    //写入文件
    
    [str writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    //显示文件目录的内容
    
    NSLog(@"Documentsdirectory: %@",[fileMgr contentsOfDirectoryAtPath:documentsDirectory error:&error]);
}
@end
