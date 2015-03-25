//
//  ViewController.m
//  BrowserTabViewDemo
//
//  Created by xiao haibo on 9/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize label;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    tabController= [[BrowserTabView alloc] initWithTabTitles:[NSArray arrayWithObjects:@"Tab 1",@"Tab 2",@"Tab 3", nil]
                                                 andDelegate:self];

    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setImage:[UIImage imageNamed:@"tab_new_add.png"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    addButton.frame = CGRectMake(1024-40, 5, 27 , 27);
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    [self.view addSubview:tabController];
    [self.view addSubview:addButton];

}

- (void)viewDidUnload
{
    [self setLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

-(void)add:(id)sender
{
    [tabController addTabWithTitle:nil];
}

#pragma mark -
#pragma mark BrowserTabViewDelegate
-(void)BrowserTabView:(BrowserTabView *)browserTabView didSelecedAtIndex:(NSUInteger)index
{
    NSLog(@"BrowserTabView select Tab at index:  %d",index);
    self.label.text = [NSString stringWithFormat:@"Tab selected at: %d",index +1];
}

-(void)BrowserTabView:(BrowserTabView *)browserTabView willRemoveTabAtIndex:(NSUInteger)index {
    NSLog(@"BrowserTabView WILL Remove Tab at index:  %d",index);

}

-(void)BrowserTabView:(BrowserTabView *)browserTabView didRemoveTabAtIndex:(NSUInteger)index{
    NSLog(@"BrowserTabView did Remove Tab at index:  %d",index);
}
-(void)BrowserTabView:(BrowserTabView *)browserTabView exchangeTabAtIndex:(NSUInteger)fromIndex withTabAtIndex:(NSUInteger)toIndex{

 NSLog(@"BrowserTabView exchange Tab  at index:  %d with Tab at index :%d ",fromIndex,toIndex);
}

- (BOOL)browserTabView:(BrowserTabView *)tabView shouldChangeTitle:(NSString *)title {
    if (title.length) {
        return YES;
    };
    return NO;
}

- (void)dealloc {
    [label release];
    [super dealloc];
}
@end
