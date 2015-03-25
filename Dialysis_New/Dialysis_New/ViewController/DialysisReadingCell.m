//
//  DialysisReadingCell.m
//  Dialysis_New
//
//  Created by Amit Parmar on 28/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "DialysisReadingCell.h"

@implementation DialysisReadingCell

@synthesize lblDate;
@synthesize btnEdit;
@synthesize btnDelete;
@synthesize lblVP;
@synthesize lblAP;
@synthesize lblBF;
@synthesize lblSystolic;
@synthesize lblDiastolic;
@synthesize lblDryWeight;
@synthesize lblFluidgain;
@synthesize lblHB;
@synthesize lblBUN;
@synthesize lblCR;
@synthesize lblAlbiumin;
@synthesize lblPhosph;
@synthesize lblPTH;
@synthesize lblKT;
@synthesize lblINR;
@synthesize lblKTV;

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
