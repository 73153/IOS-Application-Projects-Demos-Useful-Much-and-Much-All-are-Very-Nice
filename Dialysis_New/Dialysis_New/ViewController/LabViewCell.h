//
//  LabViewCell.h
//  Dialysis_New
//
//  Created by Amit Parmar on 29/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel  *lblDate;
@property (nonatomic, strong) IBOutlet UIButton *btnEdit;
@property (nonatomic, strong) IBOutlet UIButton  *btnDelete;

@property (nonatomic, strong) IBOutlet UILabel *lblHB;
@property (nonatomic, strong) IBOutlet UILabel *lblBUN;
@property (nonatomic, strong) IBOutlet UILabel *lblCR;
@property (nonatomic, strong) IBOutlet UILabel *lblAlbiumin;
@property (nonatomic, strong) IBOutlet UILabel *lblPhosph;
@property (nonatomic, strong) IBOutlet UILabel *lblPTH;
@property (nonatomic, strong) IBOutlet UILabel *lblKT;
@property (nonatomic, strong) IBOutlet UILabel *lblINR;

@end
