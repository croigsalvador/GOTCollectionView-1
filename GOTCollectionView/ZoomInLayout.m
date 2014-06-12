//
//  ZoomInLayout.m
//  GOTCollectionView
//
//  Created by Ricardo Sánchez Sotres on 13/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import "ZoomInLayout.h"

@implementation ZoomInLayout

- (id)init {
    self = [super init];
    if(self) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.itemSize = (CGSize){400, 400};
        self.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        self.minimumLineSpacing = -50.0;
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds
{
    return YES;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray* array = [super layoutAttributesForElementsInRect:rect];
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    for (UICollectionViewLayoutAttributes* attributes in array) {
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            [self setCellAttributes:attributes forVisibleRect:visibleRect];
        }
    }
    return array;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    [self setCellAttributes:attributes forVisibleRect:visibleRect];
    
    return attributes;
}


- (void)setCellAttributes:(UICollectionViewLayoutAttributes *)attributes forVisibleRect:(CGRect)visibleRect
{
    
    CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
    CGFloat normalizedDistance = distance / (self.collectionView.frame.size.width/2.0);
    normalizedDistance = ABS(normalizedDistance);
    normalizedDistance = normalizedDistance>.5?.5:normalizedDistance;
    attributes.transform3D = CATransform3DMakeScale(1-normalizedDistance, 1-normalizedDistance, 1);
}

@end
