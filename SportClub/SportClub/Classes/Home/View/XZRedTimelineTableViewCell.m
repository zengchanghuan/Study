//
//  XZRedTimelineTableViewCell.m
//  SportClub
//
//  Created by ZengChanghuan on 16/6/29.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//
#import "XZRedTimelineTableViewCell.h"
#import "XRedTimelineCollectionViewCell.h"

NSUInteger const XZRedTimelineCollectionViewCellColCount = 3;
NSUInteger const XZRedTimelineCollectionViewCellRowCount = 3;
CGFloat const XZRedTimelineCollectionViewCellMarginLeftRight = 12.0;
CGFloat const XZRedTimelineCollectionViewCellMidMarginX = 5.0;
CGFloat const XZSelectTheDynamicHeight = 45;

NSString *const XZRedTimelineCellIdentifier = @"redTimelineCellIdentifierID";

#define XZStatusWH (((XZScreenWidth - XZRedTimelineCollectionViewCellMarginLeftRight * 2 - (XZRedTimelineCollectionViewCellColCount - 1) * XZRedTimelineCollectionViewCellMidMarginX)) /(XZRedTimelineCollectionViewCellColCount * 1.0))

@interface XZRedTimelineTableViewCell ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIView *redTimelineView;
@property (strong,nonatomic) UICollectionView *redTimelineCollectionView;
@end
@implementation XZRedTimelineTableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"redTimelineID";
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorColor = [UIColor clearColor];
    XZRedTimelineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)awakeFromNib {
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, XZRedTimelineCollectionViewCellMarginLeftRight, XZRedTimelineCollectionViewCellMidMarginX, XZRedTimelineCollectionViewCellMarginLeftRight);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    CGRect rect = CGRectMake(0, 0, XZScreenWidth, [XZRedTimelineTableViewCell collectionViewHeight]);
    self.redTimelineCollectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:flowLayout];
    self.redTimelineCollectionView.scrollEnabled = NO;
    [self.redTimelineCollectionView registerNib:[UINib nibWithNibName:@"XRedTimelineCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:XZRedTimelineCellIdentifier];
    self.redTimelineCollectionView.dataSource = self;
    self.redTimelineCollectionView.delegate = self;
    self.redTimelineCollectionView.backgroundColor = [UIColor whiteColor];
    [self.redTimelineView addSubview:self.redTimelineCollectionView];
}

+ (CGFloat)cellHeight{
    return [self collectionViewHeight] + XZSelectTheDynamicHeight;
}

+ (CGFloat)collectionViewHeight{
    return XZStatusWH * XZRedTimelineCollectionViewCellRowCount + (XZRedTimelineCollectionViewCellRowCount + 1) * XZRedTimelineCollectionViewCellMidMarginX;
}

- (IBAction)moreTimeline:(id)sender {
}

#pragma mark -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return XZRedTimelineCollectionViewCellColCount;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return XZRedTimelineCollectionViewCellRowCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:XZRedTimelineCellIdentifier forIndexPath:indexPath];
    UILabel *label = [[UILabel alloc] initWithFrame:cell.bounds];
    label.text = [NSString stringWithFormat:@"%ld - %ld", indexPath.section, indexPath.item];
    [cell.contentView addSubview:label];
    return cell;
    
}

#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return CGSizeMake(XZStatusWH, XZStatusWH);
}

#pragma makr -UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
