//
//  FEThreeViewController.m
//
//  Created by Luka Penger on 4/21/13.
//  Copyright (c) 2013 LukaPenger. All rights reserved.
//

/*
The MIT License (MIT)
 
Copyright (c) 2013 Luka Penger
 
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
 
The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.
 
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

#import "LPThreeSplitViewController.h"

@interface LPThreeSplitViewController ()

@end

@implementation LPThreeSplitViewController

@synthesize delegate = _delegate;

@synthesize menuView = _menuView;
@synthesize listView = _listView;
@synthesize detailView = _detailView;

@synthesize menuViewController = _menuViewController;
@synthesize listViewController = _listViewController;
@synthesize detailViewController = _detailViewController;

@synthesize menuWidthLandscape;
@synthesize menuWidthPortrait;

//MenuViewShadow Settings
@synthesize menuViewShadowColor;
@synthesize menuViewShadowOpacity;
@synthesize menuViewShadowRadius;

//ListViewShadow Settings
@synthesize listViewShadowColor;
@synthesize listViewShadowOpacity;
@synthesize listViewShadowRadius;

@synthesize listViewAnimationDuration;
@synthesize listPortraitClosing;
@synthesize showListViewControllerWhenRotate;
@synthesize gestureListViewOpacity;
@synthesize gestureListViewColor;
@synthesize gestureListViewPaddingTop;

- (id)initWithMenuViewController:(UIViewController*)menuViewController ListViewController:(UIViewController*)listViewController DetailViewController:(UIViewController*)detailViewController;
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.menuViewController=menuViewController;
        self.listViewController=listViewController;
        self.detailViewController=detailViewController;
        
        self.menuWidthLandscape=120.0f;
        self.menuWidthPortrait=120.0f;
        
        self.listWidthLandscape=240.0f;
        self.listWidthPortrait=240.0f;
        
        self.listPortraitClosing=YES;
        self.showListViewControllerWhenRotate=YES;
        
        //MenuViewShadow Settings
        self.menuViewShadowColor=[UIColor blackColor];
        self.menuViewShadowRadius=2.5f;
        self.menuViewShadowOpacity=1.0f;
        
        //ListViewShadow Settings
        self.listViewShadowColor=[UIColor blackColor];
        self.listViewShadowRadius=2.5f;
        self.listViewShadowOpacity=1.0f;
        
        self.listViewAnimationDuration=0.25;
        self.gestureListViewOpacity=0.3;
        self.gestureListViewColor=[UIColor blackColor];
        self.gestureListViewPaddingTop=44.0f;
    }
    return self;
}

- (void)gestureListViewHandle:(id)sender
{
    [self hideListViewController:self withAnimation:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.menuView = [[UIView alloc] init];
    self.listView = [[UIView alloc] init];
    self.detailView = [[UIView alloc] init];
    
    gestureListView = [[UIView alloc] init];

    swipeListView = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gestureListViewHandle:)];
    [swipeListView setNumberOfTouchesRequired:1];
    [swipeListView setDirection:UISwipeGestureRecognizerDirectionLeft];
    [gestureListView addGestureRecognizer:swipeListView];
    
    tapListView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureListViewHandle:)];
    tapListView.numberOfTapsRequired=1;
    tapListView.numberOfTouchesRequired=1;
    [gestureListView addGestureRecognizer:tapListView];
    
    self.menuView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.listView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.detailView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    
    [self.view addSubview:self.detailView]; //Layer 1
    [self.view addSubview:gestureListView];
    [self.view addSubview:self.listView]; //Layer 2
    [self.view addSubview:self.menuView]; //Layer 3
    
    [self addChildViewController:self.detailViewController];
    [self addChildViewController:self.listViewController];
    [self addChildViewController:self.menuViewController];
    
    [self.detailView addSubview:self.detailViewController.view];
    [self.listView addSubview:self.listViewController.view];
    [self.menuView addSubview:self.menuViewController.view];
}

- (void)viewDidLayoutSubviews
{
    if(UIInterfaceOrientationIsLandscape(self.interfaceOrientation))    //Landscape
    {
        self.menuView.frame = CGRectMake(0.0f, 0.0f, self.menuWidthLandscape, self.view.bounds.size.height);
        
        [self hideListViewController:self withAnimation:NO];
    } else {    //Portrait
        self.menuView.frame = CGRectMake(0.0f, 0.0f, self.menuWidthPortrait, self.view.bounds.size.height);

        if(self.showListViewControllerWhenRotate)
        {
            [self showListViewController:self withAnimation:NO];
        } else {
            [self hideListViewController:self withAnimation:NO];
        }
    }
    
    gestureListView.frame = CGRectMake(0.0f, self.gestureListViewPaddingTop, self.view.bounds.size.width, self.view.bounds.size.height);
    
    self.menuViewController.view.frame=CGRectMake(0.0f, 0.0f, self.menuView.frame.size.width, self.menuView.frame.size.height);
    self.listViewController.view.frame=CGRectMake(0.0f, 0.0f, self.listView.frame.size.width, self.listView.frame.size.height);
    self.detailViewController.view.frame=CGRectMake(0.0f, 0.0f, self.detailView.frame.size.width, self.detailView.frame.size.height);
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.menuViewController.view.frame];
    self.menuView.layer.masksToBounds = NO;
    self.menuView.layer.shadowColor = self.menuViewShadowColor.CGColor;
    self.menuView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.menuView.layer.shadowOpacity = self.menuViewShadowOpacity;
    self.menuView.layer.shadowRadius = self.menuViewShadowRadius;
    self.menuView.layer.shadowPath = shadowPath.CGPath;
    
    shadowPath = [UIBezierPath bezierPathWithRect:self.listViewController.view.frame];
    self.listView.layer.masksToBounds = NO;
    self.listView.layer.shadowColor = self.listViewShadowColor.CGColor;
    self.listView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.listView.layer.shadowOpacity = self.listViewShadowOpacity;
    self.listView.layer.shadowRadius = self.listViewShadowRadius;
    self.listView.layer.shadowPath = shadowPath.CGPath;
    
    [super viewDidLayoutSubviews];
}

- (void)showListViewController:(id)sender withAnimation:(BOOL)animation
{
    if ([self.delegate respondsToSelector:@selector(LPThreeSplitViewController:willShowListViewController:)])
    {
        [self.delegate LPThreeSplitViewController:self willShowListViewController:self.listViewController];
    }
    
    [self.listViewController viewDidAppear:YES];
    
    if(animation)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:self.listViewAnimationDuration];
        [UIView setAnimationBeginsFromCurrentState:FALSE];
    }
    
    if(UIInterfaceOrientationIsPortrait(self.interfaceOrientation))
    {
        self.listView.frame=CGRectMake(self.menuView.frame.size.width, 0.0f, self.listWidthPortrait, self.view.bounds.size.height);
        
        if(self.listPortraitClosing)
        {
            self.detailView.frame = CGRectMake(self.menuView.frame.size.width, 0.0f, (self.view.bounds.size.width-self.menuView.frame.size.width), self.view.bounds.size.height);
        } else {
            self.detailView.frame = CGRectMake(self.menuView.frame.size.width+self.listWidthLandscape, 0.0f, (self.view.bounds.size.width-(self.menuView.frame.size.width+self.listWidthLandscape)), self.view.bounds.size.height);
        }
    } else {
        self.listView.frame=CGRectMake(self.menuView.frame.size.width, 0.0f, self.listWidthPortrait, self.view.bounds.size.height);
        
        self.detailView.frame = CGRectMake(self.menuView.frame.size.width+self.listWidthPortrait, 0.0f, (self.view.bounds.size.width-(self.menuView.frame.size.width+self.listWidthPortrait)), self.view.bounds.size.height);
    }
    
    if(self.listPortraitClosing)
    {
        gestureListView.backgroundColor=self.gestureListViewColor;
        gestureListView.alpha=self.gestureListViewOpacity;
    } else {
        gestureListView.backgroundColor=[UIColor clearColor];
        gestureListView.alpha=0.0f;
    }
    
    if(animation)
    {
        [UIView commitAnimations];
    }
    
    if ([self.delegate respondsToSelector:@selector(LPThreeSplitViewController:didShowListViewController:)])
    {
        [self.delegate LPThreeSplitViewController:self didShowListViewController:self.listViewController];
    }
}

- (void)hideListViewController:(id)sender withAnimation:(BOOL)animation
{
    if ([self.delegate respondsToSelector:@selector(LPThreeSplitViewController:willHideListViewController:)])
    {
        [self.delegate LPThreeSplitViewController:self willHideListViewController:self.listViewController];
    }
    
    [self.listViewController viewDidAppear:YES];
    
    if(animation)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:self.listViewAnimationDuration];
        [UIView setAnimationBeginsFromCurrentState:FALSE];
    }
    
    if(UIInterfaceOrientationIsPortrait(self.interfaceOrientation))
    {
        self.listView.frame=CGRectMake((self.menuView.frame.size.width-(self.menuViewShadowRadius*2))-self.listWidthPortrait, 0.0f, self.listWidthPortrait, self.view.bounds.size.height);
        
        if(self.listPortraitClosing)
        {
            self.detailView.frame = CGRectMake(self.menuView.frame.size.width, 0.0f, (self.view.bounds.size.width-self.menuView.frame.size.width), self.view.bounds.size.height);
        } else {
            self.detailView.frame = CGRectMake(self.menuView.frame.size.width+self.listWidthLandscape, 0.0f, (self.view.bounds.size.width-(self.menuView.frame.size.width+self.listWidthLandscape)), self.view.bounds.size.height);
        }
    } else {
        self.listView.frame=CGRectMake(self.menuView.frame.size.width, 0.0f, self.listWidthPortrait, self.view.bounds.size.height);
        
        self.detailView.frame = CGRectMake(self.menuView.frame.size.width+self.listWidthPortrait, 0.0f, (self.view.bounds.size.width-(self.menuView.frame.size.width+self.listWidthPortrait)), self.view.bounds.size.height);
    }

    gestureListView.backgroundColor=[UIColor clearColor];
    gestureListView.alpha=0.0f;
    
    if(animation)
    {
        [UIView commitAnimations];
    }
    
    if ([self.delegate respondsToSelector:@selector(LPThreeSplitViewController:didHideListViewController:)])
    {
        [self.delegate LPThreeSplitViewController:self didHideListViewController:self.listViewController];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#if !__has_feature(objc_arc)
- (void)dealloc
{
    [_menuViewController release];
    [_listViewController release];
    [_detailViewController release];
    [_menuView release];
    [_listView release];
    [_detailView release];
    [_delegate release];
    [gestureListView release];
    [tapListView release];
    [swipeListView release];
    [super dealloc];
}
#endif

@end
