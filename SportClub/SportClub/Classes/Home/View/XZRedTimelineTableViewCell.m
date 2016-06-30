//
//  XZRedTimelineTableViewCell.m
//  SportClub
//
//  Created by ZengChanghuan on 16/6/29.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZRedTimelineTableViewCell.h"

@interface XZRedTimelineTableViewCell ()

@end
@implementation XZRedTimelineTableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"redTimelineID";
    XZRedTimelineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}
-(CGFloat)height
{
    return 410;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
