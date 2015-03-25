//
//  LeftMenuViewController.h
//  Holaout
//
//  Created by Amit Parmar on 06/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftMenuViewController : UIViewController<QBActionStatusDelegate,MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tblView;


@end
