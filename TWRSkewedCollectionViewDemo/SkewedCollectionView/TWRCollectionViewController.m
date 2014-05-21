//
//  TWRCollectionViewController.m
//  SkewedCollectionView
//
//  Created by Michelangelo Chasseur on 19/05/14.
//  Copyright (c) 2014 Touchware. All rights reserved.
//

#import "TWRCollectionViewController.h"
#import "TWRSkewedCollectionView.h"
#import "TWRSecondViewController.h"

@interface TWRCollectionViewController () <TWRSkewedCollectionViewDelegate>

@property (copy, nonatomic) NSArray *imageUrls;

@end

@implementation TWRCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Skewed Collection View";
    
    _imageUrls = @[@"http://www.hdwallpapers.in/walls/the_desert-wide.jpg",
                   @"http://www.hdwallpapers.in/walls/mediterranean_sea_coast-wide.jpg",
                   @"http://www.hdwallpapers.in/walls/alaska_winter_nights-wide.jpg",
                   @"http://www.hdwallpapers.in/walls/mediterranean_coast-wide.jpg",
                   @"http://www.hdwallpapers.in/walls/sunrise_mountains-wide.jpg",
                   @"http://www.hdwallpapers.in/walls/reflections-wide.jpg",
                   @"http://www.hdwallpapers.in/walls/snow_wonderland-wide.jpg"];
    
    TWRSkewedCollectionView *collectionView =
        [[TWRSkewedCollectionView alloc] initWithFrame:self.view.bounds
                                             imageUrls:self.imageUrls
                                      placeholderImage:[UIImage imageNamed:@"dice"]];
    collectionView.skewedDelegate = self;
    collectionView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:collectionView];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)skewedCollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", indexPath);
    TWRSecondViewController *secondController = [[TWRSecondViewController alloc] init];
    secondController.imageUrl = [self.imageUrls objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:secondController animated:YES];
}


@end
