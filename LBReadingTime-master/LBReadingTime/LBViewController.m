//
//  LBViewController.m
//  LBReadingTime
//
//  Created by Luca Bernardi on 12/03/13.
//  Copyright (c) 2013 Luca Bernardi. All rights reserved.
//

#import "LBViewController.h"
#import "LBReadingTimeScrollPanel.h"
#import <QuartzCore/QuartzCore.h>

@interface LBViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) LBReadingTimeScrollPanel *scrollPanel;
@end

@implementation LBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.scrollPanel = [[LBReadingTimeScrollPanel alloc] initWithFrame:CGRectZero];
    
    self.textView.enableReadingTime = YES;
    self.textView.delegate = self.scrollPanel;
//    self.textView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/* Uncomment to forward the delegate calls
 
#pragma mark - UISrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.scrollPanel scrollViewWillBeginDragging:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.scrollPanel scrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self.scrollPanel scrollViewDidEndScrollingAnimation:scrollView];
}

*/
@end
