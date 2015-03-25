//
//  SettingsViewController.m
//  Holaout
//
//  Created by Amit Parmar on 06/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "SettingsViewController.h"

@implementation SettingsViewController

@synthesize txtFieldName;
@synthesize txtFieldEmail;
@synthesize txtFieldPhone;
@synthesize txtFieldOldPassword;
@synthesize txtFieldNewPassword;
@synthesize txtFieldWebsite;
@synthesize lblUserName;
@synthesize scrollView;
@synthesize btnProfileIcon;
@synthesize activityIndicator;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width,490)];
    NSString *stringPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *fileName = [stringPath stringByAppendingFormat:@"/profile.png"];
    NSData *data = [NSData dataWithContentsOfFile:fileName];
    NSDictionary *dictionary = [[NSUserDefaults standardUserDefaults] objectForKey:kStoredData];
    if(data){
       [btnProfileIcon setBackgroundImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
    }
    else{
        int blobId = [[dictionary objectForKey:kUserBlobId] intValue];
        if(blobId != 0){
            [activityIndicator startAnimating];
            [QBContent TDownloadFileWithBlobID:blobId delegate:self];
        }
    }
    txtFieldName.text = [dictionary objectForKey:kFullName];
    txtFieldEmail.text = [dictionary objectForKey:kEmail];
    txtFieldPhone.text = [dictionary objectForKey:kPhone];
    txtFieldWebsite.text = [dictionary objectForKey:kWebSite];
    lblUserName.text = [dictionary objectForKey:kUserName];
    
    [txtFieldName setReturnKeyType:UIReturnKeyDone];
    [txtFieldEmail setReturnKeyType:UIReturnKeyDone];
    [txtFieldPhone setReturnKeyType:UIReturnKeyDone];
    [txtFieldOldPassword setReturnKeyType:UIReturnKeyDone];
    [txtFieldNewPassword setReturnKeyType:UIReturnKeyDone];
    [txtFieldWebsite setReturnKeyType:UIReturnKeyDone];
    
    btnProfileIcon.layer.borderColor = [UIColor lightGrayColor].CGColor;
    btnProfileIcon.layer.borderWidth = 3.0;
    btnProfileIcon.layer.cornerRadius = 25.0;
    btnProfileIcon.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (IBAction)backButtonClicked:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)completedWithResult:(Result*)result{
    // Update User result
    if(result.success && [result isKindOfClass:[QBUUserResult class]]){
        QBUUserResult *results = (QBUUserResult *)result;
        int blobId = results.user.blobID;
         NSDictionary *dictionary = [[NSUserDefaults standardUserDefaults] objectForKey:kStoredData];
        NSString *password = [dictionary objectForKey:kPassword];
        if([txtFieldNewPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length > 0)
            password = txtFieldNewPassword.text;
        NSDictionary *newdictionary = [NSDictionary dictionaryWithObjectsAndKeys:[dictionary objectForKey:kUserId],kUserId,txtFieldEmail.text,kEmail,txtFieldName.text,kFullName,txtFieldPhone.text,kPhone,txtFieldWebsite.text,kWebSite,[dictionary objectForKey:kUserName],kUserName,[NSString stringWithFormat:@"%d",blobId],kUserBlobId,password,kPassword,nil];
        [[NSUserDefaults standardUserDefaults] setObject:newdictionary forKey:kStoredData];
        [[NSUserDefaults standardUserDefaults] synchronize];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Your profile update successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if(result.success && [result isKindOfClass:QBCFileDownloadTaskResult.class]){
        [activityIndicator stopAnimating];
        QBCFileDownloadTaskResult *res = (QBCFileDownloadTaskResult *)result;
        UIImage *image = [UIImage imageWithData:res.file];
        NSString *stringPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
        NSError *error = nil;
        if (![[NSFileManager defaultManager] fileExistsAtPath:stringPath])
            [[NSFileManager defaultManager] createDirectoryAtPath:stringPath withIntermediateDirectories:NO attributes:nil error:&error];
        NSString *fileName = [stringPath stringByAppendingFormat:@"/profile.png"];
        NSData *data = UIImagePNGRepresentation(image);
        [data writeToFile:fileName atomically:YES];
        [btnProfileIcon setBackgroundImage:image forState:UIControlStateNormal];
    }
    else if([result isKindOfClass:QBCFileUploadTaskResult.class]){
        QBCFileUploadTaskResult *res = (QBCFileUploadTaskResult *)result;
        NSUInteger uploadedFileID = res.uploadedBlob.ID;
        NSDictionary *dictionary = [[NSUserDefaults standardUserDefaults] objectForKey:kStoredData];
        QBUUser *user = [QBUUser user];
        user.ID = [[dictionary objectForKey:kUserId] intValue];
        user.blobID = uploadedFileID;
        [QBUsers updateUser:user delegate:self];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:[result.errors objectAtIndex:0] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (IBAction)saveButtonClicked:(id)sender{
    NSDictionary *dictionary = [[NSUserDefaults standardUserDefaults] objectForKey:kStoredData];
    QBUUser *user = [QBUUser user];
    user.ID = [[dictionary objectForKey:kUserId] intValue];
    user.email = txtFieldEmail.text;
    user.phone = txtFieldPhone.text;
    user.website = txtFieldWebsite.text;
    if(![txtFieldNewPassword.text isEqualToString:@""]){
        user.password = txtFieldNewPassword.text;
        user.oldPassword = txtFieldOldPassword.text;
    }
    user.website = txtFieldWebsite.text;
    user.fullName = txtFieldName.text;
    [QBUsers updateUser:user delegate:self];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [scrollView setContentOffset:CGPointMake(scrollView.frame.origin.x,0)];
    return true;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (IBAction)btnProfileIconClicked:(id)sender{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
   
    NSString *stringPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSError *error = nil;
    if (![[NSFileManager defaultManager] fileExistsAtPath:stringPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:stringPath withIntermediateDirectories:NO attributes:nil error:&error];
    
    NSString *fileName = [stringPath stringByAppendingFormat:@"/profile.png"];
    NSData *data = UIImagePNGRepresentation(chosenImage);
    [data writeToFile:fileName atomically:YES];
    
    [btnProfileIcon setBackgroundImage:chosenImage forState:UIControlStateNormal];
    [QBContent TUploadFile:UIImagePNGRepresentation(chosenImage) fileName:@"image.png" contentType:@"image/png" isPublic:NO delegate:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
