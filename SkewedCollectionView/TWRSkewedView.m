//
//  TWRSkewedView.m
//  SkewedCollectionView
//
//  Created by Michelangelo Chasseur on 19/05/14.
//  Copyright (c) 2014 Touchware. All rights reserved.
//

#import "TWRSkewedView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface TWRSkewedView ()

@property (strong, nonatomic) UIColor *fillColor;
@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation TWRSkewedView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.imageView = [[UIImageView alloc] initWithFrame:frame];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.imageView = [[UIImageView alloc] init];
    }
    return self;
}

- (void)setFillColor:(UIColor *)color {
    _fillColor = color;
    [self setNeedsDisplay];
}

- (void)setImageWithUrl:(NSURL *)imageUrl placeholderImage:(UIImage *)image {
    [self.imageView setImageWithURL:imageUrl placeholderImage:image];
}

- (void)layoutSubviews {
    [self.imageView setFrame:self.frame];
    [self addSubview:self.imageView];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)drawRect:(CGRect)rect
{
    if (_fillColor) {
        [_fillColor setStroke];
        [_fillColor setFill];
    } else {
        [[UIColor redColor] setStroke];
        [[UIColor redColor] setFill];
    }

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, CGRectGetHeight(rect))];
    [path addLineToPoint:CGPointMake(0, CGRectGetHeight(rect) / 2.0f)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(rect), 0)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(rect), CGRectGetHeight(rect) / 2.0f)];
    [path closePath];
    [path fill];
    [path stroke];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = rect;
    maskLayer.path = path.CGPath;
    
    self.imageView.layer.mask = maskLayer;
}

@end
