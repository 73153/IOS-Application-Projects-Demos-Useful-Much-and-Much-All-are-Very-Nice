//
//  GFRCell.h
//  Dialysis_New
//
//  Created by Amit Parmar on 26/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFRCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel  *lblDate;
@property (nonatomic, strong) IBOutlet UIButton *btnDelete;
@property (nonatomic, strong) IBOutlet UILabel *lblCreatinine;
@property (nonatomic, strong) IBOutlet UILabel *lblGFR;

@end
