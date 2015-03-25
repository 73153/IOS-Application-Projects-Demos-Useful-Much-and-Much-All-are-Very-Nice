//
//  PersonalInformationCell.h
//  Dialysis_New
//
//  Created by Amit Parmar on 27/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalInformationCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *lblName;
@property (nonatomic, strong) IBOutlet UILabel *lblPhysicianName;
@property (nonatomic, strong) IBOutlet UILabel *lblPhysicianPhone;
@property (nonatomic, strong) IBOutlet UILabel *lblNephrologistName;
@property (nonatomic, strong) IBOutlet UILabel *lblNephrologistPhone;
@property (nonatomic, strong) IBOutlet UILabel *lblSurgeonName;
@property (nonatomic, strong) IBOutlet UILabel *lblSurgeonPhone;

@property (nonatomic, strong) IBOutlet UIButton *btnPhone1;
@property (nonatomic, strong) IBOutlet UIButton *btnPhone2;
@property (nonatomic, strong) IBOutlet UIButton *btnPhone3;

@property (nonatomic, strong) IBOutlet UIButton *btnEdit;
@property (nonatomic, strong) IBOutlet UIButton *btnDelete;

@end
