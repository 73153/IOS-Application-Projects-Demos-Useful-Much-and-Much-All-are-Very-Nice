//
//  PointsViewController.m
//  CustomerLoyalty
//
//  Created by Amit Parmar on 13/02/14.
//  Copyright (c) 2014 N-Tech. All rights reserved.
//

#import "PointsViewController.h"
#import "PointsDetailViewController.h"

@implementation PointsViewController
@synthesize tblView;
@synthesize pointsArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    pointsArray = [NSArray arrayWithObjects:@"Restaurant-1",@"Restaurant-2",@"Restaurant-3",@"Restaurant-4",@"Restaurant-5",@"Restaurant-6",@"Restaurant-7",@"Restaurant-8",@"Restaurant-9",@"Restaurant-10", nil];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (IBAction)backButtonClicked:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
//    [view setBackgroundColor:[UIColor clearColor]];
//    return view;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [pointsArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Identifier"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Identifier"];
    }
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.textLabel.text = [pointsArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PointsDetailViewController *pointsDetailViewController;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        pointsDetailViewController = [[PointsDetailViewController alloc] initWithNibName:@"PointsDetailViewController" bundle:nil];
    }
    else{
        pointsDetailViewController = [[PointsDetailViewController alloc] initWithNibName:@"PointsDetailViewController_iPad" bundle:nil];
    }
    [self.navigationController pushViewController:pointsDetailViewController animated:YES];
}

@end
