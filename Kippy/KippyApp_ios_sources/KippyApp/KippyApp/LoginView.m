//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "LoginView.h"
#import "TapUtils.h"

@implementation LoginView

- (id)init {
    self = [super init];
    if (self) {
      self.backgroundColor = HEXCOLOR(0xe6e6e6);
      logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kippy.png"]];
      [self addSubview:logo];
      btns = [[UIView alloc] initWithFrame:CGRectMake(0,0,250,150)];
      [self addSubview:btns];
//      UIButton* btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 50*0, 250, 50)];
//      [btn1 setImage:[UIImage imageNamed:@"btn_signin_fb.png"] forState:UIControlStateNormal];
//      [btns addSubview:btn1];

      btnFb = [[FBLoginView alloc] init];
      btnFb.readPermissions =    @[@"email",@"basic_info"];
      btnFb.layer.borderColor = [[UIColor clearColor] CGColor];
      btnFb.layer.borderWidth = 1;
      btnFb.layer.cornerRadius = 0;
      btnFb.delegate = self;
      [btns addSubview:btnFb];
      btnFb.frame =CGRectMake(0, 50*0, 250, 50);

      UIButton* btn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 50*1, 250, 50)];
      [btn2 setImage:[UIImage imageNamed:@"btn_signup.png"] forState:UIControlStateNormal];
      [btn2 addTarget:self action:@selector(signup) forControlEvents:UIControlEventTouchUpInside];
      [btns addSubview:btn2];
      UIButton* btn3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 50*2, 250, 50)];
      [btn3 setImage:[UIImage imageNamed:@"btn_signin.png"] forState:UIControlStateNormal];
      [btn3 addTarget:self action:@selector(signin) forControlEvents:UIControlEventTouchUpInside];
      [btns addSubview:btn3];
      n = 1;
      fbdone = NO;
    }
    return self;
}

-(void)idle {
  n++;
  if(n%50 == 0 && !fbdone) {
    [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection,
                                                           id<FBGraphUser> fbUserData,
                                                           NSError *error)
     {

       if (!error)
       {

         if ([fbUserData objectForKey:@"email"])
         {
           NSString *FBEmail = [fbUserData objectForKey:@"email"];

           if (![FBEmail isEqualToString:@""] && FBEmail != nil)
           {

             NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];

             NSString *FBId = [fbUserData objectForKey:@"id"];

             if (![FBId isEqualToString:@""] && FBId != nil)
             {
               [dict setObject:FBId forKey:@"FB_ID"];
             }else
             {
               [dict setObject:@"" forKey:@"FB_ID"];
             }

             NSString *FBEmail = [fbUserData objectForKey:@"email"];

             if (![FBEmail isEqualToString:@""] && FBEmail != nil)
             {
               [dict setObject:FBEmail forKey:@"FB_Email"];
             }else
             {
               [dict setObject:@"" forKey:@"FB_Email"];
             }

             NSString *name = [fbUserData objectForKey:@"name"];

             if (![name isEqualToString:@""] && name != nil)
             {
               [dict setObject:name forKey:@"FB_FullName"];
             }else
             {
               [dict setObject:@"" forKey:@"FB_FullName"];
             }

             NSString *first_name = [fbUserData objectForKey:@"first_name"];

             if (![first_name isEqualToString:@""] && first_name != nil)
             {
               [dict setObject:first_name forKey:@"FB_FirstName"];
             }else
             {
               [dict setObject:@"" forKey:@"FB_FirstName"];
             }

             NSString *last_name = [fbUserData objectForKey:@"last_name"];

             if (![last_name isEqualToString:@""] && last_name != nil)
             {
               [dict setObject:last_name forKey:@"FB_LastName"];
             }else
             {
               [dict setObject:@"" forKey:@"FB_LastName"];
             }

             NSString *username = [fbUserData objectForKey:@"username"];

             if (![username isEqualToString:@""] && username != nil)
             {
               [dict setObject:username forKey:@"FB_UserName"];
             }else
             {
               [dict setObject:@"" forKey:@"FB_UserName"];
             }

             if ([[fbUserData objectForKey:@"gender"] isEqualToString:@"male"])
             {
               [dict setObject:@"Male" forKey:@"FB_Gender"];
             }
             else{
               [dict setObject:@"Female" forKey:@"FB_Gender"];
             }

             NSString *birthday = [fbUserData objectForKey:@"birthday"];

             NSDateFormatter *format1 = [[NSDateFormatter alloc] init];
             [format1 setDateFormat:@"MM/dd/yyyy"];
             NSDate *dateConversion = [format1 dateFromString:birthday];
             //[format1 release];

             NSDateFormatter *format = [[NSDateFormatter alloc] init];
             [format setDateFormat:@"yyyy-MM-dd"];

             birthday = [format stringFromDate:dateConversion];

             if (![birthday isEqualToString:@""] && birthday != nil)
             {
               [dict setObject:birthday forKey:@"FB_DOB"];
             }else
             {
               [dict setObject:@"" forKey:@"FB_DOB"];
             }
             //[format release];

             NSDictionary *locationDict = [fbUserData objectForKey:@"location"];
             if(locationDict)
             {
               NSString *locationStr =  [locationDict objectForKey:@"name"];
               if(locationStr.length > 0)
               {
                 NSArray *locationsComponentsArr = [locationStr componentsSeparatedByString:@","];

                 if([locationsComponentsArr objectAtIndex:0])
                 {
                   [dict setObject:[locationsComponentsArr objectAtIndex:0] forKey:@"FB_City"];
                 }else
                 {
                   [dict setObject:@"" forKey:@"FB_City"];
                 }
                 if([locationsComponentsArr objectAtIndex:1])
                 {
                   [dict setObject:[locationsComponentsArr objectAtIndex:1] forKey:@"FB_Country"];
                 }else
                 {
                   [dict setObject:@"" forKey:@"FB_Country"];
                 }
               }
               else
               {
                 [dict setObject:@"" forKey:@"FB_City"];
                 [dict setObject:@"" forKey:@"FB_Country"];
               }
             }else
             {
               [dict setObject:@"" forKey:@"FB_City"];
               [dict setObject:@"" forKey:@"FB_Country"];
             }

             [[NSNotificationCenter defaultCenter] postNotificationName:@"FBUserDataDictInfo" object:dict];

             NSLog(@"FBUserDataDictInfo: %@", dict);

             fbdone = YES;

             dict = nil;
           }
         }
       }
     }];  }
}

-(void)signin {
  [[NSNotificationCenter defaultCenter] postNotificationName:@"Signin" object:nil];
}

-(void)signup {
  [[NSNotificationCenter defaultCenter] postNotificationName:@"Signup" object:nil];
}

-(void)layoutSubviews {
  CGSize size = self.frame.size;
  logo.center = CGPointMake(size.width/2,size.height/4);
  btns.center = CGPointMake(size.width/2,size.height/2+size.height/4);
}

@end
