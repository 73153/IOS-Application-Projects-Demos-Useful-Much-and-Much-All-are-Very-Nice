//
//  BallonAngioplastyCell.m
//  Dialysis_New
//
//  Created by Amit Parmar on 29/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "BallonAngioplastyCell.h"

@implementation BallonAngioplastyCell
@synthesize lblDate;
@synthesize btnEdit;
@synthesize btnDelete;
@synthesize lblAngiography;
@synthesize lblBallonAngioplasty;
@synthesize lblStentPlacement;


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
