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
static NSString *const ID = @"image";
-(NSMutableArray *)imagesArray
{
    if (!_imagesArray) {
        self.imagesArray = [[NSMutableArray alloc] init];
        
        for (int i = 1; i<=4; i++) {
            [self.imagesArray addObject:[NSString stringWithFormat:@"%d", i]];
        }
    }
    return _imagesArray;
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"homeLiveID";
    XZHomeLiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
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
    [self.collectionView registerNib:[UINib nibWithNibName:@"XZCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
    [self.contentView addSubview:self.collectionView];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
