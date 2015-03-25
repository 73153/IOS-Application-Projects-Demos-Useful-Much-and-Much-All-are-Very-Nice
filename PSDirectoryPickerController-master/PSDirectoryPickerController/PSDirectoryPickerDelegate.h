//
//  PSDirectoryPickerDelegate.h
//  PSFilePickerController
//
//  Created by Josh Kugelmann on 26/08/12.
//  Copyright (c) 2012 Josh Kugelmann. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PSDirectoryPickerController;

@protocol PSDirectoryPickerDelegate <UINavigationControllerDelegate>

@optional
- (void)directoryPickerController:(PSDirectoryPickerController *)picker didFinishPickingDirectoryAtPath:(NSString *)path;
- (void)directoryPickerControllerDidCancel:(PSDirectoryPickerController *)picker;

@end
