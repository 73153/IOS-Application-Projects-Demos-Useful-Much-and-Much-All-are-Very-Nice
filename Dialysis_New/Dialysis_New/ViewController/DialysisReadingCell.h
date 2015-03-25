//
//  DialysisReadingCell.h
//  Dialysis_New
//
//  Created by Amit Parmar on 28/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DialysisReadingCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel  *lblDate;
@property (nonatomic, strong) IBOutlet UIButton *btnEdit;
@property (nonatomic, strong) IBOutlet UIButton  *btnDelete;

@property (nonatomic, strong) IBOutlet UILabel *lblVP;
@property (nonatomic, strong) IBOutlet UILabel *lblAP;
@property (nonatomic, strong) IBOutlet UILabel *lblBF;
@property (nonatomic, strong) IBOutlet UILabel *lblSystolic;
@property (nonatomic, strong) IBOutlet UILabel *lblDiastolic;
@property (nonatomic, strong) IBOutlet UILabel *lblDryWeight;
@property (nonatomic, strong) IBOutlet UILabel *lblFluidgain;
@property (nonatomic, strong) IBOutlet UILabel *lblHB;
@property (nonatomic, strong) IBOutlet UILabel *lblBUN;
@property (nonatomic, strong) IBOutlet UILabel *lblCR;
@property (nonatomic, strong) IBOutlet UILabel *lblAlbiumin;
@property (nonatomic, strong) IBOutlet UILabel *lblPhosph;
@property (nonatomic, strong) IBOutlet UILabel *lblPTH;
@property (nonatomic, strong) IBOutlet UILabel *lblKT;
@property (nonatomic, strong) IBOutlet UILabel *lblINR;
@property (nonatomic, strong) IBOutlet UILabel *lblKTV;

@end
