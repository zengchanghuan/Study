//
//  XZRedTimelineTableViewCell.m
//  SportClub
//
//  Created by ZengChanghuan on 16/6/29.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZRedTimelineTableViewCell.h"
#import "XRedTimelineCollectionViewCell.h"
NSString *const XZRedTimelineCellIdentifier = @"redTimelineCellIdentifierID";

@interface XZRedTimelineTableViewCell ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIView *redTimelineView;
@property (strong,nonatomic) UICollectionView *redTimelineCollectionView;
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
    return 420;
}
- (void)awakeFromNib {
    // Initialization code
    CGRect rect = CGRectMake(0, 0, screenWidth, 350);
    self.redTimelineCollectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:[UICollectionViewFlowLayout new]];
    [self.redTimelineCollectionView registerNib:[UINib nibWithNibName:@"XRedTimelineCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:XZRedTimelineCellIdentifier];
    self.redTimelineCollectionView.dataSource = self;
    self.redTimelineCollectionView.delegate = self;
    [self.redTimelineView addSubview:self.redTimelineCollectionView];
    
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:XZRedTimelineCellIdentifier forIndexPath:indexPath];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 45)];
    label.text = @"text";
    [cell.contentView addSubview:label];
    return cell;
    
}

#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return CGSizeMake(110, 110);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

#pragma makr -UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
