//
//  PSFilePickerController.h
//  PSFilePickerController
//
//  Created by Josh Kugelmann on 18/08/12.
//  Copyright (c) 2012 Josh Kugelmann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSDirectoryPickerDelegate.h"

@interface PSDirectoryPickerController : UINavigationController {
    NSString *_rootDirectory;
    NSString *_prompt;
    NSString *_doneButtonTitle;
}

@property (nonatomic, assign) id<UINavigationControllerDelegate, PSDirectoryPickerDelegate> delegate;
@property (nonatomic, copy) NSString *rootDirectory;
@property (nonatomic, copy) NSString *prompt;
@property (nonatomic, copy) NSString *doneButtonTitle;

- (id)initWithRootDirectory:(NSString *)directory;
- (void)cancelButtonTapped;
- (void)doneButtonTapped;

@end
