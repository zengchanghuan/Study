//
//  XZRedTimelineTableViewCell.h
//  SportClub
//
//  Created by ZengChanghuan on 16/6/29.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const XZRedTimelineCellIdentifier;

@interface XZRedTimelineTableViewCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

/**
 *  返回Cell的总高度
 */
+ (CGFloat)cellHeight;

@end
