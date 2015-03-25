//
//  ViewController.m
//  PSDirectoryPicker Demo
//
//  Created by Josh Kugelmann on 1/09/12.
//  Copyright (c) 2012 Josh Kugelmann. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)chooseDirectory
{
    // Use -initWithRootDirectory: to specify a path. -init defaults to the application's Documents directory.
    PSDirectoryPickerController *directoryPicker = [[PSDirectoryPickerController alloc] initWithRootDirectory:[[NSBundle mainBundle] bundlePath]];
    
    [directoryPicker setDelegate:self];
    [directoryPicker setPrompt:@"Choose a directory"];
    [directoryPicker setModalPresentationStyle:UIModalPresentationFormSheet];
    
    [self presentModalViewController:directoryPicker animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[self view] setBackgroundColor:[UIColor whiteColor]];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self action:@selector(chooseDirectory) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Choose a directory" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 240, 48)];
    [button setCenter:[[self view] center]];
    [[self view] addSubview:button];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - Directory Picker Delegate
- (void)directoryPickerControllerDidCancel:(PSDirectoryPickerController *)picker
{
    NSLog(@"Cancelled!");
}

- (void)directoryPickerController:(PSDirectoryPickerController *)picker didFinishPickingDirectoryAtPath:(NSString *)path
{
    NSLog(@"Picked directory at %@", path);
}

@end
