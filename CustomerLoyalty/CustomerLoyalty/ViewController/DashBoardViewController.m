//
//  DashBoardViewController.m
//  CustomerLoyalty
//
//  Created by Amit Parmar on 13/02/14.
//  Copyright (c) 2014 N-Tech. All rights reserved.
//

#import "DashBoardViewController.h"
#import "SurveyViewController.h"
#import "PointsViewController.h"
#import "CompleteRegistrationViewController.h"

@implementation DashBoardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
//    [view setBackgroundColor:[UIColor clearColor]];
//    return view;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Identifier"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Identifier"];
    }
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(indexPath.row == 0){
        cell.textLabel.text = @"Take Survey";
    }
    else if(indexPath.row == 1){
       cell.textLabel.text = @"Points";
    }
    else if(indexPath.row == 2){
        cell.textLabel.text = @"Complete Registration";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        SurveyViewController *surveyViewController;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            surveyViewController = [[SurveyViewController alloc] initWithNibName:@"SurveyViewController" bundle:nil];
        }
        else{
            surveyViewController = [[SurveyViewController alloc] initWithNibName:@"SurveyViewController_iPhone" bundle:nil];
        }
        [self.navigationController pushViewController:surveyViewController animated:YES];
    }
    else if(indexPath.row == 1){
        PointsViewController *pointsViewController;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            pointsViewController = [[PointsViewController alloc] initWithNibName:@"PointsViewController" bundle:nil];
        }
        else{
            pointsViewController = [[PointsViewController alloc] initWithNibName:@"PointsViewController_iPhone" bundle:nil];
        }
        [self.navigationController pushViewController:pointsViewController animated:YES];
    }
    else if(indexPath.row == 2){
        CompleteRegistrationViewController *completeRegistrationViewController;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            completeRegistrationViewController = [[CompleteRegistrationViewController alloc] initWithNibName:@"CompleteRegistrationViewController" bundle:nil];
        }
        else{
            completeRegistrationViewController = [[CompleteRegistrationViewController alloc] initWithNibName:@"CompleteRegistrationViewController_iPhone" bundle:nil];
        }
        [self.navigationController pushViewController:completeRegistrationViewController animated:YES];
    }
}
@end
