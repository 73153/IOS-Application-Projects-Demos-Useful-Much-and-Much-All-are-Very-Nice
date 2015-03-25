//
//  PSFilePickerController.m
//  PSFilePickerController
//
//  Created by Josh Kugelmann on 18/08/12.
//  Copyright (c) 2012 Josh Kugelmann. All rights reserved.
//

#import "PSDirectoryPickerController.h"
#import "PSDirectoryListViewController.h"

@implementation PSDirectoryPickerController

@synthesize rootDirectory = _rootDirectory;
@synthesize prompt = _prompt;
@synthesize doneButtonTitle = _doneButtonTitle;

- (id)init
{
    // If no root directory is specified, default to the Documents directory.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    self = [self initWithRootDirectory:documentsDirectory];
    
    return self;
}

- (id)initWithRootDirectory:(NSString *)directory
{
    self = [super init];
    
    if (self) {        
        _rootDirectory = [directory copy];
        
        // Set up the inital directory list.
        PSDirectoryListViewController *directoryList = [[PSDirectoryListViewController alloc] initWithDirectoryAtPath:_rootDirectory];
        [self pushViewController:directoryList animated:NO];
        [directoryList release];
        
        // Set default done button title.
        _doneButtonTitle = @"Done";
        
        // Show the toolbar.
        [self setToolbarHidden:NO];
    }
    
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)dealloc
{
    [_rootDirectory release];
    
    [super dealloc];
}

- (void)cancelButtonTapped
{
    [self dismissModalViewControllerAnimated:YES];
    
    if ([[self delegate] respondsToSelector:@selector(directoryPickerControllerDidCancel:)]) {
        [[self delegate] directoryPickerControllerDidCancel:self];
    }
}

- (void)doneButtonTapped
{
    [self dismissModalViewControllerAnimated:YES];
    
    PSDirectoryListViewController *visibleViewController = (PSDirectoryListViewController *)[self visibleViewController];
    
    if ([[self delegate] respondsToSelector:@selector(directoryPickerController:didFinishPickingDirectoryAtPath:)]) {
        [[self delegate] directoryPickerController:self didFinishPickingDirectoryAtPath:[visibleViewController path]];
    }
}

@end
