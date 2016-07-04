//
//  XZHomeLiveTableViewCell.m
//  SportClub
//
//  Created by ZengChanghuan on 16/6/29.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZHomeLiveTableViewCell.h"
#import "XZCollectionViewCell.h"
#import "XZLineLayout.h"
@interface XZHomeLiveTableViewCell()

@end

@implementation XZHomeLiveTableViewCell
static NSString *const collectionViewID = @"collectionViewID";

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *homeLiveID = @"homeLiveID";
    XZHomeLiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homeLiveID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XZHomeLiveTableViewCell class]) owner:nil options:nil] lastObject];
    }
    return cell;
}
-(CGFloat)height{
    return 262;
}
- (void)awakeFromNib {
    // Initialization code
    CGRect rect = CGRectMake(0, 0, screenWidth, 200);
    self.collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:[XZLineLayout new]];
    [self.collectionView registerNib:[UINib nibWithNibName:@"XZCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:collectionViewID];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.collectionView];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
