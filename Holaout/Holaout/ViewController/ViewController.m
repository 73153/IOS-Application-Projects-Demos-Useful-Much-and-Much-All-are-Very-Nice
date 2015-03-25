//
//  ViewController.m
//  Holaout
//
//  Created by Amit Parmar on 04/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewController.h"


@implementation ViewController
@synthesize imgViewHolOut;

- (void) navigateToNextScreen{
    HomeViewController *homeViewController;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        homeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController_iPhone" bundle:nil];
    }
    else{
        homeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController_iPad" bundle:nil];
    }
    [self.navigationController pushViewController:homeViewController animated:YES];
}

- (void) setOriginalImage{
    [imgViewHolOut stopAnimating];
    imgViewHolOut.image = [UIImage imageNamed:@"image7.png"];
    [self navigateToNextScreen];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    UIImage *image1 = [UIImage imageNamed:@"image1.png"];
    UIImage *image2 = [UIImage imageNamed:@"image2.png"];
    UIImage *image3 = [UIImage imageNamed:@"image3.png"];
    UIImage *image4 = [UIImage imageNamed:@"image4.png"];
    UIImage *image5 = [UIImage imageNamed:@"image5.png"];
    UIImage *image6 = [UIImage imageNamed:@"image6.png"];
    UIImage *image7 = [UIImage imageNamed:@"image7.png"];
    
    imgViewHolOut.animationDuration = 2.0;
    imgViewHolOut.animationImages = [NSArray arrayWithObjects:image1,image2,image3,image4,image5,image6,image7, nil];
    imgViewHolOut.animationRepeatCount = 1.0;
    [imgViewHolOut startAnimating];
    [self performSelector:@selector(setOriginalImage) withObject:nil afterDelay:2.1];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end
