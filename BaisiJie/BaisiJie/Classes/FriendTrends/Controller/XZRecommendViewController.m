//
//  XZRecommendViewController.m
//  BaisiJie
//
//  Created by ZengChanghuan on 16/6/28.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZRecommendViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "XZRecommendCell.h"
#import "XZRecommend.h"
#import <MJExtension.h>
#import "XZRecommendUser.h"
#import "XZRecommendUserCellTableViewCell.h"
@interface XZRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *recommendTableView;
@property (strong, nonatomic) NSArray *recommendList;
@property (nonatomic, strong) NSArray *users;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

@end

@implementation XZRecommendViewController
static NSString * const XZRecommendId = @"recommendId";
static NSString * const XZRecommendUserId = @"user";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.recommendTableView registerNib:[UINib nibWithNibName:NSStringFromClass([XZRecommendCell class]) bundle:nil] forCellReuseIdentifier:XZRecommendId];
    
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([XZRecommendUserCellTableViewCell class]) bundle:nil] forCellReuseIdentifier:XZRecommendUserId];

    // 设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.recommendTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.recommendTableView.contentInset;
    self.userTableView.rowHeight = 70;
    
    self.title = @"推荐关注";
    
    self.view.backgroundColor = XZGlobalBg;
    
    // 显示指示器
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
  
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        self.recommendList = [XZRecommend mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        
        [self.recommendTableView reloadData];
        [self.recommendTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
     
    
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.recommendTableView) {
        return self.recommendList.count;

    } else {
        XZRecommend *r = self.recommendList[self.recommendTableView.indexPathForSelectedRow.row];
        
        return r.users.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.recommendTableView) {
        XZRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:XZRecommendId];
        cell.recommend = self.recommendList[indexPath.row];
        return cell;
    } else {
        XZRecommendUserCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.users[indexPath.row]];
        XZRecommend *c = self.recommendList[self.recommendTableView.indexPathForSelectedRow.row];
        cell.user = c.users[indexPath.row];
        return cell;
    }
}


#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XZRecommend *c = self.recommendList[indexPath.row];
    
    
    if (c.users.count) {
        // 显示曾经的数据
        [self.userTableView reloadData];
    } else {
        // 发送请求给服务器, 加载右侧的数据
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"list";
        params[@"c"] = @"subscribe";
        params[@"categoryzz_id"] = @(c.id);
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            // 字典数组 -> 模型数组
            NSArray *users = [XZRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            
            // 添加到当前类别对应的用户数组中
            [c.users addObjectsFromArray:users];
            
            for (XZRecommendUser *user in c.users) {
                XZLog(@"******screen_name = %@",user.screen_name);
            }
            // 刷新右边的表格
            [self.userTableView reloadData];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            XZLog(@"%@", error);
        }];
    }

}
@end
