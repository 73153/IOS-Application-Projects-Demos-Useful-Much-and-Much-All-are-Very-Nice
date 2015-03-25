//
//  imageViewController.h
//  Dialysis_New
//
//  Created by Ntech Technologies on 1/10/14.
//  Copyright (c) 2014 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PicturesViewController.h"

@interface imageViewController : UIViewController

@property (nonatomic,retain) UIImage *resultImage;
@property (nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic,retain) UIImageView *imageView;

- (IBAction)sendImage:(id)sender;
- (IBAction)btnBackClicked:(id)sender;
- (void)centerScrollViewContents;
- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer;
- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer;

@end
