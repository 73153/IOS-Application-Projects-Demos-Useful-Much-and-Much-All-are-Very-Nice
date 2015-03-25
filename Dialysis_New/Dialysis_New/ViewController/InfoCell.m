//
//  InfoCell.m
//  Dialysis
//
//  Created by Amit Parmar on 03/10/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "InfoCell.h"

@implementation InfoCell
@synthesize IMGView,lbldescription,lblTitle,btnNext;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        lbldescription.numberOfLines = 0;
        [lbldescription sizeToFit];
        
        [lbldescription setMinimumScaleFactor:0.5];
        [lbldescription setBaselineAdjustment:UIBaselineAdjustmentAlignCenters];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
