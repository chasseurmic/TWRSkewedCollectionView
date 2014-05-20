//
//  TWRSkewedCollectionView.h
//  SkewedCollectionView
//
//  Created by Michelangelo Chasseur on 20/05/14.
//  Copyright (c) 2014 Touchware. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TWRSkewedCollectionViewDelegate <NSObject>

- (void)skewedCollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface TWRSkewedCollectionView : UICollectionView

- (instancetype)initWithFrame:(CGRect)frame imageUrls:(NSArray *)imageUrls placeholderImage:(UIImage *)placeholderImage;

@property (nonatomic, weak) id<TWRSkewedCollectionViewDelegate>skewedDelegate;
@property (nonatomic, assign) CGFloat skewedness;
@property (nonatomic, copy) NSArray *imageUrls;
@property (nonatomic, strong) UIImage *placeholderImage;

@end
