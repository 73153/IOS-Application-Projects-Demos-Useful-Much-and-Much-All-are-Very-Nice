//
//  InformationViewController.m
//  Dialysis_New
//
//  Created by Amit Parmar on 27/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "InformationViewController.h"
#import "PersonalInformationViewController.h"

@interface InformationViewController ()

@end

@implementation InformationViewController
@synthesize btnGo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (IBAction)btnGoClicked:(id)sender{
    PersonalInformationViewController *personalInformationViewController;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        personalInformationViewController = [[PersonalInformationViewController alloc] initWithNibName:@"PersonalInformationViewController_iPhone" bundle:nil];
    }
    else{
        personalInformationViewController = [[PersonalInformationViewController alloc] initWithNibName:@"PersonalInformationViewController_iPad" bundle:nil];
    }
    [self.navigationController pushViewController:personalInformationViewController animated:YES];
}

@end
