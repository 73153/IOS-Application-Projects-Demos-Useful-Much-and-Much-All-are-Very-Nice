//
//  CNAppDelegate.h
//  CNSplitView Example
//
//  Created by Frank Gregor on 03.01.13.
//  Copyright (c) 2013 cocoa:naut. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CNBaseView.h"
#import "CNSplitView.h"

@interface CNAppDelegate : NSObject <NSApplicationDelegate, CNSplitViewToolbarDelegate>

@property (strong) IBOutlet NSWindow *window;
@property (strong) IBOutlet CNSplitView *splitView;

@property (strong, nonatomic) IBOutlet CNBaseView *secondView;
@property (strong) IBOutlet NSOutlineView *outlineView;

@property (strong) IBOutlet NSButton *showHideToolbarCheckbox;
@property (strong) IBOutlet NSButton *useAnimationsCheckbox;
@property (strong) IBOutlet NSButton *enableDisableToolbarItemsCheckbox;
@property (strong) IBOutlet NSButton *enableDisableToolbarItemsDelimiterCheckbox;
@property (strong) IBOutlet NSButton *centerToolbarItemsCheckbox;
@property (strong) IBOutlet NSButton *draggingHandleEnabledCheckbox;
@property (strong) IBOutlet NSPopUpButton *splitViewOrientationPopUp;


- (IBAction)showHideToolbarAction:(id)sender;
- (IBAction)useAnimationsAction:(id)sender;
- (IBAction)enableDisableToolbarItemsAction:(id)sender;
- (IBAction)enableDisableToolbarItemsDelimiterAction:(id)sender;
- (IBAction)centerToolbarItemsAction:(id)sender;
- (IBAction)draggingHandleEnabledAction:(id)sender;
- (IBAction)splitViewOrientationAction:(id)sender;
@end
