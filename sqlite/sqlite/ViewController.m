//
//  ViewController.m
//  sqlite
//
//  Created by ZengChanghuan on 16/6/1.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "ViewController.h"
#import <sqlite3.h>
#import "XZShop.h"
@interface ViewController ()<UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *priceField;
@property (strong, nonatomic) NSMutableArray *shopArray;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
 //数据库对象实例
@property (assign, nonatomic) sqlite3 *db;
- (IBAction)insert;

@end

@implementation ViewController

- (NSMutableArray *)shops
{
    if (!_shopArray) {
        self.shopArray = [[NSMutableArray alloc] init];
        
    }
    return _shopArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDB];
    [self setupData];
}

// 初始化数据库
- (void)setupDB
{
    //打开数据库，连接数据库
    
    NSString *filename = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"shops.sqlite"];
    NSLog(@"filename = %@",filename);
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

/**
 *  查询数据
 */
- (void)setupData
{
    const char *sql = "select name,price from t_shop;";
    //取出查询结果的
    sqlite3_stmt *stmt = NULL;
    int status = sqlite3_prepare_v2(self.db, sql, -1, &stmt, NULL);
    while (status == SQLITE_OK) {
        if (sqlite3_step(stmt) == SQLITE_ROW) {
            const  char *name = (const char *)sqlite3_column_text(stmt, 0);
            const  char *price = (const char *)sqlite3_column_text(stmt, 1);
            XZShop *shop = [[XZShop alloc] init];
            shop.name = [NSString stringWithUTF8String:name];
            shop.price = [NSString stringWithUTF8String:price];
            [_shopArray addObject:shop];
            NSLog(@"%s %s",name,price);
        }
    }
}
- (IBAction)insert {
    
    NSString *sql = [NSString stringWithFormat:@"insert into t_shop (name,price) values ('%@',%f)",self.nameField.text,self.priceField.text.doubleValue];
    sqlite3_exec(self.db, sql.UTF8String, NULL, NULL, NULL);
    XZShop *shop = [XZShop new];
    shop.name = self.nameField.text;
    shop.price = self.priceField.text;
    [_shopArray addObject:shop];
    [self.tableView reloadData];
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _shopArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"shop";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    XZShop *shop = _shopArray[indexPath.row];
    cell.textLabel.text = shop.name;
    cell.detailTextLabel.text = shop.price;
    return cell;
}
@end
