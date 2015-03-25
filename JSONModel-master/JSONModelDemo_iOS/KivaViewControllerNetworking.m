//
//  KivaViewControllerNetworking.m
//  JSONModelDemo
//
//  Created by Marin Todorov on 04/12/2012.
//  Copyright (c) 2012 Underplot ltd. All rights reserved.
//

#import "KivaViewControllerNetworking.h"

#import "JSONModel+networking.h"
#import "KivaFeed.h"

#import "HUD.h"

@interface KivaViewControllerNetworking () <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView* table;
    KivaFeed* feed;
}

@end

@implementation KivaViewControllerNetworking

-(void)viewDidAppear:(BOOL)animated
{
    self.title = @"Kiva.org latest loans";

    [HUD showUIBlockingIndicatorWithText:@"Fetching JSON"];
    
    feed = [[KivaFeed alloc] initFromURLWithString:@"http://api.kivaws.org/v1/loans/search.json?status=fundraising"
                                        completion:^(JSONModel *model, JSONModelError* e) {
        
        [HUD hideUIBlockingIndicator];

        if (model) {
            [table reloadData];
        } else {
            [HUD showAlertWithTitle:@"Error" text:e.localizedDescription];
        }
        
    }];

}

#pragma mark - table methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return feed.loans.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KivaCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"KivaCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    LoanModel* loan = feed.loans[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ from %@",
                           loan.name, loan.location.country
                           ];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [table deselectRowAtIndexPath:indexPath animated:YES];
    
    LoanModel* loan = feed.loans[indexPath.row];
    
    NSString* message = [NSString stringWithFormat:@"%@ from %@ needs a loan %@",
                         loan.name, loan.location.country, loan.use
                         ];
    
    
    [HUD showAlertWithTitle:@"Loan details" text:message];
}

@end
