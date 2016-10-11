//
//  ViewController.m
//  UITableView多组
//
//  Created by ZengChanghuan on 16/9/7.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

#pragma  mark - UITableViewDataSource
/**
 *  告诉tableView第section组有多少行
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    } else if (section == 1) {
        return 4;
    } else if (section == 2) {
        return 2;
    } else {
        return 2;
    }
}

/**
 *  告诉tableView一共有多少组数据
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

/**
 *  告诉tableView第indexPath行显示怎样的cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    if (indexPath.section == 0) { // 第0组
        if (indexPath.row == 0) {
            cell.textLabel.text = @"奥迪";
            cell.imageView.image = [UIImage imageNamed:@"m_9_100"];
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"宝马";
            cell.imageView.image = [UIImage imageNamed:@"m_3_100"];
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"奔驰";
            cell.imageView.image = [UIImage imageNamed:@"m_2_100"];
        }
    } else if (indexPath.section == 1) { // 第1组
        if (indexPath.row == 0) {
            cell.textLabel.text = @"本田";
            cell.imageView.image = [UIImage imageNamed:@"m_4_100"];
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"马自达";
            cell.imageView.image = [UIImage imageNamed:@"m_5_100"];
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"三菱";
            cell.imageView.image = [UIImage imageNamed:@"m_6_100"];
        } else if (indexPath.row == 3) {
            cell.textLabel.text = @"丰田";
            cell.imageView.image = [UIImage imageNamed:@"m_7_100"];
        }
    } else if (indexPath.section == 2) { // 第2组
        if (indexPath.row == 0) {
            cell.textLabel.text = @"红旗";
            cell.imageView.image = [UIImage imageNamed:@"m_18_100"];
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"比亚迪";
            cell.imageView.image = [UIImage imageNamed:@"m_19_100"];
        }
    } else if (indexPath.section == 3) { // 第3组
        if (indexPath.row == 0) {
            cell.textLabel.text = @"法拉利";
            cell.imageView.image = [UIImage imageNamed:@"m_21_100"];
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"兰博基尼";
            cell.imageView.image = [UIImage imageNamed:@"m_28_100"];
        }
    }
    
    return cell;
}

/**
 *  告诉tableView第section组的头部标题
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"德系";
    } else if (section == 1) {
        return @"日系";
    } else if (section == 2) {
        return @"天系";
    } else {
        return @"意系";
    }
}

/**
 *  告诉tableView第section组的尾部标题
 */
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return @"德系车6666";
    } else if (section == 1) {
        return @"日系车日系车日系车日系车日系车日系车日系车日系车日系车日系车SB";
    } else if (section == 2) {
        return @"天系车NNNN";
    } else {
        return @"意系车NNNN";
    }
}
@end
