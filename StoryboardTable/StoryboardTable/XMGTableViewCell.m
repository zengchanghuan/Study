//
//  XMGTableViewCell.m
//  StoryboardTable
//
//  Created by ZengChanghuan on 16/6/17.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XMGTableViewCell.h"
#import "XMGDeal.h"
@interface XMGTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *priceLable;
@property (weak, nonatomic) IBOutlet UILabel *buy;


@end
@implementation XMGTableViewCell

-(void)setDeal:(XMGDeal *)deal
{
    _deal = deal;
    
    self.iconView.image = [UIImage imageNamed:deal.icon];
    self.titleLable.text = deal.title;
    self.priceLable.text = deal.price;
    self.buy.text = deal.buyCount;
}
@end
