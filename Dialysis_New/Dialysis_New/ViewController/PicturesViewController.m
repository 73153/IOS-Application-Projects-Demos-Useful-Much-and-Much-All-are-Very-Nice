//
//  PicturesViewController.m
//  Dialysis_New
//
//  Created by Amit Parmar on 29/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "PicturesViewController.h"
#import "DataManager.h"
#import "AppConstant.h"
#import "PicturesCell.h"
#import "imageViewController.h"

@implementation PicturesViewController

@synthesize btnBack;
@synthesize btnAdd;
@synthesize tblView;
@synthesize imagesArray;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void) getDataAndReloadTable{
    imagesArray = [[DataManager sharedDataManager] getPictures];
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:kDate
                                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
    NSArray *newArray = [imagesArray sortedArrayUsingDescriptors:sortDescriptors];
    imagesArray = newArray;
    
    if([imagesArray count] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"No Data Available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    [self.tblView reloadData];
}
- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getDataAndReloadTable];
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (IBAction)btnBackClicked:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 0) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
         picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:NULL];
    }
    else if(buttonIndex == 1) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:NULL];
        }
    }
    else if(buttonIndex == 3) {
        // remove actionsheet
    }
}

- (IBAction)btnAddClicked:(id)sender{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Select an Image from"
                                  delegate:self
                                  cancelButtonTitle:@"cancel"
                                  destructiveButtonTitle:Nil
                                  otherButtonTitles:@"Gallery", @"Camera", nil];
    [actionSheet showInView:self.view];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        NSData *imageData = UIImagePNGRepresentation(chosenImage);
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:imageData,kImage,[NSDate date],kDate, nil];
        [[DataManager sharedDataManager] insertPictures:dictionary];
        [self getDataAndReloadTable];
        [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [imagesArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

- (NSString *) getDateStringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    return [dateFormatter stringFromDate:date];
}

- (void) deleteButtonClicked:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Are you sure you want to delete this record?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"NO",@"YES", nil];
    [alert setTag:[sender tag]];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        int index = [alertView tag] - 1000;
        NSDictionary *dataDictionary = [imagesArray objectAtIndex:index];
        int rowId = [[dataDictionary objectForKey:kRowId] intValue];
        if([[DataManager sharedDataManager] deletePicturesForRowId:rowId]){
            imagesArray = [[DataManager sharedDataManager] getPictures];
            [self.tblView reloadData];
        }
    }
}

- (void) btnImageClicked:(UIButton *)sender {
    NSLog(@" sender.imageView.image:%@", sender.imageView.image);
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    imageViewController *imgController = [[imageViewController alloc] initWithNibName:@"imageViewController_iPhone" bundle:nil];
        imgController.resultImage = sender.imageView.image;
        [self.navigationController pushViewController:imgController animated:YES];
    } else {
        imageViewController *imgController = [[imageViewController alloc] initWithNibName:@"imageViewController_iPad" bundle:nil];
        imgController.resultImage = sender.imageView.image;
        [self.navigationController pushViewController:imgController animated:YES];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PicturesCell *cell =(PicturesCell*) [tableView dequeueReusableCellWithIdentifier:@"Identifier"];
    if (cell == nil){
        NSArray *topLevelObjects;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
           topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"PicturesCell" owner:self options:nil];
        }
        else{
           topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"PicturesCell_iPad" owner:self options:nil];
        }
        for (id currentObject in topLevelObjects){
            if ([currentObject isKindOfClass:[UITableViewCell class]]){
                cell =  (PicturesCell *) currentObject;
                break;
            }
        }
    }
    
    NSDictionary *dataDictionary = [imagesArray objectAtIndex:indexPath.row];
    
    cell.lblDate.text = [self getDateStringFromDate:[dataDictionary objectForKey:kDate]];

    UIImage *image = [UIImage imageWithContentsOfFile:[dataDictionary objectForKey:kImage]];
    cell.imgView.image = [UIImage imageWithContentsOfFile:[dataDictionary objectForKey:kImage]];
    [cell.btnImage setImage:image forState:UIControlStateNormal];
    [cell.btnImage setTag:indexPath.row];
    [cell.btnImage addTarget:self action:@selector(btnImageClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.btnDelete setTag:indexPath.row+1000];
    [cell.btnDelete addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}



@end
