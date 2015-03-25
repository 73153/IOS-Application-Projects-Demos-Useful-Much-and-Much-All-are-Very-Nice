//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "KippyProfileView.h"
#import "AppDelegate.h"
#import "AppDelegate.h"
#import "KippyPhoto.h"
#import "KippySlider.h"
#import "AppLabel.h"
#import "FormInput.h"
#import "ASIFormDataRequest.h"

@implementation KippyProfileView

- (id)initWithTitle:(NSString *)title {
  self = [super initWithTitle:title];
  if (self) {
    container = [[UIScrollView alloc] init];
    [self addSubview:container];
    container.backgroundColor = [UIColor whiteColor];
    [self bringSubviewToFront:spinner];
    photo = [[KippyPhoto alloc] initWithWhiteMask:YES];
    [container addSubview:photo];
    {
      FormInput* input = [[FormInput alloc] initWithLabel:@"Kippy ID:" placeholder:@"KippyID"];
      input.tag = 1;
      input.userInteractionEnabled = NO;
      input.alpha = 0.5;
      [container addSubview:input];
    }
    {
      FormInput* input = [[FormInput alloc] initWithLabel:@"Pet Name:" placeholder:@"Name"];
      input.tag = 1;
      [container addSubview:input];
    }
    {
      FormInput* input = [[FormInput alloc] initWithLabel:@"Update Frequency:" placeholder:@""];
      input.tag = 1;
      input.userInteractionEnabled = NO;
      input.alpha = 0.5;
      [container addSubview:input];
    }

    slider = [[KippySlider alloc] initWithFrame:CGRectZero];
    [container addSubview:slider];
    [slider reset];
    
    btnDone = [[UIButton alloc] initWithFrame:CGRectMake(0,0,74,44)];
    [btnDone setImage:[UIImage imageNamed:@"btn_done.png"] forState:UIControlStateNormal];
    [btnDone addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnDone];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fillForm) name:@"UserDataChanged" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(frequencyChanged:) name:@"FrequencyChanged" object:nil];

  }
  return self;
}

-(void)frequencyChanged:(NSNotification*)notification {
  int n = [notification.object intValue];
  if(n == 1) {
    [self fillInput:3 value:[NSString stringWithFormat:@"Every %d hour", n]];
  } else {
    [self fillInput:3 value:[NSString stringWithFormat:@"Every %d hours", n]];
  }
  frequency = n;
}

-(void)done {
 // NSLog(@"%@", [self app].selectedKippy);
  NSString* kippyName = [self inputValue:2];
  [self standby];
  [self disable];
  ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://dev.kippy.eu/kippymap_modifyKippy.php?app_code=%@&app_verification_code=%@&update_frequency=%d", [self app].appCode, [self app].appVerificationCode, frequency*3600]]];
  [request addPostValue:[[self app].selectedKippy objectForKey:@"id"] forKey:@"modify_kippy_id"];
  [request addPostValue:kippyName forKey:@"modify_kippy_name"];
  [request setDelegate:self];
  [request setDidFinishSelector:@selector(uploadFinished:)];
  [request startAsynchronous];
}

-(void)enable {
  [super enable];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"Back" object:nil];
}


-(void)uploadFinished:(ASIFormDataRequest *)request {
 // NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[request responseData] options: NSJSONReadingMutableContainers error: nil];
 // NSLog(@"%@", dictionary);
  [[NSNotificationCenter defaultCenter] postNotificationName:@"DataExpired" object:nil];
 [self enable];
}

-(void)setup:(NSDictionary*)dict {
  self.info = dict;
//  NSLog(@"%@", info);
  [self fillForm];
  [photo setup:dict];
  [self performSelector:@selector(disable) withObject:nil afterDelay:0];
  [[self app] downloadResource:[NSString stringWithFormat:@"%@kippymap_getKippyModifyData.php?app_code=%@&app_verification_code=%@&kippy_id=%@", SERVER_URL, [self app].appCode, [self app].appVerificationCode, [self.info objectForKey:@"id"]] sender:self];
  [slider reset];
}

-(void)updateData {
}

-(void)downloadResourceSuccess:(ASIHTTPRequest*)request {
  NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[request responseData] options: NSJSONReadingMutableContainers error: nil];
  if(dictionary == nil) {
    [self shakeView:self];
  } else {
    self.info = dictionary;
    [self fillForm];
    [super enable];
 }
}

-(void)downloadResourceFailed:(ASIHTTPRequest*)request {
  [self shakeView:self];
  [spinner stopAnimating];
}

-(void)fillForm {
  [self fillInput:1 value:[self.info objectForKey:@"serial_number"]];
  [self fillInput:2 value:[self.info objectForKey:@"name"]];
  int seconds = [[self.info objectForKey:@"update_frequency"] intValue];
  frequency = seconds/3600;
  if(frequency >0 && frequency <= 20) {
    [slider setMinutes:frequency];
  }
}

-(void)fillInput:(int)index value:(NSString*)text {
  int n = 1;
  for(FormInput* input in [container subviews]) {
    if([input isKindOfClass:[FormInput class]]) {
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
    if([input isKindOfClass:[FormInput class]]) {
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
  slider.frame = CGRectMake((size.width-320)/2, y, 320, 32);
  container.contentSize = CGSizeMake(size.width,y+10+240+32);
  btnDone.center = CGPointMake(size.width-btnDone.frame.size.width/2, btnDone.frame.size.height/2);
}

@end
