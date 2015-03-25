//
//  EditPersonalInfoViewController.h
//  Dialysis_New
//
//  Created by Amit Parmar on 27/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditPersonalInfoViewController : UIViewController{
    
}
@property (nonatomic, strong) IBOutlet UIButton *btnBack;
@property (nonatomic, strong) IBOutlet UIButton *btnAdd;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *arrayOfInformation;
@property (nonatomic) BOOL isFromPush;

- (IBAction)btnBackClicked:(id)sender;
- (IBAction)btnAddClicked:(id)sender;
@end
