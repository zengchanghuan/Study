//
//  XZRecommendCell.m
//  BaisiJie
//
//  Created by ZengChanghuan on 16/6/28.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZRecommendCell.h"
@interface XZRecommendCell()
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;


@end
@implementation XZRecommendCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = XZRGBColor(244, 244, 244);
    self.selectedIndicator.backgroundColor = XZRGBColor(219, 21, 26);
}


-(void)setRecommend:(XZRecommend *)recommend
{
    _recommend = recommend;
    self.textLabel.text = recommend.name;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    // 重新调整内部textLabel的frame

    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    self.selectedIndicator.hidden = !selected;
    self.textLabel.textColor = selected ? self.selectedIndicator.backgroundColor : XZRGBColor(78, 78, 78);
}

@end
