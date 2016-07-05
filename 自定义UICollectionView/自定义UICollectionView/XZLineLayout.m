//
//  XZLineLayout.m
//  自定义UICollectionView
//
//  Created by ZengChanghuan on 16/6/30.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZLineLayout.h"
static const CGFloat XZItemW = 220;
static const CGFloat XZItemH = 200;

@implementation XZLineLayout

-(instancetype)init
{
    if (self = [super init]) {
       
    }
    return self;
}
/**
 *  初始化工作
 */
-(void)prepareLayout
{
    [super prepareLayout];
    
    self.itemSize = CGSizeMake(XZItemW, XZItemH);
    //设置水平滚动
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //每一个item都有一个自己的布局属性：UICollectionViewLayoutAttributes
    CGFloat inset = (self.collectionView.frame.size.width - XZItemW) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    self.minimumLineSpacing = 100;
    self.minimumInteritemSpacing = 40;
}
/**
 *  只要显示的边界发生改变就重新布局
 *
 *  内部会重新调用layoutAttributesForElementsInRect方法获得所有cell的布局属性
 *
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    CGRect visiableRect;
    visiableRect.size = self.collectionView.frame.size;
    visiableRect.origin = self.collectionView.contentOffset;
    
    //1取出默认的layoutAttributesForElementsInRect
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    //计算屏幕最中间的x 等于滚出去的x加上屏幕的一半
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    //2.遍历所有的布局属性
    for (UICollectionViewLayoutAttributes *attrs in array) {
        
        if (!CGRectIntersectsRect(visiableRect, attrs.frame)) {
            continue;
        }
        
        //每一个item的中点x
        CGFloat itemCenterX = attrs.center.x;
        
        //计算跟屏幕最中间的距离计算缩放比例
        CGFloat scale = 1+0.7*(1-(ABS(itemCenterX-centerX) / self.collectionView.frame.size.width));
        attrs.transform3D = CATransform3DMakeScale(scale, scale, 1.0);
    }
    return array;
}


@end
