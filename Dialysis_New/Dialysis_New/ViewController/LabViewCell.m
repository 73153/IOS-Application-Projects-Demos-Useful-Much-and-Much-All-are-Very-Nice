//
//  LabViewCell.m
//  Dialysis_New
//
//  Created by Amit Parmar on 29/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "LabViewCell.h"

@implementation LabViewCell

@synthesize lblDate;
@synthesize btnEdit;
@synthesize btnDelete;
@synthesize lblHB;
@synthesize lblBUN;
@synthesize lblCR;
@synthesize lblAlbiumin;
@synthesize lblPhosph;
@synthesize lblPTH;
@synthesize lblKT;
@synthesize lblINR;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
