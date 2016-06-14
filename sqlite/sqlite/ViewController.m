//
//  ViewController.m
//  sqlite
//
//  Created by ZengChanghuan on 16/6/1.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "ViewController.h"
#import <sqlite3.h>
@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *priceField;
 //数据库对象实例
@property (assign, nonatomic) sqlite3 *db;
- (IBAction)insert;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //打开数据库，连接数据库
    
    NSString *filename = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"shops.sqlite"];
    
    //如果数据库文件不存在，系统会自动创建文件初始化数据库
    
   
    int status = sqlite3_open(filename.UTF8String, &_db);
    
    if (status == SQLITE_OK) {
        NSLog(@"打开数据库成功");
        //创表
        const char *sql ="create table if not exists t_shop (id integer primary key,name text not null,price real);";
        char *errmsg = NULL;
        sqlite3_exec(self.db,sql, NULL, NULL, &errmsg);
        
        if (errmsg) {
            NSLog(@"创表失败--%s",errmsg);
        }

    } else {
        NSLog(@"打开数据库失败");
    }
  
    
    
    
    //创建表格
    
    //关闭数据库
    //sqlite3_close(<#sqlite3 *#>)
}

- (IBAction)insert {
    
    NSString *sql = [NSString stringWithFormat:@"insert into t_shop (name,price) values ('%@',%f)",self.nameField.text,self.priceField.text.doubleValue];
    sqlite3_exec(self.db, sql.UTF8String, NULL, NULL, NULL);
}
@end
