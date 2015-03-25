//
//  ViewController.m
//  [self.view addSubview:GRButton
//
//  Created by Göncz Róbert on 11/28/12.
//  Copyright (c) 2012 Göncz Róbert. All rights reserved.
//

#import "ViewController.h"
#import "GRButtons.h"

#define COLOR_RGB(r,g,b,a)      [UIColor colorWithRed:((r)/255.0) green:((g)/255.0) blue:((b)/255.0) alpha:(a)]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"GRButtons";
    
    UIColor *color = [UIColor grayColor];
    int size = 128;
    
    //// Simple Buttons
    [self.view addSubview:GRButton(GRTypeMail, 10, 20, size, self, @selector(action:), color, GRStyleIn)];
    [self.view addSubview:GRButton(GRTypeTwitter, 148, 20, size, self, @selector(action:), color, GRStyleIn)];
    [self.view addSubview:GRButton(GRTypeFacebook, 286, 20, size, self, @selector(action:), color, GRStyleIn)];
    [self.view addSubview:GRButton(GRTypeGooglePlus, 424, 20, size, self, @selector(action:), color, GRStyleIn)];
    [self.view addSubview:GRButton(GRTypePinterest, 562, 20, size, self, @selector(action:), color, GRStyleIn)];
    [self.view addSubview:GRButton(GRTypeDribble, 700, 20, size, self, @selector(action:), color, GRStyleIn)];
    [self.view addSubview:GRButton(GRTypeFlickr, 838, 20, size, self, @selector(action:), color, GRStyleIn)];
    
    
    //// Rectangle Buttons
    [self.view addSubview:GRButton(GRTypeMailRect, 10, 160, size, self, @selector(action:), color, GRStyleIn)];
    [self.view addSubview:GRButton(GRTypeTwitterRect, 148, 160, size, self, @selector(action:), color, GRStyleIn)];
    [self.view addSubview:GRButton(GRTypeFacebookRect, 286, 160, size, self, @selector(action:), color, GRStyleIn)];
    [self.view addSubview:GRButton(GRTypeGooglePlusRect, 424, 160, size, self, @selector(action:), color, GRStyleIn)];
    [self.view addSubview:GRButton(GRTypePinterestRect, 562, 160, size, self, @selector(action:), color, GRStyleIn)];
    [self.view addSubview:GRButton(GRTypeDribbleRect, 700, 160, size, self, @selector(action:), color, GRStyleIn)];
    [self.view addSubview:GRButton(GRTypeFlickrRect, 838, 160, size, self, @selector(action:), color, GRStyleIn)];
    
    
    //// Circle Buttons
    [self.view addSubview:GRButton(GRTypeMailCircle, 10, 300, size, self, @selector(action:), color, GRStyleIn)];
    [self.view addSubview:GRButton(GRTypeTwitterCircle, 148, 300, size, self, @selector(action:), color, GRStyleIn)];
    [self.view addSubview:GRButton(GRTypeFacebookCircle, 286, 300, size, self, @selector(action:), color, GRStyleIn)];
    [self.view addSubview:GRButton(GRTypeGooglePlusCircle, 424, 300, size, self, @selector(action:), color, GRStyleIn)];
    [self.view addSubview:GRButton(GRTypePinterestCircle, 562, 300, size, self, @selector(action:), color, GRStyleIn)];
    [self.view addSubview:GRButton(GRTypeDribbleCircle, 700, 300, size, self, @selector(action:), color, GRStyleIn)];
    [self.view addSubview:GRButton(GRTypeFlickrCircle, 838, 300, size, self, @selector(action:), color, GRStyleIn)];
    
    
    //// Different Types
    [self.view addSubview:GRButton(GRTypeTwitter, 10, 440, size, self, @selector(action:), [UIColor lightGrayColor], GRStyleIn)];
    [self.view addSubview:GRButton(GRTypeTwitter, 148, 440, size, self, @selector(action:), [UIColor lightGrayColor], GRStyleOut)];
    [self.view addSubview:GRButton(GRTypeTwitter, 286, 440, size, self, @selector(action:), [UIColor lightGrayColor], GRStyleNormal)];
    
    
    //// Different Sizes
    [self.view addSubview:GRButton(GRTypeGooglePlusRect, 562, 440, 128, self, @selector(action:), color, GRStyleIn)];
    [self.view addSubview:GRButton(GRTypeGooglePlusRect, 700, 440, 64, self, @selector(action:), color, GRStyleIn)];
    [self.view addSubview:GRButton(GRTypeGooglePlusRect, 774, 440, 32, self, @selector(action:), color, GRStyleIn)];
    
    
    //// Different Colors
    [self.view addSubview:GRButton(GRTypeMailRect, 10, 580, 64, self, @selector(action:), COLOR_RGB(225, 119, 26, 1), GRStyleIn)];
    [self.view addSubview:GRButton(GRTypeTwitterRect, 148, 580, 64, self, @selector(action:), COLOR_RGB(0, 172, 238, 1), GRStyleIn)];
    [self.view addSubview:GRButton(GRTypeFacebookRect, 286, 580, 64, self, @selector(action:), COLOR_RGB(60, 90, 154, 1), GRStyleIn)];
    [self.view addSubview:GRButton(GRTypeGooglePlusRect, 424, 580, 64, self, @selector(action:), COLOR_RGB(197, 60, 44, 1), GRStyleIn)];
    [self.view addSubview:GRButton(GRTypePinterestRect, 562, 580, 64, self, @selector(action:), COLOR_RGB(205, 32, 38, 1), GRStyleIn)];
    [self.view addSubview:GRButton(GRTypeDribbleRect, 700, 580, 64, self, @selector(action:), COLOR_RGB(240, 94, 148, 1), GRStyleIn)];
    [self.view addSubview:GRButton(GRTypeFlickrRect, 838, 580, 64, self, @selector(action:), COLOR_RGB(45, 101, 163, 1), GRStyleIn)];
    
    [self.view addSubview:GRButton(GRTypeMail, 10, 660, 32, self, @selector(action:), COLOR_RGB(225, 119, 26, 1), GRStyleIn)];
    [self.view addSubview:GRButton(GRTypeTwitter, 148, 660, 32, self, @selector(action:), COLOR_RGB(0, 172, 238, 1), GRStyleIn)];
    [self.view addSubview:GRButton(GRTypeFacebook, 286, 660, 32, self, @selector(action:), COLOR_RGB(60, 90, 154, 1), GRStyleIn)];
    [self.view addSubview:GRButton(GRTypeGooglePlus, 424, 660, 32, self, @selector(action:), COLOR_RGB(197, 60, 44, 1), GRStyleIn)];
    [self.view addSubview:GRButton(GRTypePinterest, 562, 660, 32, self, @selector(action:), COLOR_RGB(205, 32, 38, 1), GRStyleIn)];
    [self.view addSubview:GRButton(GRTypeDribble, 700, 660, 32, self, @selector(action:), COLOR_RGB(240, 94, 148, 1), GRStyleIn)];
    [self.view addSubview:GRButton(GRTypeFlickr, 838, 660, 32, self, @selector(action:), COLOR_RGB(45, 101, 163, 1), GRStyleIn)];


    //// NavigationBar Left Buttons
    UIBarButtonItem *l1 = [[UIBarButtonItem alloc] initWithCustomView:GRButton(GRTypeMail, 0, 0, 32, self, @selector(action:), color, GRStyleIn)];
    UIBarButtonItem *l2 = [[UIBarButtonItem alloc] initWithCustomView:GRButton(GRTypeTwitter, 0, 0, 32, self, @selector(action:), color, GRStyleIn)];
    UIBarButtonItem *l3 = [[UIBarButtonItem alloc] initWithCustomView:GRButton(GRTypeFacebook, 0, 0, 32, self, @selector(action:), color, GRStyleIn)];
    UIBarButtonItem *l4 = [[UIBarButtonItem alloc] initWithCustomView:GRButton(GRTypeGooglePlus, 0, 0, 32, self, @selector(action:), color, GRStyleIn)];
    UIBarButtonItem *l5 = [[UIBarButtonItem alloc] initWithCustomView:GRButton(GRTypePinterest, 0, 0, 32, self, @selector(action:), color, GRStyleIn)];
    UIBarButtonItem *l6 = [[UIBarButtonItem alloc] initWithCustomView:GRButton(GRTypeDribble, 0, 0, 32, self, @selector(action:), color, GRStyleIn)];
    UIBarButtonItem *l7 = [[UIBarButtonItem alloc] initWithCustomView:GRButton(GRTypeFlickr, 0, 0, 32, self, @selector(action:), color, GRStyleIn)];
    
    NSArray *leftButtons = [[NSArray alloc] initWithObjects:l1, l2, l3, l4, l5, l6, l7, nil];
    self.navigationItem.leftBarButtonItems = leftButtons;
    
    
    //// NavigationBar Right Buttons
    UIBarButtonItem *r1 = [[UIBarButtonItem alloc] initWithCustomView:GRButton(GRTypeMailCircle, 0, 0, 32, self, @selector(action:), color, GRStyleIn)];
    UIBarButtonItem *r2 = [[UIBarButtonItem alloc] initWithCustomView:GRButton(GRTypeTwitterCircle, 0, 0, 32, self, @selector(action:), color, GRStyleIn)];
    UIBarButtonItem *r3 = [[UIBarButtonItem alloc] initWithCustomView:GRButton(GRTypeFacebookCircle, 0, 0, 32, self, @selector(action:), color, GRStyleIn)];
    UIBarButtonItem *r4 = [[UIBarButtonItem alloc] initWithCustomView:GRButton(GRTypeGooglePlusCircle, 0, 0, 32, self, @selector(action:), color, GRStyleIn)];
    UIBarButtonItem *r5 = [[UIBarButtonItem alloc] initWithCustomView:GRButton(GRTypePinterestCircle, 0, 0, 32, self, @selector(action:), color, GRStyleIn)];
    UIBarButtonItem *r6 = [[UIBarButtonItem alloc] initWithCustomView:GRButton(GRTypeDribbleCircle, 0, 0, 32, self, @selector(action:), color, GRStyleIn)];
    UIBarButtonItem *r7 = [[UIBarButtonItem alloc] initWithCustomView:GRButton(GRTypeFlickrCircle, 0, 0, 32, self, @selector(action:), color, GRStyleIn)];
    
    NSArray *rightButtons = [[NSArray alloc] initWithObjects:r1, r2, r3, r4, r5, r6, r7, nil];
    self.navigationItem.rightBarButtonItems = rightButtons;
}

- (IBAction)action:(id)sender {
    NSLog(@"Button pushed...");
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (UIInterfaceOrientationIsLandscape(interfaceOrientation));
}


@end
