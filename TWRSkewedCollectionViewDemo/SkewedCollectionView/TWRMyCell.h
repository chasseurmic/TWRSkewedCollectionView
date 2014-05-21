//
//  TWRMyCell.h
//  SkewedCollectionView
//
//  Created by Michelangelo Chasseur on 19/05/14.
//  Copyright (c) 2014 Touchware. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TWRSkewedView;

typedef NS_ENUM(NSUInteger, TWRSkewedCollectionViewSelectCell) {
    TWRSkewedCollectionViewSelectCellCurrent,
    TWRSkewedCollectionViewSelectCellPrevious,
    TWRSkewedCollectionViewSelectCellNext
};

@protocol TWRSkewedCellDelegate <NSObject>

- (void)skewedCellShouldSelectCell:(TWRSkewedCollectionViewSelectCell)cell sender:(id)sender;

@end

@interface TWRMyCell : UICollectionViewCell

@property (weak, nonatomic) id<TWRSkewedCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet TWRSkewedView *skewedView;

- (void)setColor:(UIColor *)color;

@end
