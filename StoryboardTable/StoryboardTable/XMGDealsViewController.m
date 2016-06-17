//
//  XMGDealsViewController.m
//  StoryboardTable
//
//  Created by ZengChanghuan on 16/6/17.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XMGDealsViewController.h"
#import "XMGDeal.h"
#import "XMGTableViewCell.h"
@interface XMGDealsViewController()

@property (nonatomic, strong) NSArray *deals;

@end

@implementation XMGDealsViewController

- (NSArray *)deals
{
    if (_deals == nil) {
        // 加载plist中的字典数组
        NSString *path = [[NSBundle mainBundle] pathForResource:@"deals.plist" ofType:nil];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        
        // 字典数组 -> 模型数组
        NSMutableArray *dealArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            XMGDeal *deal = [XMGDeal dealWithDict:dict];
            [dealArray addObject:deal];
        }
        
        _deals = dealArray;
    }
    return _deals;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.deals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    static NSString *ID = @"deal";
    XMGTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    cell.deal = self.deals[indexPath.row];
    
    return cell;
}
@end
