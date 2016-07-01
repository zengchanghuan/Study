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
#import "XZCollectionViewCell.h"

static NSString *const ID = @"image";

@interface XZHomeViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UITableView *contentTableView;
@property (nonatomic, strong) XZHomeHeaderView *headerView;
@property (nonatomic, strong) XZHomeFooterView *footerView;

@end

@implementation XZHomeViewController

#pragma life clcle

- (void)loadView{
    _contentTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _contentTableView.delegate = self;
    _contentTableView.dataSource = self;
    self.view = _contentTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNav];
    self.contentTableView.tableHeaderView = [self headerView];
    self.contentTableView.tableFooterView = [self footerView];
}


#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        XZHomeLiveTableViewCell *cell1 = [XZHomeLiveTableViewCell cellWithTableView:tableView];
        cell1.collectionView.dataSource = self;
        cell1.collectionView.delegate = self;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300;
}


- (XZHomeHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[XZHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 226)];
    }
    return _headerView;
}

- (XZHomeFooterView *)footerView{
    if (!_footerView) {
        _footerView = [[XZHomeFooterView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 120)];
    }
    return _footerView;
}

#pragma mark -setupNav
- (void)setupNav{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStyleDone target:self action:@selector(login)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStyleDone target:self action:@selector(search)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)login{
    XZLogRegisterViewController *login = [XZLogRegisterViewController new];
    XZNavigationController *na = [[XZNavigationController alloc] initWithRootViewController:login];
    [self presentViewController:na animated:YES completion:nil];
}

- (void)search
{
    
}
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XZCollectionViewCell *liveCell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    return liveCell;
}

#pragma mark UICollectionViewDelegate
@end
