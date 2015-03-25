//
//  ImageListViewController.h
//  Holaout
//
//  Created by Amit Parmar on 16/01/14.
//  Copyright (c) 2014 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageListViewController : UIViewController<UICollectionViewDelegate>

@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) NSArray *imagesArray;
@property (nonatomic) int start;

- (IBAction)backButtonClicked:(id)sender;

@end
