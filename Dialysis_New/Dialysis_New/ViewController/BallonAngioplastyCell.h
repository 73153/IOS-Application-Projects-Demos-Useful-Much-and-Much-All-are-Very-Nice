//
//  BallonAngioplastyCell.h
//  Dialysis_New
//
//  Created by Amit Parmar on 29/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BallonAngioplastyCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel  *lblDate;
@property (nonatomic, strong) IBOutlet UIButton *btnEdit;
@property (nonatomic, strong) IBOutlet UIButton  *btnDelete;
@property (nonatomic, strong) IBOutlet UILabel *lblAngiography;
@property (nonatomic, strong) IBOutlet UILabel *lblBallonAngioplasty;
@property (nonatomic, strong) IBOutlet UILabel *lblStentPlacement;


@end
