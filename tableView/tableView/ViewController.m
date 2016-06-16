//
//  ViewController.m
//  tableView
//
//  Created by ZengChanghuan on 16/6/16.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *table = [UITableView new];
    table.frame = self.view.bounds;
    table.dataSource = self;
    [self.view addSubview:table];
}

#pragma mark -UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //先根据cell的标识去缓存池中查找可循环利用的cell
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    
    //如果cell为nil
    if (cell ==  nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"test%zd",indexPath.row];
    NSLog(@"%p  %zd",cell,indexPath.row);
    return cell;
}
#pragma makr -UITableViewDelegate

@end
