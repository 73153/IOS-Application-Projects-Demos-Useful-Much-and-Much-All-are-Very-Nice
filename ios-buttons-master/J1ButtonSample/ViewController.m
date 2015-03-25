//
//  ViewController.m
//  J1Button
//
//  Created by John Campbell on 2/10/13.
//  Copyright (c) 2013 John Campbell. All rights reserved.
//

#import "ViewController.h"
#import "J1Button.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet J1Button *button;
@property (weak, nonatomic) IBOutlet J1Button *red;
@property (weak, nonatomic) IBOutlet J1Button *blue;
@property (weak, nonatomic) IBOutlet J1Button *green;
@property (weak, nonatomic) IBOutlet J1Button *grayOnBlack;

@property (strong, nonatomic) IBOutlet UISwitch *sizeToggler;
@property (strong, nonatomic) IBOutlet UISlider *scaleTest;
@property (nonatomic) CGRect defaultFrame;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.defaultFrame = self.button.frame;
    self.red.color = J1ButtonColorRed;
    self.blue.color = J1ButtonColorBlue;
    self.green.color = J1ButtonColorGreen;
    self.grayOnBlack.color = J1ButtonColorGrayOnBlack;
    
}
- (IBAction)showNormalState:(id)sender {
    [self removeStylesForButton:self.button];
}
- (IBAction)showSelectedState:(id)sender {
    [self removeStylesForButton:self.button];
    self.button.selected = YES;
}
- (IBAction)showHighlightedState:(id)sender {
    [self removeStylesForButton:self.button];
    self.button.highlighted = YES;
}
- (IBAction)showDisabledState:(id)sender {
    [self removeStylesForButton:self.button];
    self.button.enabled = NO;
}
- (IBAction)showGray:(id)sender {
    self.button.color = J1ButtonColorGray;
}
- (IBAction)showRed:(id)sender {
    self.button.color = J1ButtonColorRed;
}
- (IBAction)showBlue:(id)sender {
    self.button.color = J1ButtonColorBlue;
}
- (IBAction)showGreen:(id)sender {
    self.button.color = J1ButtonColorGreen;
}
- (IBAction)showGrayOnBlack:(id)sender {
    self.button.color = J1ButtonColorGrayOnBlack;
}

- (void) removeStylesForButton:(UIButton*)b
{
    b.selected = NO;
    b.highlighted = NO;
    b.enabled = YES;
}
- (IBAction)toggleSize:(id)sender {
    self.button.size = self.sizeToggler.isOn ? J1ButtonSizeNormal : J1ButtonSizeSmall;
}
- (IBAction)changeScale:(id)sender {
    self.button.frame = CGRectMake(
        self.defaultFrame.origin.x,
        self.defaultFrame.origin.y,
        self.defaultFrame.size.width * self.scaleTest.value,
        self.defaultFrame.size.height * self.scaleTest.value
    );
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changeBackgroundColor:(id)sender {
    UISegmentedControl *c = sender;
    if(c.selectedSegmentIndex == 0) {
        self.view.backgroundColor = [UIColor colorWithWhite:.93 alpha:1];
    } else if (c.selectedSegmentIndex ==1) {
        self.view.backgroundColor = [UIColor blackColor];
    } else if (c.selectedSegmentIndex == 2) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
}


- (void)viewDidUnload {
 
    [self setGrayOnBlack:nil];
    [self setGrayOnBlack:nil];
    [super viewDidUnload];
}
@end
