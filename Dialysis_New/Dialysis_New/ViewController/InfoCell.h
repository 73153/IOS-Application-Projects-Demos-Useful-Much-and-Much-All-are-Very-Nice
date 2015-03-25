//
//  InfoCell.h
//  Dialysis
//
//  Created by Amit Parmar on 03/10/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoCell : UITableViewCell
{
    IBOutlet UIImageView *IMGView;
    IBOutlet UILabel *lblTitle,*lbldescription;
    IBOutlet UIButton *btnNext;
}
@property(nonatomic,retain)IBOutlet UIImageView *IMGView;
@property(nonatomic,retain)IBOutlet UILabel *lblTitle,*lbldescription;
@property(nonatomic,retain)IBOutlet UIButton *btnNext;

@end
