//
//  XZCollectionViewCell.m
//  自定义UICollectionView
//
//  Created by ZengChanghuan on 16/6/30.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZCollectionViewCell.h"
@interface XZCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@end
@implementation XZCollectionViewCell

- (void)awakeFromNib {
     self.imageV.layer.borderWidth = 3;
    self.imageV.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageV.layer.cornerRadius = 3;
    self.imageV.clipsToBounds = YES;
}

-(void)setImageName:(NSString *)imageName
{
    _imageName = [imageName copy];
    self.imageV.image = [UIImage imageNamed:imageName];
}
@end
