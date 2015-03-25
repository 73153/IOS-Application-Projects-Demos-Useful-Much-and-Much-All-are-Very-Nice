//
//  MenuViewController.h
//  H2Oteam_Universal
//
//  Created by Luka Penger on 4/21/13.
//  Copyright (c) 2013 LukaPenger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPThreeSplitViewController.h"

@interface MenuViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,LPThreeSplitViewControllerDelegate>
{
    
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;

@end
