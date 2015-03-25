//
//  RootViewController.m
//  ALAssetsLibraryCustomPhotoAlbum_BasicDemo
//
//  Created by Kjuly on 1/7/13.
//  Copyright (c) 2013 Kjuly. All rights reserved.
//

#import "RootViewController.h"

#import "PhotosTableViewController.h"

@interface RootViewController () {
 @private
  UINavigationController * navigationController_;
}

@property (nonatomic, strong) UINavigationController * navigationController;

@end


@implementation RootViewController

@synthesize navigationController = navigationController_;


- (id)init
{
  return (self = [super init]);
}

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view.
  
  // Photos table view controller
  PhotosTableViewController * photosTableViewController;
  photosTableViewController = [PhotosTableViewController alloc];
  (void)[photosTableViewController initWithStyle:UITableViewStylePlain];
  
  // Main navigation controller
  navigationController_ = [UINavigationController alloc];
  (void)[navigationController_ initWithRootViewController:photosTableViewController];
  [navigationController_.view setFrame:(CGRect){CGPointZero, {kKYViewWidth, kKYViewHeight}}];
  [self.view addSubview:navigationController_.view];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
