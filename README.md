TWRSkewedCollectionView
=================

## TWRSkewedCollectionView

An iOS collection view subclass to present a list of skewed images.

![TWRSkewedCollectionView Demo](http://cocoahunter-blog.s3.amazonaws.com/TWRSkewedCollectionView/TWRSkewedCollectionView.gif)

## Usage

To use the library, just add the dependency to your `Podfile`:

```ruby
platform :ios
pod 'TWRSkewedCollectionView'
```

Run `pod install` to install the dependencies.

Next, import the header file wherever you want to use the custom view:

```objc
#import <TWRSkewedCollectionView/TWRSkewedCollectionView.h>
```

TWRSkewedCollectionView is basically a subclass of a UICollectionView. The whole implementation of managing delegates  and datasource is hidden from the user.

This is the minimum amount of code needed to implement TWRSkewedCollectionView:

```objc
TWRSkewedCollectionView *collectionView =
        [[TWRSkewedCollectionView alloc] initWithFrame:self.view.bounds
                                             imageUrls:self.imageUrls
                                      placeholderImage:[UIImage imageNamed:@"placeholder"]];
    collectionView.skewedDelegate = self;
    collectionView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:collectionView];
```

- The view is allocated and init'd with an NSArray of image URLs (the whole process of downloading is non-blocking since it's being handled asynchronously by SDWebImage categories on UIImageView). You even have the option of passing in a UIImage with a placeholder that will be used during the download process of the images.
- You then have to assign the delegate to listen for cells being touched (more on this below). 
- Finally add the collection view as a subview of your controller's base view.

Dealing with skewed images views inside collection view cells requires some 'magic' stuff. Please check the following screenshots that will give you a rough idea of how the collection view is implemented.

This is the final output...

![](http://cocoahunter-blog.s3.amazonaws.com/TWRSkewedCollectionView/skewed3.png)

...and here's what's really going on behind the scenes!

![](http://cocoahunter-blog.s3.amazonaws.com/TWRSkewedCollectionView/skewed1.png)

![](http://cocoahunter-blog.s3.amazonaws.com/TWRSkewedCollectionView/skewed2.png)


Furthermore, since cells are overlapping (and not always in the same direction because scrolling changes their z-order!), the normal UICollectionView delegate methods cannot be used effectively to know which cell has been tapped by the user. 

Don't worry: all the boring calculations are once again done behind the scenes. Your view controller should just conform to ```TWRSkewedCollectionViewDelegate``` by implementing the following method, which returns the correct index path of the cell tapped by the user:

```objc
- (void)skewedCollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
```

## Requirements

`TWRSkewedCollectionView` requires iOS 6.x or greater.


## License

Usage is provided under the [MIT License](http://opensource.org/licenses/mit-license.php).  See LICENSE for the full details.
