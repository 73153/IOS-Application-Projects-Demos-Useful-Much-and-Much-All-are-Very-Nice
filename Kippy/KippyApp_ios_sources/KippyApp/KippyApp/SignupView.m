//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "SignupView.h"
#import "InputView.h"
#import "AppDelegate.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@implementation SignupView

- (id)initWithTitle:(NSString*)title {
  self = [super initWithTitle:title];
  if (self) {
    bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_signup.png"]];
    [self addSubview:bg];
    bg.userInteractionEnabled = YES;
    email = [[InputView alloc] initWithLabel:@"Email" placeholder:@"example@mail.com" frame:CGRectMake(18, 10+32*0, 265, 32)];
    [bg addSubview:email];
    name = [[InputView alloc] initWithLabel:@"Name" placeholder:@"Your Name" frame:CGRectMake(18, 10+32*1, 265, 32)];
    [bg addSubview:name];
    surname = [[InputView alloc] initWithLabel:@"Surname" placeholder:@"Your Surname" frame:CGRectMake(18, 10+32*2, 265, 32)];
    [bg addSubview:surname];
    password = [[InputView alloc] initWithLabel:@"Password" placeholder:@"at least 8 characters" frame:CGRectMake(18, 10+32*3, 265, 32)];
    [bg addSubview:password];
    [email input].keyboardType = UIKeyboardTypeEmailAddress;
    [password input].secureTextEntry = YES;
    btnDone = [[UIButton alloc] initWithFrame:CGRectMake(0,0,74,44)];
    [btnDone setImage:[UIImage imageNamed:@"btn_done.png"] forState:UIControlStateNormal];
    [btnDone addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fillFbData:) name:@"FBUserDataDictInfo" object:nil];

    [self addSubview:btnDone];
  }
  return self;
}

-(void)fillFbData:(NSNotification*)notification {
  NSDictionary* dict = notification.object;
  [email input].text = [dict objectForKey:@"FB_Email"];
  [name input].text = [dict objectForKey:@"FB_FirstName"];
  [surname input].text = [dict objectForKey:@"FB_LastName"];
}

-(void)done {
  [self standby];
  NSString* text1 = [[email input].text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
  NSString* text2 = [[name input].text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
  NSString* text3 = [[surname input].text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
  NSString* text4 = [[password input].text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
  BOOL hasErrors = NO;
  if(text1.length == 0) {
    hasErrors = YES;
  }
  if(text2.length == 0) {
    hasErrors = YES;
  }
  if(text3.length == 0) {
    hasErrors = YES;
  }
  if(![self NSStringIsValidEmail:text1]) {
    [self showBadEmailErrror];
    [self shakeView:bg];
    return;
  }
  if (text4.length < 8 || [text4 rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location == NSNotFound) {
    [self showPasswordErrror];
    [self shakeView:bg];
    return;
  }
  if(hasErrors) {
    [self showEmptyFormErrror];
    [self shakeView:bg];
    
  } else {
    [self disable];
    checkEmail = YES;
    [[self app] downloadResource:[NSString stringWithFormat:@"%@registration_emailExists.php?registration_email=%@", SERVER_URL, text1] sender:self];
  }
}

-(void)registrationOk {
	[[[UIAlertView alloc] initWithTitle:@"Kippy" message:@"Check your email to complete the registration" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
}

-(void)showBadEmailErrror {
	[[[UIAlertView alloc] initWithTitle:@"Kippy" message:@"Please use a valid email" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
}

-(void)showEmailErrror {
	[[[UIAlertView alloc] initWithTitle:@"Kippy" message:@"This email already exists" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
}

-(void)showEmptyFormErrror {
	[[[UIAlertView alloc] initWithTitle:@"Kippy" message:@"Please compile all informations" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
}

-(void)showPasswordErrror {
	[[[UIAlertView alloc] initWithTitle:@"Kippy" message:@"The password  must be at least 8 characters with 1 digit" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
}

-(void)downloadResourceSuccess:(ASIHTTPRequest*)request {
  if(checkEmail) {
    NSString* text1 = [[email input].text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* text2 = [[name input].text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* text3 = [[surname input].text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* text4 = [[password input].text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    checkEmail = NO;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[request responseData] options: NSJSONReadingMutableContainers error: nil];
    if([[dictionary objectForKey:@"return"] intValue] == 0) {
      ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@registrationAction.php", SERVER_URL]]];
      [request addPostValue:text1 forKey:@"registration_email"];
      [request addPostValue:text2 forKey:@"name"];
      [request addPostValue:text3 forKey:@"surname"];
      [request addPostValue:text4 forKey:@"registration_password"];
      [[self app] registerDownload:request sender:self];
    } else {
      [self showEmailErrror];
      [self shakeView:bg];
      [self enable];
    }
  } else {
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[request responseData] options: NSJSONReadingMutableContainers error: nil];
    //NSLog(@"%@", dictionary);
    if(dictionary == nil || [[dictionary objectForKey:@"return"] intValue] == 0) {
      [self shakeView:bg];
    } else {
      [email input].text = @"";
      [name input].text = @"";
      [surname input].text = @"";
      [password input].text = @"";
      [[NSNotificationCenter defaultCenter] postNotificationName:@"Back" object:nil];
      [self registrationOk];
    }
    [self enable];
  }
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
  BOOL stricterFilter = YES;
  NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
  NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
  NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
  NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
  return [emailTest evaluateWithObject:checkString];
}

-(void)downloadResourceFailed:(ASIHTTPRequest*)request {
  [self shakeView:bg];
  [self enable];
}

-(void)layoutSubviews {
  [super layoutSubviews];
  CGSize size = self.frame.size;
  bg.center = CGPointMake(size.width/2, 20+44+bg.frame.size.height/2);
  btnDone.center = CGPointMake(size.width-btnDone.frame.size.width/2, btnDone.frame.size.height/2);
}

@end
