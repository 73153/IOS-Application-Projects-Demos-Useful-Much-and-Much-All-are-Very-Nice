//
//  PXPViewController.h
//  GradientColorSample
//
//  Created by Louka Desroziers on 17/08/13.
//  Copyright (c) 2013 PixiApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PXPGradientColor.h"

@interface PXPGradientGeometryView : UIView
@property (nonatomic, assign) CGFloat               angle;
@property (nonatomic, strong) PXPGradientColor      *gradient;
@property (nonatomic, strong) UIBezierPath          *bezierPath;
@end


@interface PXPViewController : UIViewController

@end
