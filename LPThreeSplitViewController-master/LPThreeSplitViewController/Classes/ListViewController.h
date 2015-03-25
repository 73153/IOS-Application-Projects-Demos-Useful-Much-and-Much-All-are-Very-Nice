//
//  ListViewController.h
//  H2Oteam_Universal
//
//  Created by Luka Penger on 4/21/13.
//  Copyright (c) 2013 LukaPenger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;

@end
