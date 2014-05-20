//
//  TWRSecondViewController.m
//  SkewedCollectionView
//
//  Created by Michelangelo Chasseur on 21/05/14.
//  Copyright (c) 2014 Touchware. All rights reserved.
//

#import "TWRSecondViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface TWRSecondViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation TWRSecondViewController

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
    NSAssert(_imageUrl, @"No image URL was assigned to the view controller!");
    self.title = @"Detail";
    // Do any additional setup after loading the view from its nib.
    [self.imageView setImageWithURL:[NSURL URLWithString:self.imageUrl] placeholderImage:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
