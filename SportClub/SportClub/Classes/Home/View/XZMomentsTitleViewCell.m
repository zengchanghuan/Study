//
//  XZMomentsTitleViewCell.m
//  SportClub
//
//  Created by ZengChanghuan on 16/7/5.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZMomentsTitleViewCell.h"

@implementation XZMomentsTitleViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *momentsTitleID = @"momentsTitleID";
    XZMomentsTitleViewCell *cell = [tableView dequeueReusableCellWithIdentifier:momentsTitleID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XZMomentsTitleViewCell class]) owner:nil options:nil]lastObject];
    }
    return cell;
}
- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)moreMoments:(id)sender {
}

@end
