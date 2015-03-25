//
//  ViewController.h
//  PSDirectoryPicker Demo
//
//  Created by Josh Kugelmann on 1/09/12.
//  Copyright (c) 2012 Josh Kugelmann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSDirectoryPickerController/PSDirectoryPickerController.h"

@interface ViewController : UIViewController <PSDirectoryPickerDelegate>

- (void)chooseDirectory;

@end
