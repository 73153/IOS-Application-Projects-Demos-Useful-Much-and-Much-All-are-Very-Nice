//
//  AddMedicineViewController.h
//  Dialysis_New
//
//  Created by Amit Parmar on 29/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddMedicineViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITextField *txtFieldPharmacyName;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldLocation;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldContactOne;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldContactTwo;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldMedicine1;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldMedicine2;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldMedicine3;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldMedicine4;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldMedicine5;

@property (nonatomic, strong) IBOutlet UIButton *btnBack;
@property (nonatomic, strong) IBOutlet UIButton *btnSave;

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSDictionary *oldDictionary;

@property (nonatomic, strong) IBOutlet UIView *textFieldBackground;
@property (nonatomic, strong) IBOutlet UIButton *btnAddMore;
@property (nonatomic, strong) NSMutableArray *dataArray;



- (IBAction)btnBackClicked:(id)sender;
- (IBAction)btnSaveClicked:(id)sender;
- (IBAction)btnAddMoreClicked:(id)sender;


@end
