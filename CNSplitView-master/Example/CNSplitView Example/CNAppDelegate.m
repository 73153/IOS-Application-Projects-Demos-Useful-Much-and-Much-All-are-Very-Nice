//
//  CNAppDelegate.m
//  CNSplitView Example
//
//  Created by Frank Gregor on 03.01.13.
//  Copyright (c) 2013 cocoa:naut. All rights reserved.
//

#import "CNAppDelegate.h"

static NSUInteger attachedSubViewIndex = 0;

@interface CNAppDelegate () {
	CNSplitViewToolbar *toolbar;
	BOOL useAnimations;
}
@end

@implementation CNAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSString *placeholder = @"A wonderful serenity has taken possession of my entire soul, like these sweet mornings of spring which I enjoy with my whole heart.";
//	self.secondView.text = placeholder;
    self.secondView.attributedText = [[NSAttributedString alloc] initWithString:placeholder attributes:[self placeholderTextAttributes]];
	self.secondView.textBoxWidth = 350;
    self.secondView.iconTextMargin = 20.0;
	self.secondView.icon = [NSImage imageNamed:@"SplitLeaf-Icon"];
	self.secondView.iconVerticalOffset = 70;

	useAnimations = NO;

	NSMenu *contextMenu = [[NSMenu alloc] init];
	[contextMenu addItemWithTitle:@"Add new Item" action:@selector(contextMenuItemSelection:) keyEquivalent:@""];
	[contextMenu addItemWithTitle:@"Add new Group" action:@selector(contextMenuItemSelection:) keyEquivalent:@""];
	CNSplitViewToolbarButton *button1 = [[CNSplitViewToolbarButton alloc] initWithContextMenu:contextMenu];
	button1.imageTemplate = CNSplitViewToolbarButtonImageTemplateAdd;

	CNSplitViewToolbarButton *button2 = [[CNSplitViewToolbarButton alloc] init];
	button2.imageTemplate = CNSplitViewToolbarButtonImageTemplateRemove;

	CNSplitViewToolbarButton *button3 = [[CNSplitViewToolbarButton alloc] init];
	button3.imageTemplate = CNSplitViewToolbarButtonImageTemplateLockUnlocked;
	button3.imagePosition = NSImageRight;
	button3.title = @"Lock";

	CNSplitViewToolbarButton *button4 = [[CNSplitViewToolbarButton alloc] init];
	button4.imageTemplate = CNSplitViewToolbarButtonImageTemplateRefresh;
	button4.title = @"Refresh";

	NSTextField *textField = [[NSTextField alloc] init];
	[textField setBezeled:YES];
	[textField setBezeled:NSTextFieldRoundedBezel];
	[textField setToolbarItemWidth:120.0];

	NSPopUpButton *popupButton = [[NSPopUpButton alloc] init];
	[popupButton setToolbarItemWidth:120];
	[popupButton addItemsWithTitles:@[@"Chelsea Manning...", @"Edward Snowden...", @"Aaron Swartz..."]];
	[[popupButton cell] setControlSize:NSSmallControlSize];

	NSSlider *slider = [[NSSlider alloc] init];
	[slider setToolbarItemWidth:120.0];
	[[slider cell] setControlSize:NSSmallControlSize];


	toolbar = [[CNSplitViewToolbar alloc] init];
	[toolbar addItem:button1 align:CNSplitViewToolbarItemAlignLeft];
	[toolbar addItem:button2 align:CNSplitViewToolbarItemAlignLeft];
	[toolbar addItem:button3 align:CNSplitViewToolbarItemAlignRight];
	[toolbar addItem:button4 align:CNSplitViewToolbarItemAlignRight];
//    [toolbar addItem:popupButton align:CNSplitViewToolbarItemAlignLeft];

	self.splitView.delegate = self;
	self.splitView.toolbarDelegate = self;
	[self.splitView attachToolbar:toolbar toSubViewAtIndex:attachedSubViewIndex onEdge:CNSplitViewToolbarEdgeBottom];
}

#pragma mark - Helper

- (NSDictionary *)placeholderTextAttributes {
    NSShadow *textShadow = [[NSShadow alloc] init];
    [textShadow setShadowColor: [NSColor whiteColor]];
    [textShadow setShadowOffset: NSMakeSize(0, -1)];

    NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    [textStyle setAlignment: NSCenterTextAlignment];

    NSDictionary *attr = @{
        NSFontAttributeName :               [NSFont fontWithName:@"HelveticaNeue" size:15],
        NSForegroundColorAttributeName :    [NSColor grayColor],
        NSShadowAttributeName :             textShadow,
        NSParagraphStyleAttributeName :     textStyle,
        NSKernAttributeName :               @(0.80)
    };
    return attr;
}

#pragma mark - Actions

- (void)contextMenuItemSelection:(id)sender {
	CNLog(@"selected menu item: %@", [(NSMenuItem *)sender title]);
}

- (IBAction)showHideToolbarAction:(id)sender {
	if ([(NSButton *)sender state] == NSOnState) [self.splitView showToolbarAnimated:useAnimations];
	else [self.splitView hideToolbarAnimated:useAnimations];
}

- (IBAction)useAnimationsAction:(id)sender {
	if ([(NSButton *)sender state] == NSOnState) useAnimations = YES;
	else useAnimations = NO;
}

- (IBAction)enableDisableToolbarItemsAction:(id)sender {
	if ([(NSButton *)sender state] == NSOnState) [toolbar disable];
	else [toolbar enable];
}

- (IBAction)enableDisableToolbarItemsDelimiterAction:(id)sender {
	if ([(NSButton *)sender state] == NSOnState) toolbar.itemDelimiterEnabled = NO;
	else toolbar.itemDelimiterEnabled = YES;
}

- (IBAction)centerToolbarItemsAction:(id)sender {
	if ([(NSButton *)sender state] == NSOnState) toolbar.contentAlign = CNSplitViewToolbarContentAlignCentered;
	else toolbar.contentAlign = CNSplitViewToolbarContentAlignItemDirected;
}

- (IBAction)draggingHandleEnabledAction:(id)sender {
	if ([(NSButton *)sender state] == NSOnState) self.splitView.draggingHandleEnabled = YES;
	else self.splitView.draggingHandleEnabled = NO;
}

- (IBAction)splitViewOrientationAction:(id)sender {
	switch ([self.splitViewOrientationPopUp indexOfSelectedItem]) {
		case CNSplitViewDeviderOrientationVertical: {
			[self.splitView setVertical:YES];
			break;
		}

		case CNSplitViewDeviderOrientationHorizontal: {
			[self.splitView setVertical:NO];
			break;
		}
	}
}

- (CGFloat)splitView:(NSSplitView *)splitView constrainMinCoordinate:(CGFloat)proposedMin ofSubviewAt:(NSInteger)dividerIndex {
	return 180;
}

- (CGFloat)splitView:(NSSplitView *)splitView constrainMaxCoordinate:(CGFloat)proposedMax ofSubviewAt:(NSInteger)dividerIndex {
	return [[[self window] contentView] bounds].size.width - 180;
}

#pragma mark - CNSplitViewToolbar Delegate

- (NSUInteger)toolbarAttachedSubviewIndex:(CNSplitViewToolbar *)theToolbar {
	return attachedSubViewIndex;
}

- (void)splitView:(CNSplitView *)theSplitView willShowToolbar:(CNSplitViewToolbar *)theToolbar onEdge:(CNSplitViewToolbarEdge)theEdge {
	NSLog(@"splitView:willShowToolbar:onEdge:");
}

- (void)splitView:(CNSplitView *)theSplitView didShowToolbar:(CNSplitViewToolbar *)theToolbar onEdge:(CNSplitViewToolbarEdge)theEdge {
	NSLog(@"splitView:didShowToolbar:onEdge:");
}

- (void)splitView:(CNSplitView *)theSplitView willHideToolbar:(CNSplitViewToolbar *)theToolbar onEdge:(CNSplitViewToolbarEdge)theEdge {
	NSLog(@"splitView:willHideToolbar:onEdge:");
}

- (void)splitView:(CNSplitView *)theSplitView didHideToolbar:(CNSplitViewToolbar *)theToolbar onEdge:(CNSplitViewToolbarEdge)theEdge {
	NSLog(@"splitView:didHideToolbar:onEdge:");
}

@end
