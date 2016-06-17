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
@property (weak, nonatomic)  UIImageView *iconView;

@property (weak, nonatomic)  UILabel *titleLable;
@property (weak, nonatomic)  UILabel *priceLable;
@property (weak, nonatomic)  UILabel *buy;


@end
@implementation XMGTableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"deal";
    XMGTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (cell == nil) {
//        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XMGTableViewCell class]) owner:nil options:nil] lastObject];
//    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:titleLabel];
        self.titleLable = titleLabel;
        
        UILabel *priceLabel = [[UILabel alloc] init];
        priceLabel.textColor = [UIColor orangeColor];
        [self.contentView addSubview:priceLabel];
        self.priceLable = priceLabel;
        
        UILabel *buyCountLabel = [[UILabel alloc] init];
        buyCountLabel.textAlignment = NSTextAlignmentRight;
        buyCountLabel.font = [UIFont systemFontOfSize:14];
        buyCountLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:buyCountLabel];
        self.buy = buyCountLabel;
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat contentH = self.contentView.frame.size.height;
    CGFloat contentW = self.contentView.frame.size.width;
    CGFloat margin = 10;
    
    CGFloat iconX = margin;
    CGFloat iconY = margin;
    CGFloat iconW = 100;
    CGFloat iconH = contentH - 2 * iconY;
    self.iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    // titleLabel
    CGFloat titleX = CGRectGetMaxX(self.iconView.frame) + margin;
    CGFloat titleY = iconY;
    CGFloat titleW = contentW - titleX - margin;
    CGFloat titleH = 21;
    self.titleLable.frame = CGRectMake(titleX, titleY, titleW, titleH);
    //    CGRectMake(titleX, titleY, titleW, titleH);
    
    // priceLabel
    CGFloat priceX = titleX;
    CGFloat priceH = 21;
    CGFloat priceY = contentH - margin - priceH;
    CGFloat priceW = 70;
    self.priceLable.frame = CGRectMake(priceX, priceY, priceW, priceH);
    
    // buyCountLabel
    CGFloat buyCountH = priceH;
    CGFloat buyCountY = priceY;
    CGFloat buyCountX = CGRectGetMaxX(self.priceLable.frame) + margin;
    CGFloat buyCountW = contentW - buyCountX - margin;
    self.buy.frame = CGRectMake(buyCountX, buyCountY, buyCountW, buyCountH);
}

-(void)setDeal:(XMGDeal *)deal
{
    _deal = deal;
    
    self.iconView.image = [UIImage imageNamed:deal.icon];
    self.titleLable.text = deal.title;
    self.priceLable.text = deal.price;
    self.buy.text = deal.buyCount;
}
@end
