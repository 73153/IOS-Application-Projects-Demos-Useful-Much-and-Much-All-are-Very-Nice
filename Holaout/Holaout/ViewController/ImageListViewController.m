//
//  ImageListViewController.m
//  Holaout
//
//  Created by Amit Parmar on 16/01/14.
//  Copyright (c) 2014 N-Tech. All rights reserved.
//

#import "ImageListViewController.h"
#import "JSONModelLib.h"
#import "SDWebImageManager.h"
#import "EditPhotoViewController.h"

@implementation ImageListViewController
@synthesize collectionView;
@synthesize searchBar;
@synthesize imagesArray;
@synthesize start;
@synthesize activityIndicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void) callWebservice:(NSString *)text{
    NSMutableArray *temparray = [[NSMutableArray alloc] initWithArray:imagesArray];
    NSString *kSearchURLString = [NSString stringWithFormat:@"https://www.googleapis.com/customsearch/v1?searchType=image&key=AIzaSyB0mk74ybyyEYlilg0k3PGPmwCgeAN1oZg&cx=010020950711962643367:mwo42p__mmu&q=%@&start=%d",text,start];
    [JSONHTTPClient getJSONFromURLWithString: kSearchURLString
                                  completion:^(NSDictionary *json, JSONModelError *err) {
                                      NSArray *array = [json objectForKey:@"items"];
                                      NSLog(@"array Count=%d",[array count]);
                                      for(int i=0;i<[array count];i++){
                                          NSDictionary *dict = [array objectAtIndex:i];
                                          NSString *thumbNail = [[dict objectForKey:@"image"] objectForKey:@"thumbnailLink"];
                                          NSString *link = [dict objectForKey:@"link"];
                                          NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:thumbNail,@"coverImage",link,@"mainImage", nil];
                                          [temparray addObject:dictionary];
                                      }
                                      imagesArray = temparray;
                                      [self.collectionView reloadData];
                                      if(start <= 100){
                                          start = start + 10;
                                          [self performSelector:@selector(callWebservice:) withObject:searchBar.text afterDelay:1.0];
                                      }
                                      NSLog(@"Got JSON from web: %@", json);
                                      if (err) {
                                          return;
                                      }
                                      
                                  }];
}
- (void)viewDidLoad{
    [super viewDidLoad];
    start = 1;
    searchBar.text = @"nature";
    [self callWebservice:@"nature"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewItem" bundle:nil] forCellWithReuseIdentifier:@"cellIdentifier"];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(100, 100)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [self.collectionView setCollectionViewLayout:flowLayout];
    [self.collectionView setAllowsSelection:YES];
    self.collectionView.delegate=self;
}

// collection view data source methods ////////////////////////////////////
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [imagesArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
    UIActivityIndicatorView *activityIndicator = (UIActivityIndicatorView *)[cell viewWithTag:101];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadWithURL:[NSURL URLWithString:[[imagesArray objectAtIndex:indexPath.item] objectForKey:@"coverImage"]]
                     options:0
                    progress:^(NSUInteger receivedSize, long long expectedSize){
          [activityIndicator startAnimating];
     }
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished){
         if (image){
             [activityIndicator stopAnimating];
             [imageView setImage:image];
         }
     }];
    return cell;
    
    
}

#pragma mark - delegate methods
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    NSString *strUrl = [[imagesArray objectAtIndex:indexPath.item] objectForKey:@"mainImage"];
    [manager downloadWithURL:[NSURL URLWithString:strUrl]
                     options:0
                    progress:^(NSUInteger receivedSize, long long expectedSize){
                        [activityIndicator startAnimating];
                    }
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished){
                       [activityIndicator stopAnimating];
                       if (image){
                           EditPhotoViewController *editPhotoViewController;
                           if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
                               editPhotoViewController = [[EditPhotoViewController alloc] initWithNibName:@"EditPhotoViewController_iPhone" bundle:nil];
                           }
                           else{
                               editPhotoViewController = [[EditPhotoViewController alloc] initWithNibName:@"EditPhotoViewController_iPad" bundle:nil];
                           }
                           editPhotoViewController.image = image;
                           [self presentViewController:editPhotoViewController animated:YES completion:nil];
                       }
                   }];
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (IBAction)backButtonClicked:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    imagesArray = nil;
    start = 1;
    [searchBar resignFirstResponder];
    [self callWebservice:searchBar.text];
}

@end
