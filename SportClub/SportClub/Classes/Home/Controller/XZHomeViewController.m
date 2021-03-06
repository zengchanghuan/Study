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
#import "XZMomentsTitleViewCell.h"

@interface XZHomeViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UITableView *contentTableView;
@property (nonatomic, strong) XZHomeHeaderView *headerView;
@property (nonatomic, strong) XZHomeFooterView *footerView;
@property (strong, nonatomic) NSMutableArray *imagesArray;

@end

@implementation XZHomeViewController
-(NSMutableArray *)imagesArray
{
    if (!_imagesArray) {
        self.imagesArray = [[NSMutableArray alloc] init];
        
        for (int i = 1; i<=4; i++) {
            [self.imagesArray addObject:[NSString stringWithFormat:@"%d", i]];
        }
    }
    return _imagesArray;
}
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
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        XZHomeLiveTableViewCell *cell1 = [XZHomeLiveTableViewCell cellWithTableView:tableView];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        cell1.collectionView.dataSource = self;
        cell1.collectionView.delegate = self;
        return cell1;
    } else if (indexPath.row == 1) {
        XZRedTimelineTableViewCell *cell2 = [XZRedTimelineTableViewCell cellWithTableView:tableView];
        return cell2;
    } else if (indexPath.row == 2) {
        XZMomentsTitleViewCell *cell3 = [XZMomentsTitleViewCell cellWithTableView:tableView];
        return cell3;
    } else {
        XZMomentsTableViewCell *cell4= [XZMomentsTableViewCell cellWithTableView:tableView];
        return cell4;
    }
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 282;
    } else if (indexPath.row == 1) {
        return 420;
    } else if (indexPath.row == 2){
        return 45;
    } else {
        return 164;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return;
}

- (XZHomeHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[XZHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 226)];
    }
    return _headerView;
}

- (XZHomeFooterView *)footerView{
    if (!_footerView) {
        
        _footerView = [XZHomeFooterView footer];
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
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XZCollectionViewCell *liveCell = [collectionView dequeueReusableCellWithReuseIdentifier:XZMyCollectionViewIdentifier forIndexPath:indexPath];
    return liveCell;
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XZLog(@"indexPath.row = %ld",(long)indexPath.row);
}



@end
