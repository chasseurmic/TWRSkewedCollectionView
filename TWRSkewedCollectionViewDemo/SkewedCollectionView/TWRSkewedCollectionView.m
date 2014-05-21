//
//  TWRSkewedCollectionView.m
//  SkewedCollectionView
//
//  Created by Michelangelo Chasseur on 20/05/14.
//  Copyright (c) 2014 Touchware. All rights reserved.
//

#import "TWRSkewedCollectionView.h"
#import "TWRSkewedView.h"
#import "TWRMyCell.h"

static NSString *cellIdentifier = @"kCellIdentifier";

@interface TWRSkewedCollectionView () <TWRSkewedCellDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation TWRSkewedCollectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame collectionViewLayout:[self skewedLayoutWithFrame:frame]];
    if (self) {
        // Set delegate and datasource
        self.delegate = self;
        self.dataSource = self;
        
        // Register cell Nib
        UINib *cellNib = [UINib nibWithNibName:NSStringFromClass([TWRMyCell class]) bundle:nil];
        [self registerNib:cellNib forCellWithReuseIdentifier:cellIdentifier];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame imageUrls:(NSArray *)imageUrls placeholderImage:(UIImage *)placeholderImage {
    self = [self initWithFrame:frame];
    if (self) {
        self.imageUrls = imageUrls;
        self.placeholderImage = placeholderImage;
    }
    return self;
}

- (UICollectionViewFlowLayout *)skewedLayoutWithFrame:(CGRect)frame {
    //Create base layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = -150;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(CGRectGetWidth(frame), 300.0f);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    return layout;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageUrls.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TWRMyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    NSURL *imageUrl = [NSURL URLWithString:_imageUrls[indexPath.row]];
    [cell.skewedView setImageWithUrl:imageUrl placeholderImage:self.placeholderImage];
    [cell setColor:[UIColor whiteColor]];
    
    return cell;
}

- (void)skewedCellShouldSelectCell:(TWRSkewedCollectionViewSelectCell)cellSelection sender:(id)sender {
    switch (cellSelection) {
        case TWRSkewedCollectionViewSelectCellCurrent:
        {
            for (TWRMyCell *cell in self.visibleCells) {
                if ([sender isEqual:cell]) {
                    NSIndexPath *indexPath = [self indexPathForCell:cell];
                    if ([_skewedDelegate respondsToSelector:@selector(skewedCollectionView:didSelectItemAtIndexPath:)]) {
                        [_skewedDelegate skewedCollectionView:self didSelectItemAtIndexPath:indexPath];
                    }
                }
            }
        }
            break;
            
        case TWRSkewedCollectionViewSelectCellNext:
        {
            for (TWRMyCell *cell in self.visibleCells) {
                if ([sender isEqual:cell]) {
                    NSIndexPath *indexPath = [self indexPathForCell:cell];
                    NSUInteger nextRow = indexPath.row + 1 > _imageUrls.count - 1 ? _imageUrls.count - 1 : indexPath.row + 1;
                    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForRow:nextRow inSection:indexPath.section];
                    if ([_skewedDelegate respondsToSelector:@selector(skewedCollectionView:didSelectItemAtIndexPath:)]) {
                        [_skewedDelegate skewedCollectionView:self didSelectItemAtIndexPath:nextIndexPath];
                    }
                }
            }
        }
            break;
            
        case TWRSkewedCollectionViewSelectCellPrevious:
        {
            for (TWRMyCell *cell in self.visibleCells) {
                if ([sender isEqual:cell]) {
                    NSIndexPath *indexPath = [self indexPathForCell:cell];
                    NSUInteger prevRow = indexPath.row - 1 < 0 ? 0 : indexPath.row - 1;
                    NSIndexPath *prevIndexPath = [NSIndexPath indexPathForRow:prevRow inSection:indexPath.section];
                    if ([_skewedDelegate respondsToSelector:@selector(skewedCollectionView:didSelectItemAtIndexPath:)]) {
                        [_skewedDelegate skewedCollectionView:self didSelectItemAtIndexPath:prevIndexPath];
                    }
                }
            }
        }
            break;
            
            
        default:
            break;
    }
}

@end
