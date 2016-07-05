//
//  XZCollectionViewCell.m
//  SportClub
//
//  Created by ZengChanghuan on 16/7/1.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZCollectionViewCell.h"

@implementation XZCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    self.layer.cornerRadius = 6;
    self.clipsToBounds = YES;
   
}

@end
