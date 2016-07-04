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
NSString *const XZMyCollectionViewIdentifier = @"CollectionViewIdentifierID";

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
    CGRect rect = CGRectMake(0, 45, screenWidth, 202);
    self.collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:[XZLineLayout new]];
    [self.collectionView registerNib:[UINib nibWithNibName:@"XZCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:XZMyCollectionViewIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.collectionView];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)moreLive:(id)sender {
}


@end
