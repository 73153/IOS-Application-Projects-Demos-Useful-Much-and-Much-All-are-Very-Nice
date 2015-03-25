//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "SigninView.h"
#import "InputView.h"
#import "AppDelegate.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@implementation SigninView

- (id)initWithTitle:(NSString*)title {
  self = [super initWithTitle:title];
  if (self) {
    bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_signin.png"]];
    [self addSubview:bg];
    bg.userInteractionEnabled = YES;
    email = [[InputView alloc] initWithLabel:@"Email" placeholder:@"example@mail.com" frame:CGRectMake(18, 10+32*0, 265, 32)];
    [bg addSubview:email];
    password = [[InputView alloc] initWithLabel:@"Password" placeholder:@"at least 8 characters" frame:CGRectMake(18, 10+32*1, 265, 32)];
    [bg addSubview:password];
    [email input].keyboardType = UIKeyboardTypeEmailAddress;
    [password input].secureTextEntry = YES;
    btnDone = [[UIButton alloc] initWithFrame:CGRectMake(0,0,74,44)];
    [btnDone setImage:[UIImage imageNamed:@"btn_done.png"] forState:UIControlStateNormal];
    [btnDone addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnDone];
  }
  return self;
}

-(void)done {
  [self standby];
  NSString* text1 = [[email input].text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
  NSString* text2 = [[password input].text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
  BOOL hasErrors = NO;
  if(text1.length == 0) {
    hasErrors = YES;
  }
  if(text2.length < 8) {
    hasErrors = YES;
  }
  if(hasErrors) {
    [self shakeView:bg];
  } else {
    [self disable];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@indexAction.php", SERVER_URL]]];
    [request addPostValue:text1 forKey:@"login_email"];
    [request addPostValue:text2 forKey:@"login_password"];
    [[self app] registerDownload:request sender:self];
  }
}

-(void)downloadResourceSuccess:(ASIHTTPRequest*)request {
  NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[request responseData] options: NSJSONReadingMutableContainers error: nil];
  if([[dictionary objectForKey:@"return"] intValue] == 1) {
    [email input].text = @"";
    [password input].text = @"";
    [self app].appCode = [dictionary objectForKey:@"app_code"];
    [self app].appVerificationCode = [dictionary objectForKey:@"app_verification_code"];
    [self app].userId = [dictionary objectForKey:@"user_id"];

   // NSLog(@"%@", dictionary);

    [[NSUserDefaults standardUserDefaults] setObject:[self app].appCode forKey:@"appCode"];
    [[NSUserDefaults standardUserDefaults] setObject:[self app].appVerificationCode forKey:@"appVerificationCode"];
    [[NSUserDefaults standardUserDefaults] setObject:[self app].userId forKey:@"userId"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"Load" object:nil];
    [self enable];
  } else {
    [self shakeView:bg];
    [self enable];
  }
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
