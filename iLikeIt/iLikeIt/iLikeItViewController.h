//
//  iLikeItViewController.h
//  iLikeIt
//
//  Created by Regular Berry on 3/20/11.
//  Copyright 2011 Regular Berry Software LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iLikeItViewController : UIViewController {
    UILabel *_titleLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;

-(IBAction)hitButton : (id)sender;

@end
