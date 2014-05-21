//
//  TWRMyCell.m
//  SkewedCollectionView
//
//  Created by Michelangelo Chasseur on 19/05/14.
//  Copyright (c) 2014 Touchware. All rights reserved.
//

#import "TWRMyCell.h"
#import "TWRSkewedView.h"

@interface TWRMyCell ()

@end

@implementation TWRMyCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setColor:(UIColor *)color {
    [_skewedView setFillColor:color];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if (touch.tapCount == 1) {
        CGPoint p = [touch locationInView:self];
        NSLog(@"%@", NSStringFromCGPoint(p));

        if ([_delegate respondsToSelector:@selector(skewedCellShouldSelectCell:sender:)]) {
            // Check if point lies in upper or lower triangle
            
            // First triangle
            CGPoint p1 = CGPointMake(0,0);
            CGPoint p2 = CGPointMake(0, CGRectGetHeight(self.frame) / 2.0f);
            CGPoint p3 = CGPointMake(CGRectGetWidth(self.frame), 0);
            
            // Second Triangle
            CGPoint p4 = CGPointMake(0, CGRectGetHeight(self.frame));
            CGPoint p5 = CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) / 2.0f);
            CGPoint p6 = CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));

            if ([self point:p inTriangleWithV1:p1 V2:p2 V3:p3]) {
                [_delegate skewedCellShouldSelectCell:TWRSkewedCollectionViewSelectCellPrevious
                                               sender:self];
            } else if ([self point:p inTriangleWithV1:p4 V2:p5 V3:p6]) {
                [_delegate skewedCellShouldSelectCell:TWRSkewedCollectionViewSelectCellNext
                                               sender:self];
            } else {
                [_delegate skewedCellShouldSelectCell:TWRSkewedCollectionViewSelectCellCurrent
                                               sender:self];
            }
        }
    }
}

#pragma mark - Boring calculations...

- (float)signWithP1:(CGPoint)p1 P2:(CGPoint)p2 P3:(CGPoint)p3 {
    return (p1.x - p3.x) * (p2.y - p3.y) - (p2.x - p3.x) * (p1.y - p3.y);
}

- (BOOL)point:(CGPoint)pt inTriangleWithV1:(CGPoint)v1 V2:(CGPoint)v2 V3:(CGPoint)v3 {
    BOOL b1, b2, b3;
    
    b1 = [self signWithP1:pt P2:v1 P3:v2] < 0.0f;
    b2 = [self signWithP1:pt P2:v2 P3:v3] < 0.0f;
    b3 = [self signWithP1:pt P2:v3 P3:v1] < 0.0f;
    
    return ((b1 == b2) && (b2 == b3));
}

- (void)prepareForReuse {
    _delegate = nil;
}

@end
