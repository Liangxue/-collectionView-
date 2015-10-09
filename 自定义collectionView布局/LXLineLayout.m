//
//  LXLineLayout.m
//  自定义collectionView布局
//
//  Created by ma c on 15/10/9.
//  Copyright (c) 2015年 梁学. All rights reserved.
//

#import "LXLineLayout.h"

static const CGFloat LXItemWH = 100;

@implementation LXLineLayout


//准备工作
- (void)prepareLayout{
    [super prepareLayout];
    
    self.itemSize =CGSizeMake(LXItemWH, LXItemWH);
    CGFloat inset = (self.collectionView.frame.size.width - LXItemWH) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    //设置水平滚动
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = LXItemWH;
}
//只要显示的边界发生改变就重新布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

//用来设置collectionView停止滚动那一刻的位置
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    
    //计算collectionView最后停留的位置
    CGRect lastRect;
    lastRect.origin = proposedContentOffset;
    lastRect.size = self.collectionView.frame.size;
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    NSArray *array = [self layoutAttributesForElementsInRect:lastRect];
    CGFloat adjustOffsetX = MAXFLOAT;
    for (UICollectionViewLayoutAttributes * attrs  in array) {
        if(ABS(attrs.center.x - centerX) < ABS(adjustOffsetX)){
            adjustOffsetX = attrs.center.x - centerX;
        }
    }
    return CGPointMake(proposedContentOffset.x + adjustOffsetX, proposedContentOffset.y);

}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    //计算可见的矩形框
    CGRect visiableRect;
    visiableRect.size = self.collectionView.frame.size;
    visiableRect.origin = self.collectionView.contentOffset;

    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    //计算屏幕中间的x
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    //遍历所有的布局属性
    for (UICollectionViewLayoutAttributes*attrs  in array) {
        //不在屏幕上直接跳过
        if (!CGRectIntersectsRect(visiableRect, attrs.frame))continue;
        //每个item的x
        CGFloat itemCenterX = attrs.center.x;
        
        CGFloat scale = 1 + 0.8 * (1- ABS(itemCenterX - centerX) / self.collectionView.frame.size.width * 0.5);
        attrs.transform3D = CATransform3DMakeScale(scale, scale, 1.0);
   
//        attrs.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    return array;
}

@end
