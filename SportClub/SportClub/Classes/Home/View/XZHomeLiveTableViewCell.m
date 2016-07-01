//
//  XZHomeLiveTableViewCell.m
//  SportClub
//
//  Created by ZengChanghuan on 16/6/29.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZHomeLiveTableViewCell.h"
#import "XZLiveCollectionViewCell.h"

@interface XZHomeLiveTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *liveView;

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
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        
    }
    return cell;
}
-(CGFloat)height{
    return 262;
}
- (void)awakeFromNib {
    // Initialization code
    CGRect rect = self.liveView.bounds;
    self.collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:[UICollectionViewFlowLayout new]];
    [self.collectionView registerNib:[UINib nibWithNibName:@"XZLiveCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
    self.collectionView.backgroundColor = [UIColor redColor];
    [self.liveView addSubview:self.collectionView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
