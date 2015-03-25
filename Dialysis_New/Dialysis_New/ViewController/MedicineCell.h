//
//  MedicineCell.h
//  Dialysis_New
//
//  Created by Amit Parmar on 29/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MedicineCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIButton *btnEdit;
@property (nonatomic, strong) IBOutlet UIButton *btnDelete;
@property (nonatomic, strong) IBOutlet UILabel *lblPharmacyName;
@property (nonatomic, strong) IBOutlet UILabel *lblLocation;
@property (nonatomic, strong) IBOutlet UILabel *lblContactOne;
@property (nonatomic, strong) IBOutlet UILabel *lblContactTwo;
@property (nonatomic, strong) IBOutlet UILabel *lblMedicine1;
@property (nonatomic, strong) IBOutlet UILabel *lblMedicine2;
@property (nonatomic, strong) IBOutlet UILabel *lblMedicine3;
@property (nonatomic, strong) IBOutlet UILabel *lblMedicine4;
@property (nonatomic, strong) IBOutlet UILabel *lblMedicine5;

@property (nonatomic, strong) IBOutlet UIButton *btnPhone1;
@property (nonatomic, strong) IBOutlet UIButton *btnPhone2;

@end
