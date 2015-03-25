//
//  MenuViewController.m
//  H2Oteam_Universal
//
//  Created by Luka Penger on 4/21/13.
//  Copyright (c) 2013 LukaPenger. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

@synthesize tableView = _tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"Menu";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
}

#pragma mark - LPThreeViewControllerDelegate

- (void)LPThreeSplitViewController:(LPThreeSplitViewController *)threeSplitViewController willShowListViewController:(UIViewController *)listViewController
{
    NSLog(@"willShowListViewController");
}

- (void)LPThreeSplitViewController:(LPThreeSplitViewController *)threeSplitViewController didShowListViewController:(UIViewController *)listViewController
{
    NSLog(@"didShowListViewController");
}

- (void)LPThreeSplitViewController:(LPThreeSplitViewController *)threeSplitViewController willHideListViewController:(UIViewController *)listViewController
{
    NSLog(@"willHideListViewController");
}

- (void)LPThreeSplitViewController:(LPThreeSplitViewController *)threeSplitViewController didHideListViewController:(UIViewController *)listViewController
{
    NSLog(@"didHideListViewController");
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
    
    return cell;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Menu %d",section];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#if !__has_feature(objc_arc)
- (void)dealloc
{
    [_tableView release];
    [super dealloc];
}
#endif

@end
