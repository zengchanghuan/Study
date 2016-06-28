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

@interface XZRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *recommendTableView;
@property (strong, nonatomic) NSArray *recommendList;
@end

@implementation XZRecommendViewController
static NSString * const XZRecommendId = @"recommendId";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.recommendTableView registerNib:[UINib nibWithNibName:NSStringFromClass([XZRecommendCell class]) bundle:nil] forCellReuseIdentifier:XZRecommendId];
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
        XZLog(@"%@",responseObject);
        self.recommendList = [XZRecommend mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        
        [self.recommendTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
     
    
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.recommendList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XZRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:XZRecommendId];
    cell.recommend = self.recommendList[indexPath.row];
    return cell;
}
@end
