//
//  MKSocialShareTableViewCell.m
//
// Copyright 2012 Michael F. Kamprath
// michael@claireware.com
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
// Icons provided with this class were created with the publically available marketing
// material of each respective trademark holder. Please consult with Facebook's, Twitter's,
// and Weibo's marketing guidelines before using the provided icons in your project.
// The links to each company's marketing materials are:
//
//      Facebook    -   https://www.facebook.com/brandpermissions/logos.php
//      Twitter     -   http://twitter.com/logo
//      Weibo       -   http://open.weibo.com/wiki/微博标识/en
//

#ifndef __has_feature
#define __has_feature(x) 0
#endif
#ifndef __has_extension
#define __has_extension __has_feature // Compatibility with pre-3.0 compilers.
#endif

#if !(__has_feature(objc_arc) && __clang_major__ >= 3)
#error "MKSocialShareTableViewCell is designed to be used with ARC. Please add '-fobjc-arc' to the compiler flags of MKSocialShareTableViewCell.m."
#endif // __has_feature(objc_arc)


#import <Social/Social.h>
#import "MKSocialShareTableViewCell.h"

@interface MKSocialShareTableViewCell ()
@property (strong,nonatomic) UIButton* facebookButton;
@property (strong,nonatomic) UIButton* twitterButton;
@property (strong,nonatomic) UIButton* weiboButton;


-(void)handleFacebookAction:(id)inSender;
-(void)handleTwitterAction:(id)inSender;
-(void)handleWeiboAction:(id)inSender;
-(void)postMessageForServiceType:(NSString*)inServiceType;

@end
@implementation MKSocialShareTableViewCell
@synthesize facebookButton, twitterButton, weiboButton;
@synthesize postText, postImageList, postURLList;

#pragma mark - Class Methods

+(BOOL)socialShareAvailable {
    
    if ( NSClassFromString(@"SLComposeViewController") != nil ) {
        BOOL facebookAvailable = [SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook];
        BOOL twitterAvailable = [SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter];
        BOOL weiboAvailable = [SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo];
        
        return ( facebookAvailable || twitterAvailable || weiboAvailable );
    }
    else {
        return NO;
    }
}

#pragma mark - Cell Set Up
#define MKSOCIALSHARE_BUTTON_SIZE       24
#define MKSOCIALSHARE_RIGHT_PAD         12
#define MKSOCIALSHARE_INTERBUTTON_PAD   10
#define MKSOCIALSHARE_LABEL_BUTTON_PAD  5

- (id)initWithReuseIdentifier:(NSString *)inReuseIdentifier facebookImage:(UIImage*)inFacebookImage twitterImage:(UIImage*)inTwitterImage weiboImage:(UIImage*)inWeiboImage
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:inReuseIdentifier];
    if (self) {
        
        if ( [SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook] ) {
            self.facebookButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.facebookButton.frame = CGRectMake(0, 0, MKSOCIALSHARE_BUTTON_SIZE, MKSOCIALSHARE_BUTTON_SIZE);
            
            [self.facebookButton setImage:inFacebookImage forState:UIControlStateNormal];
            
            [self.facebookButton addTarget:self action:@selector(handleFacebookAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.contentView addSubview:self.facebookButton];
            
        }
        
        if ( [SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter] ) {
            self.twitterButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.twitterButton.frame = CGRectMake(0, 0, MKSOCIALSHARE_BUTTON_SIZE, MKSOCIALSHARE_BUTTON_SIZE);
            
            [self.twitterButton setImage:inTwitterImage forState:UIControlStateNormal];
            
            [self.twitterButton addTarget:self action:@selector(handleTwitterAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.contentView addSubview:self.twitterButton];
            
        }

        if ( [SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo] ) {
            self.weiboButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.weiboButton.frame = CGRectMake(0, 0, MKSOCIALSHARE_BUTTON_SIZE, MKSOCIALSHARE_BUTTON_SIZE);
            
            [self.weiboButton setImage:inWeiboImage forState:UIControlStateNormal];
            
            [self.weiboButton addTarget:self action:@selector(handleWeiboAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.contentView addSubview:self.weiboButton];
            
        }
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect bounds = self.contentView.bounds;
    
    CGFloat buttonOriginX = self.contentView.bounds.size.width - MKSOCIALSHARE_RIGHT_PAD - MKSOCIALSHARE_BUTTON_SIZE;
    CGFloat buttonOriginY = floorf((bounds.size.height - MKSOCIALSHARE_BUTTON_SIZE)/2.0)+1;
    const CGFloat buttonHorizInterval = MKSOCIALSHARE_BUTTON_SIZE + MKSOCIALSHARE_INTERBUTTON_PAD;
    
    if ( nil != self.facebookButton ) {
        self.facebookButton.frame = CGRectMake(buttonOriginX, buttonOriginY, MKSOCIALSHARE_BUTTON_SIZE, MKSOCIALSHARE_BUTTON_SIZE );
        
        buttonOriginX -= buttonHorizInterval;
    }
    
    if ( nil != self.twitterButton ) {
        self.twitterButton.frame = CGRectMake(buttonOriginX, buttonOriginY, MKSOCIALSHARE_BUTTON_SIZE, MKSOCIALSHARE_BUTTON_SIZE );
        
        buttonOriginX -= buttonHorizInterval;
    }
    
    if ( nil != self.weiboButton ) {
        self.weiboButton.frame = CGRectMake(buttonOriginX, buttonOriginY, MKSOCIALSHARE_BUTTON_SIZE, MKSOCIALSHARE_BUTTON_SIZE );
    }
   
    CGRect labelFrame = self.textLabel.frame;

    labelFrame.size.width = buttonOriginX - labelFrame.origin.x - MKSOCIALSHARE_LABEL_BUTTON_PAD;

    self.textLabel.frame = labelFrame;
    
}


#pragma mark - Action Methods

-(void)handleFacebookAction:(id)inSender {
    [self postMessageForServiceType:SLServiceTypeFacebook];
}

-(void)handleTwitterAction:(id)inSender {
    [self postMessageForServiceType:SLServiceTypeTwitter];
}

-(void)handleWeiboAction:(id)inSender {
    [self postMessageForServiceType:SLServiceTypeSinaWeibo];
}

-(void)postMessageForServiceType:(NSString*)inServiceType {
    SLComposeViewController* socialController = [SLComposeViewController composeViewControllerForServiceType:inServiceType];
    
    if ( nil != socialController ) {
        if ( nil != self.postText ) {
            [socialController setInitialText:self.postText];
        }
        
        if ( nil != self.postImageList ) {
            for (UIImage* image in self.postImageList ) {
                [socialController addImage:image];
            }
        }
        
        if ( nil != self.postURLList ) {
            for (NSURL* url in self.postURLList ) {
                [socialController addURL:url];
            }
        }
        
        UIResponder* targetResponder = self.nextResponder;
        if ( ![targetResponder isKindOfClass:[UIViewController class]] ) {
            targetResponder = targetResponder.nextResponder;
            
            if (![targetResponder isKindOfClass:[UIViewController class]]) {
                targetResponder = targetResponder.nextResponder;
                
                // in iOS 7, you have to go 3 deep.
                if (![targetResponder isKindOfClass:[UIViewController class]]) {
                    // uh oh
                    NSLog(@"Could not find MKSocialShareTableViewCell's owning view controller!");
                    return;
                }
            }
        }
                  
        UIViewController* currentController = (UIViewController*)targetResponder;
        
        [currentController presentViewController:socialController animated:YES completion:NULL];
       
    }
}

@end
