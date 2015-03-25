//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "ProfileView.h"
#import "AppDelegate.h"
#import "AppDelegate.h"
#import "UserPhoto.h"
#import "AppLabel.h"
#import "FormInput.h"
#import "ASIFormDataRequest.h"

@implementation ProfileView

- (id)initWithTitle:(NSString *)title {
  self = [super initWithTitle:title];
  if (self) {
    container = [[UIScrollView alloc] init];
    [self addSubview:container];
    container.backgroundColor = [UIColor whiteColor];
    [self bringSubviewToFront:spinner];
    photo = [[UserPhoto alloc] initWithWhiteMask:YES];
    [container addSubview:photo];
    AppLabel* label = [[AppLabel alloc] initWithStyle:AppLabelStyleBlueBoldCenter];
    [container addSubview:label];
    [label set:@"User Details"];
    {
      FormInput* input = [[FormInput alloc] initWithLabel:@"Name:" placeholder:@"User Name"];
      input.tag = 2;
      [container addSubview:input];
    }
    {
      FormInput* input = [[FormInput alloc] initWithLabel:@"Surname:" placeholder:@"User Surname"];
      input.tag = 2;
      [container addSubview:input];
    }
    {
      FormInput* input = [[FormInput alloc] initWithLabel:@"Password:" placeholder:@"Password"];
      input.tag = 2;
      [input input].secureTextEntry = YES;
      [container addSubview:input];
    }
    {
      FormInput* input = [[FormInput alloc] initWithLabel:@"Confirm Password:" placeholder:@"Confirm Password"];
      input.tag = 2;
      [input input].secureTextEntry = YES;
      [container addSubview:input];
    }
    {
      FormInput* input = [[FormInput alloc] initWithLabel:@"Birth Date:" placeholder:@"dd/mm/yyyyy"];
      input.tag = 2;
      [container addSubview:input];
    }
    {
      FormInput* input = [[FormInput alloc] initWithLabel:@"Address:" placeholder:@"User Address"];
      input.tag = 2;
      [container addSubview:input];
    }
    {
      FormInput* input = [[FormInput alloc] initWithLabel:@"City:" placeholder:@"User City"];
      input.tag = 2;
      [container addSubview:input];
    }
    {
      FormInput* input = [[FormInput alloc] initWithLabel:@"Phone Number:" placeholder:@"User Phone Number"];
      input.tag = 2;
      [container addSubview:input];
    }
    btnDone = [[UIButton alloc] initWithFrame:CGRectMake(0,0,74,44)];
    [btnDone setImage:[UIImage imageNamed:@"btn_done.png"] forState:UIControlStateNormal];
    [btnDone addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnDone];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fillForm) name:@"UserDataChanged" object:nil];
  }
  return self;
}

-(void)done {
  [self standby];
  NSString* name = [self inputValue:1];
  NSString* surname = [self inputValue:2];
  NSString* password = [self inputValue:3];
  NSString* confirmPassword = [self inputValue:4];
  NSString* birth_date = [self inputValue:5];
  NSString* address = [self inputValue:6];
  NSString* city = [self inputValue:7];
  NSString* phone = [self inputValue:8];

  BOOL hasErrors = NO;
  if([name length] == 0) {
    hasErrors = YES;
  }
  if([surname length] == 0) {
    hasErrors = YES;
  }
  if([password length] < 8) {
    [[[UIAlertView alloc] initWithTitle:@"The password is too short" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    return;
  }
  if([password compare:confirmPassword] != NSOrderedSame) {
    [[[UIAlertView alloc] initWithTitle:@"Confirm password incorrect" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    return;
  }
  if([name length] == 0) {
    hasErrors = YES;
  }
  if(hasErrors) {
    [[[UIAlertView alloc] initWithTitle:@"The data entered are incorrect" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    return;
  }

  [self disable];

  ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://dev.kippy.eu/kippymap_modifyUserData.php?app_code=%@&app_verification_code=%@", [self app].appCode, [self app].appVerificationCode]]];
  [request addPostValue:name forKey:@"user_name"];
  [request addPostValue:surname forKey:@"user_surname"];
  [request addPostValue:password forKey:@"user_password"];
  [request addPostValue:birth_date forKey:@"user_birth_date"];
  [request addPostValue:address forKey:@"user_address"];
  [request addPostValue:city forKey:@"user_city"];
  [request addPostValue:phone forKey:@"user_phone"];
  [request setDelegate:self];
  [request setDidFinishSelector:@selector(uploadFinished:)];
  [request startAsynchronous];
}

-(void)uploadFinished:(ASIFormDataRequest *)request {
  [[NSNotificationCenter defaultCenter] postNotificationName:@"UserDataExpired" object:nil];
  [self enable];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"Standby" object:nil];
}

-(void)setup {

  [self standby];
  [self performSelector:@selector(disable) withObject:nil afterDelay:0];
  [[self app] downloadResource:[NSString stringWithFormat:@"%@kippymap_getUserData.php?app_code=%@&app_verification_code=%@", SERVER_URL, [self app].appCode, [self app].appVerificationCode] sender:self];
}

-(void)downloadResourceSuccess:(ASIHTTPRequest*)request {
  NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[request responseData] options: NSJSONReadingMutableContainers error: nil];
  if(dictionary == nil) {
    [self shakeView:self];
  } else {
    [self app].userData = dictionary;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UserDataChanged" object:nil];
    [self enable];
  }
}

-(void)fillForm {
  [self fillInput:1 value:[[self app].userData objectForKey:@"name"]];
  [self fillInput:2 value:[[self app].userData objectForKey:@"surname"]];
  [self fillInput:3 value:[[self app].userData objectForKey:@"password"]];
  [self fillInput:4 value:[[self app].userData objectForKey:@"password"]];
  [self fillInput:5 value:[[self app].userData objectForKey:@"birth_date"]];
  [self fillInput:6 value:[[self app].userData objectForKey:@"address"]];
  [self fillInput:7 value:[[self app].userData objectForKey:@"city"]];
  [self fillInput:8 value:[[self app].userData objectForKey:@"phone"]];
}

-(void)fillInput:(int)index value:(NSString*)text {
  int n = 1;
  for(FormInput* input in [container subviews]) {
    if([input isKindOfClass:[FormInput class]] && input.tag == 2) {
      if(index == n) {
        [input input].text = text;
        return;
      }
      n++;
    }
  }
}

-(NSString*)inputValue:(int)index {
  int n = 1;
  for(FormInput* input in [container subviews]) {
    if([input isKindOfClass:[FormInput class]] && input.tag == 2) {
      if(index == n) {
        return [input input].text;
      }
      n++;
    }
  }
  return @"";
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField endEditing:YES];
  return NO;
}

-(void)layoutSubviews {
  [super layoutSubviews];
  CGSize size = self.frame.size;
  photo.frame = CGRectMake((size.width-80)/2,10,80,80);
  container.frame = CGRectMake(0,44,size.width,size.height-44);
  int y = 90;
  for(FormInput* input in [container subviews]) {
    if([input isKindOfClass:[FormInput class]] && input.tag == 1) {
      input.frame = CGRectMake(0,y,size.width,30);
      [input input].delegate = self;
      y += 30;
    }
  }
  y+=10;
  for(AppLabel* label in [container subviews]) {
    if([label isKindOfClass:[AppLabel class]]) {
      label.frame = CGRectMake(0,y,size.width,30);
      y += 30;
    }
  }
  y+=10;
  for(FormInput* input in [container subviews]) {
    if([input isKindOfClass:[FormInput class]] && input.tag == 2) {
      input.frame = CGRectMake(0,y,size.width,30);
      [input input].delegate = self;
      y += 30;
    }
  }
  container.contentSize = CGSizeMake(size.width,y+10+240);
  btnDone.center = CGPointMake(size.width-btnDone.frame.size.width/2, btnDone.frame.size.height/2);
}

@end
