//
//  PicturesViewController.h
//  Dialysis_New
//
//  Created by Amit Parmar on 29/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicturesViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>{
    
}

@property (nonatomic, strong) IBOutlet UIButton *btnBack;
@property (nonatomic, strong) IBOutlet UIButton *btnAdd;
@property (nonatomic, strong) IBOutlet UITableView *tblView;
@property (nonatomic, strong) IBOutlet NSArray *imagesArray;

- (IBAction)btnBackClicked:(id)sender;
- (IBAction)btnAddClicked:(id)sender;
@end
