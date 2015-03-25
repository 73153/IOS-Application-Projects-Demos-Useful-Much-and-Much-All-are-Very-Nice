//
//  PhotosTableViewController.m
//  ALAssetsLibraryCustomPhotoAlbum_BasicDemo
//
//  Created by Kjuly on 1/7/13.
//  Copyright (c) 2013 Kjuly. All rights reserved.
//

#import "PhotosTableViewController.h"

#import "PhotoViewController.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import <MobileCoreServices/MobileCoreServices.h>


// Name for the custom photo album
#define kKYCustomPhotoAlbumName_ @"Custom Photo Album"


@interface PhotosTableViewController () {
 @private
  ALAssetsLibrary     * assetsLibrary_;
  NSMutableArray      * photos_;
  PhotoViewController * photoViewController_;
}

@property (nonatomic, strong) ALAssetsLibrary     * assetsLibrary;
@property (nonatomic, copy)   NSMutableArray      * photos;
@property (nonatomic, strong) PhotoViewController * photoViewController;

- (void)_takePhoto:(id)sender;

@end


@implementation PhotosTableViewController

@synthesize assetsLibrary        = assetsLibrary_;
@synthesize photos               = photos_;
@synthesize parentViewController = photoViewController_;

- (id)initWithStyle:(UITableViewStyle)style
{
  if (self = [super initWithStyle:style]) {
    // Custom initialization
    [self setTitle:@"Demo"];
    photos_ = [[NSMutableArray alloc] init];
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  // Uncomment the following line to preserve selection between presentations.
  // self.clearsSelectionOnViewWillAppear = NO;
 
  // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
  // self.navigationItem.rightBarButtonItem = self.editButtonItem;
  
  // Right bar button (Take Photo) on navigation bar
  UIBarButtonItem * takePhotoButton = [UIBarButtonItem alloc];
  (void)[takePhotoButton initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
                                              target:self
                                              action:@selector(_takePhoto:)];
  (void)[takePhotoButton initWithTitle:@"Take"
                                 style:UIBarButtonItemStyleBordered
                                target:self
                                action:@selector(_takePhoto:)];
  [takePhotoButton setStyle:UIBarButtonItemStyleBordered];
  [self.navigationItem setRightBarButtonItem:takePhotoButton];
  
  // Note:
  //
  //  This code snippet is for testing |ALAssetsLibrary+CustomPhotoAlbum| lib's method:
  //   |-loadPhotosFromAlbum:completion:|.
  //
  /*
  [self.assetsLibrary loadImagesFromAlbum:kKYCustomPhotoAlbumName_
                               completion:^(NSMutableArray *images, NSError *error) {
                                 NSLog(@"%s: %@", __PRETTY_FUNCTION__, images);
                               }];*/
}

- (void)viewDidUnload
{
  [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  
  // Dispose of any resources that can be recreated.
  assetsLibrary_       = nil;
  photoViewController_ = nil;
}

#pragma mark - Custom Getter

- (ALAssetsLibrary *)assetsLibrary
{
  if (assetsLibrary_) {
    return assetsLibrary_;
  }
  assetsLibrary_ = [[ALAssetsLibrary alloc] init];
  return assetsLibrary_;
}

- (PhotoViewController *)photoViewController
{
  if (photoViewController_) {
    return photoViewController_;
  }
  photoViewController_ = [[PhotoViewController alloc] init];
  return photoViewController_;
}

#pragma mark - Table view data source

// Return the number of sections.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

// Return the number of rows in the section.
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
  return [self.photos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString * cellIdentifier = @"cell";
  UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if (!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:cellIdentifier];
  
  // Configure the cell...
  [cell.textLabel setText:(self.photos)[indexPath.row]];
  return cell;
}

#pragma mark - Table view delegate

- (void)      tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [self.navigationController pushViewController:self.photoViewController animated:NO];
  
  // Get image from Custom Photo Album for the selected photo url.
  __weak PhotoViewController * weakPhotoViewController = self.photoViewController;
  [self.assetsLibrary assetForURL:[NSURL URLWithString:(self.photos)[indexPath.row]]
                      resultBlock:^(ALAsset *asset) {
                        //
                        //  thumbnail: asset.thumbnail
                        //             asset.aspectRatioThumbnail
                        // fullscreen: asset.defaultRepresentation.fullScreenImage
                        //             asset.defaultRepresentation.fullResolutionImage
                        //
                        [weakPhotoViewController updateWithImage:
                          [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage]];
                      }
                     failureBlock:^(NSError *error) {
                       NSLog(@"!!!ERROR: cannot get image: %@", [error description]);
                     }];
}

#pragma mark - Private Method

// Take photo
- (void)_takePhoto:(id)sender
{
  if (! [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    [[[UIAlertView alloc] initWithTitle:@"Camera Unavailable"
                                message:@"Sorry, camera unavailable for the current device."
                               delegate:self
                      cancelButtonTitle:@"Cancel"
                      otherButtonTitles:nil, nil] show];
    return;
  }
  
  // Generate picker
  UIImagePickerController * picker = [[UIImagePickerController alloc] init];
  picker.sourceType = UIImagePickerControllerSourceTypeCamera;
  
  // Displays a control that allows the user to choose picture or
  //   movie capture, if both are available:
  //picker.mediaTypes =
  //  [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
  picker.mediaTypes = @[(NSString *)kUTTypeImage];
  
  // Hides the controls for moving & scaling pictures, or for
  //   trimming movies. To instead show the controls, use YES.
  picker.allowsEditing = NO;
  picker.delegate      = self;
  
  if ([self.navigationController respondsToSelector:
       @selector(presentViewController:animated:completion:)])
  {
    [self.navigationController presentViewController:picker animated:YES completion:nil];
  } else {
    [self.navigationController presentModalViewController:picker animated:YES];
  }
}

#pragma mark - UIImagePickerController Delegate

// For responding to the user tapping Cancel.
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
  if ([self.navigationController respondsToSelector:
       @selector(presentViewController:animated:completion:)])
  {
    [picker dismissViewControllerAnimated:YES completion:nil];
  } else {
    // Prior to iOS 5.0, if a view did not have a parent view controller
    //   and was being presented modally, the view controller that was presenting
    //   it would be returned.
    // This is no longer the case. You can get the presenting view controller
    //   using the presentingViewController property.
    //
    // Guess |parentViewController| is nil on iOS 5 and that is why the controller
    //   will not dismiss.
    // Replacing |parentViewController| with |presentingViewController| will fix
    //   this issue.
    //
    // However, you'll have to check for the existence of presentingViewController
    //   on UIViewController to provide behavior for iOS versions < 5.0
    if ([picker respondsToSelector:@selector(presentingViewController)]) {
      [[picker presentingViewController] dismissModalViewControllerAnimated:YES];
    } else {
      [[picker parentViewController] dismissModalViewControllerAnimated:YES];
    }
  }
  
  picker.delegate = nil;
  picker          = nil;
}

// For responding to the user accepting a newly-captured picture or movie
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
  // Dismiss image picker view
  [self imagePickerControllerDidCancel:picker];
  
  // Manage the media (photo)
  NSString * mediaType = info[UIImagePickerControllerMediaType];
  // Handle a still image capture
  CFStringRef mediaTypeRef = (__bridge CFStringRef)mediaType;
  if (CFStringCompare(mediaTypeRef,
                      kUTTypeImage,
                      kCFCompareCaseInsensitive) != kCFCompareEqualTo)
  {
    CFRelease(mediaTypeRef);
    return;
  }
  CFRelease(mediaTypeRef);
  
  // Manage tasks in background thread
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    UIImage * imageToSave = nil;
    UIImage * editedImage = (UIImage *)info[UIImagePickerControllerEditedImage];
    if (editedImage) imageToSave = editedImage;
    else imageToSave = (UIImage *)info[UIImagePickerControllerOriginalImage];
    
    UIImage * finalImageToSave = nil;
    /* Modify image's size before save it to photos album
     *
     *  CGSize sizeToSave = CGSizeMake(imageToSave.size.width, imageToSave.size.height);
     *  UIGraphicsBeginImageContextWithOptions(sizeToSave, NO, 0.f);
     *  [imageToSave drawInRect:CGRectMake(0.f, 0.f, sizeToSave.width, sizeToSave.height)];
     *  finalImageToSave = UIGraphicsGetImageFromCurrentImageContext();
     *  UIGraphicsEndImageContext();
     */
    finalImageToSave = imageToSave;
    
    // The completion block to be executed after image taking action process done
    void (^completion)(NSURL *, NSError *) = ^(NSURL *assetURL, NSError *error) {
      if (error) NSLog(@"!!!ERROR,  write the image data to the assets library (camera roll): %@",
                       [error description]);
      NSLog(@"*** URL %@ | %@ || type: %@ ***", assetURL, [assetURL absoluteString], [assetURL class]);
      // Add new item to |photos_| & table view appropriately
      NSIndexPath * indexPath = [NSIndexPath indexPathForRow:self.photos.count
                                                   inSection:0];
      [self.photos addObject:[assetURL absoluteString]];
      dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView insertRowsAtIndexPaths:@[indexPath]
                              withRowAnimation:UITableViewRowAnimationFade];
      });
    };
    
    void (^failure)(NSError *) = ^(NSError *error) {
      if (error == nil) return;
      NSLog(@"!!!ERROR, failed to add the asset to the custom photo album: %@", [error description]);
    };
    
    // Save image to custom photo album
    // The lifetimes of objects you get back from a library instance are tied to
    //   the lifetime of the library instance.
    [self.assetsLibrary saveImage:finalImageToSave
                          toAlbum:kKYCustomPhotoAlbumName_
                       completion:completion
                          failure:failure];
  });
}

@end
