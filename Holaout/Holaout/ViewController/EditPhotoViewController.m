//
//  EditPhotoViewController.m
//  Holaout
//
//  Created by Amit Parmar on 11/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "EditPhotoViewController.h"
#import "ContactPickerViewController.h"
#import "DataManager.h"

@implementation EditPhotoViewController
@synthesize imageView;
@synthesize image;
@synthesize currentIndex;
@synthesize originalImage;
@synthesize friendsOnHolaout;
@synthesize seledtedFriend;
@synthesize activityIndicator;

- (UIImage *)imageWithBaclgroundColor:(UIColor *)color{
    UIImage *img = [[UIImage alloc] initWithData:UIImagePNGRepresentation(image)];
    // begin a new image context, to draw our colored image onto
    UIGraphicsBeginImageContext(img.size);
    
    // get a reference to that context we created
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // set the fill color
    [color setFill];
    
    // translate/flip the graphics context (for transforming from CG* coords to UI* coords
    CGContextTranslateCTM(context, 0, img.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // set the blend mode to color burn, and the original image
    CGContextSetBlendMode(context, kCGBlendModeColorBurn);
    CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
    CGContextDrawImage(context, rect, img.CGImage);
    
    // set a mask that matches the shape of the image, then draw (color burn) a colored rectangle
    CGContextClipToMask(context, rect, img.CGImage);
    CGContextAddRect(context, rect);
    CGContextDrawPath(context,kCGPathFill);
    
    // generate a new UIImage from the graphics context we drew onto
    UIImage *coloredImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return coloredImg;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

-(void)returnContactArray:(NSArray *)dataArray{
    NSLog(@"%@",dataArray);
    NSMutableArray *holaoutArray  = [[NSMutableArray alloc] init];
    NSMutableArray *otherArray = [[NSMutableArray alloc] init];
    for(int i=0;i<[dataArray count];i++){
        if([[[dataArray objectAtIndex:i] objectForKey:kISBlocked] intValue] != 1){
            if([[[dataArray objectAtIndex:i] objectForKey:kContactIsHolaout] intValue] == 1){
                [holaoutArray addObject:[dataArray objectAtIndex:i]];
            }
            else{
                [otherArray addObject:[dataArray objectAtIndex:i]];
            }
        }
    }
    friendsOnHolaout = holaoutArray;
}

- (void) handleRightSwipe:(UIGestureRecognizer *)gestureRecognizer{
    if(currentIndex < 10){
        currentIndex = currentIndex + 1;
        switch (currentIndex) {
            case 1:{
                imageView.image = [self imageWithBaclgroundColor:[UIColor redColor]];
            }
            break;
            case 2:{
                imageView.image = [self imageWithBaclgroundColor:[UIColor blueColor]];
            }
            break;
            case 3:{
                imageView.image = [self imageWithBaclgroundColor:[UIColor greenColor]];
            }
            break;
            case 4:{
                imageView.image = [self imageWithBaclgroundColor:[UIColor yellowColor]];
            }
            break;
            case 5:{
                imageView.image = [self imageWithBaclgroundColor:[UIColor cyanColor]];
            }
            break;
            case 6:{
                imageView.image = [self imageWithBaclgroundColor:[UIColor purpleColor]];
            }
            break;
            case 7:{
                imageView.image = [self imageWithBaclgroundColor:[UIColor orangeColor]];
            }
            break;
            case 8:{
                imageView.image = [self imageWithBaclgroundColor:[UIColor lightGrayColor]];
            }
            break;
            case 9:{
                imageView.image = [self imageWithBaclgroundColor:[UIColor whiteColor]];
            }
            break;
            case 10:{
               imageView.image = [self imageWithBaclgroundColor:[UIColor brownColor]];
            }
            break;
            default:
                break;
        }
    }
}

- (void) handleLeftSwipe:(UIGestureRecognizer *)gestureRecognizer{
    if(currentIndex > 0){
        currentIndex = currentIndex - 1;
        switch (currentIndex) {
            case 0:{
                imageView.image = [self imageWithBaclgroundColor:[UIColor clearColor]];
            }
            break;
            case 1:{
                imageView.image = [self imageWithBaclgroundColor:[UIColor redColor]];
            }
            break;
            case 2:{
                imageView.image = [self imageWithBaclgroundColor:[UIColor blueColor]];
            }
                break;
            case 3:{
                imageView.image = [self imageWithBaclgroundColor:[UIColor greenColor]];
            }
                break;
            case 4:{
                imageView.image = [self imageWithBaclgroundColor:[UIColor yellowColor]];
            }
                break;
            case 5:{
                imageView.image = [self imageWithBaclgroundColor:[UIColor cyanColor]];
            }
                break;
            case 6:{
                imageView.image = [self imageWithBaclgroundColor:[UIColor purpleColor]];
            }
                break;
            case 7:{
                imageView.image = [self imageWithBaclgroundColor:[UIColor orangeColor]];
            }
                break;
            case 8:{
                imageView.image = [self imageWithBaclgroundColor:[UIColor lightGrayColor]];
            }
                break;
            case 9:{
                imageView.image = [self imageWithBaclgroundColor:[UIColor whiteColor]];
            }
                break;
            case 10:{
                imageView.image = [self imageWithBaclgroundColor:[UIColor brownColor]];
            }
                break;
            default:
                break;
        }
    }
}

- (void)viewDidLoad{
    [super viewDidLoad];
    imageView.image = image;
    
    currentIndex = 0;
    [DataManager sharedDataManager].contactDelegate = self;
    NSDictionary *dictionary = [[NSUserDefaults standardUserDefaults] objectForKey:kStoredData];
    NSString *userId = [dictionary objectForKey:kUserId];
    [[DataManager sharedDataManager] getHolaoutContactsData:userId];

    UISwipeGestureRecognizer *rightGesture;
    rightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightSwipe:)];
    [rightGesture setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [[self view] addGestureRecognizer:rightGesture];
    
    UISwipeGestureRecognizer *leftGesture;
    leftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftSwipe:)];
    [leftGesture setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [[self view] addGestureRecognizer:leftGesture];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (IBAction)btnBackClicked:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void) uploadImageAndSendTextLinkToFriends{
    NSData *imageData = UIImagePNGRepresentation(imageView.image);
    [QBContent TUploadFile:imageData fileName:@"image.png" contentType:@"image/png" isPublic:NO delegate:self];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if([alertView tag] == 101 && buttonIndex == 0){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


- (void)completedWithResult:(Result*)result{
    [activityIndicator stopAnimating];
    if(result.success && [result isKindOfClass:[QBCFileUploadTaskResult class]]){
        QBCFileUploadTaskResult *res = (QBCFileUploadTaskResult *)result;
        NSUInteger uploadedFileID = res.uploadedBlob.ID;
        
        NSData *imageData = UIImagePNGRepresentation(imageView.image);
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *yourArtPath = [NSString stringWithFormat:@"%@/%d.png",documentsDirectory,uploadedFileID];
        [imageData writeToFile:yourArtPath atomically:YES];
        
            QBChatMessage *message = [QBChatMessage message];
            message.senderID = [LocalStorageService shared].currentUser.ID;
            message.recipientID = [[seledtedFriend objectForKey:kContactHolaoutId] intValue]; // opponent's id
            [message setCustomParameters:(NSMutableDictionary *)@{@"fileID": @(uploadedFileID)}];
            [[QBChat instance] sendMessage:message];
            [[LocalStorageService shared] saveImageToHistory:[NSDictionary dictionaryWithObjectsAndKeys:message,kMessage,[NSString stringWithFormat:@"%d",uploadedFileID],@"image", nil] withUserID:message.recipientID];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Image sent successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:101];
        [alert show];
    }else{
        NSLog(@"errors=%@", result.errors);
    }
}


- (IBAction)btnSendClicked:(id)sender{
    if(seledtedFriend){
        [activityIndicator startAnimating];
        [self uploadImageAndSendTextLinkToFriends];
    }
    else{
        ContactPickerViewController *contactViewController;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            contactViewController = [[ContactPickerViewController alloc] initWithNibName:@"ContactPickerViewController_iPhone" bundle:nil];
        }
        else{
            contactViewController = [[ContactPickerViewController alloc] initWithNibName:@"ContactPickerViewController_iPad" bundle:nil];
        }
        contactViewController.imageToSend = imageView.image;
        contactViewController.contactArray = friendsOnHolaout;
        [self presentViewController:contactViewController animated:YES completion:nil];
    }
}
@end
