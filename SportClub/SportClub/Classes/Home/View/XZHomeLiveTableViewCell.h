//
//  XZHomeLiveTableViewCell.h
//  SportClub
//
//  Created by ZengChanghuan on 16/6/29.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZHomeLiveTableViewCell : UITableViewCell

@property (strong, nonatomic) UICollectionView *collectionView;

+(instancetype)cellWithTableView:(UITableView *)tableView;
- (CGFloat)height;

@end
