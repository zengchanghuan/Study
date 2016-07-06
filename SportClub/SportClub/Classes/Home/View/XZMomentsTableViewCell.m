//
//  XZMomentsTableViewCell.m
//  SportClub
//
//  Created by ZengChanghuan on 16/6/29.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZMomentsTableViewCell.h"
@interface XZMomentsTableViewCell()

@end
@implementation XZMomentsTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"momentsID";
    XZMomentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        
    }
    return cell;
}
- (CGFloat)height
{
    return 120;
}
- (void)awakeFromNib {
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
