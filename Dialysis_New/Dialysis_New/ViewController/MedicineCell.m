//
//  MedicineCell.m
//  Dialysis_New
//
//  Created by Amit Parmar on 29/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "MedicineCell.h"

@implementation MedicineCell

@synthesize btnEdit;
@synthesize btnDelete;
@synthesize lblPharmacyName;
@synthesize lblLocation;
@synthesize lblContactOne;
@synthesize lblContactTwo;
@synthesize lblMedicine1;
@synthesize lblMedicine2;
@synthesize lblMedicine3;
@synthesize lblMedicine4;
@synthesize lblMedicine5;

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
