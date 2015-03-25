//
//  PersonalInformationCell.m
//  Dialysis_New
//
//  Created by Amit Parmar on 27/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "PersonalInformationCell.h"

@implementation PersonalInformationCell

@synthesize lblName;
@synthesize lblPhysicianName;
@synthesize lblPhysicianPhone;
@synthesize lblNephrologistName;
@synthesize lblNephrologistPhone;
@synthesize lblSurgeonName;
@synthesize lblSurgeonPhone;

@synthesize btnPhone1;
@synthesize btnPhone2;
@synthesize btnPhone3;

@synthesize btnEdit;
@synthesize btnDelete;


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
