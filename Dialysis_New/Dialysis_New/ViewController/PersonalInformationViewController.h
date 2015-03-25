//
//  PersonalInformationViewController.h
//  Dialysis_New
//
//  Created by Amit Parmar on 27/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EditPersonalInfoViewController.h"
#import "FirstViewController.h"
#import "MedicineViewController.h"
#import "GraphViewController.h"

@interface PersonalInformationViewController : UIViewController<UIAlertViewDelegate>

@property (nonatomic, strong) IBOutlet UITextField *txtFieldName;
@property (nonatomic, strong) IBOutlet UITextField *txtPhysicianName;
@property (nonatomic, strong) IBOutlet UITextField *txtPhysicianPhone;
@property (nonatomic, strong) IBOutlet UITextField *txtNephrologistName;
@property (nonatomic, strong) IBOutlet UITextField *txtNephrologistPhone;
@property (nonatomic, strong) IBOutlet UITextField *txtSurgenName;
@property (nonatomic, strong) IBOutlet UITextField *txtSurgenPhone;
@property (nonatomic, strong) IBOutlet UIButton *btnBack;
@property (nonatomic, strong) IBOutlet UIButton *btnSave;

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) UITabBarController *tabBarController;
@property (nonatomic, strong) EditPersonalInfoViewController *editViewController;
@property (nonatomic, strong) FirstViewController *firstViewController;
@property (nonatomic, strong) MedicineViewController *medicineViewController;
@property (nonatomic, strong) GraphViewController *graphViewController;
@property (nonatomic, strong) NSDictionary *oldDictionary;


- (IBAction)btnBackClicked:(id)sender;
- (IBAction)btnSaveClicked:(id)sender;

@end
