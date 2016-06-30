//
//  XZHomeViewController.m
//  SportClub
//
//  Created by ZengChanghuan on 16/6/12.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZHomeViewController.h"
#import "XZLogRegisterViewController.h"
#import "XZNavigationController.h"
#import "XZHomeHeaderView.h"
#import "XZHomefooterView.h"
#import "XZHomeLiveTableViewCell.h"
#import "XZRedTimelineTableViewCell.h"
#import "XZMomentsTableViewCell.h"
/*
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS
*/
#import "Masonry.h"
@interface XZHomeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
}
@property (nonatomic, strong) UITableView *contentTableView;
@property (nonatomic, strong) XZHomeHeaderView *headerView;
@property (nonatomic, strong) XZHomefooterView *footerView;
@end

@implementation XZHomeViewController

#pragma life clcle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNav];
}

- (void)loadView{
    _contentTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _contentTableView.delegate = self;
    _contentTableView.dataSource = self;
//    [_contentTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"GroupCellID"];
    self.view = _contentTableView;
    
}

#pragma mark -setupNav
- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStyleDone target:self action:@selector(login)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStyleDone target:self action:@selector(search)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)login
{
    XZLogRegisterViewController *login = [XZLogRegisterViewController new];
    XZNavigationController *na = [[XZNavigationController alloc] initWithRootViewController:login];
    [self presentViewController:na animated:YES completion:nil];
}

- (void)search
{
    
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *cellId = @"GroupCellID";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//    cell.textLabel.text = [NSString stringWithFormat:@"组%ld -- 行%ld", indexPath.section, indexPath.row];
//    return cell;

    
    if (indexPath.row == 0) {
        XZHomeLiveTableViewCell *cell1 = [XZHomeLiveTableViewCell cellWithTableView:tableView];
        return cell1;
    } else if (indexPath.row == 1) {
        XZRedTimelineTableViewCell *cell2 = [XZRedTimelineTableViewCell cellWithTableView:tableView];
        return cell2;
    } else {
        XZMomentsTableViewCell *cell3= [XZMomentsTableViewCell cellWithTableView:tableView];
        return cell3;
    }


    
    

}

#pragma mark UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    _headerView = [[XZHomeHeaderView alloc] init];

    return _headerView;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    _footerView = [XZHomefooterView new];
    return _footerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 300;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 226;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 120;
}
@end
