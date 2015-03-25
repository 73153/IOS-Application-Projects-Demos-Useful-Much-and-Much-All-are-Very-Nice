//
//  GFRCell.m
//  Dialysis_New
//
//  Created by Amit Parmar on 26/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "GFRCell.h"

@implementation GFRCell

@synthesize lblDate;
@synthesize btnDelete;
@synthesize lblCreatinine;
@synthesize lblGFR;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
