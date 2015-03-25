//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;

@interface TapView : UIView {
  NSDictionary* info;
}

-(id)initWithDictionary:(NSDictionary*)dictionary;

@property (nonatomic, copy) NSDictionary* info;

-(AppDelegate*)app;
-(void)shakeView:(UIView *)viewToShake;

-(int)y0;

@end
