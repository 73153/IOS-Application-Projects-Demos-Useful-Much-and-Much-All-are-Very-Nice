//
//  JHViewController.m
//  JHActivityButtonExample
//
//  Created by justin howlett on 2013-05-31.
//  Copyright (c) 2013 JustinHowlett. All rights reserved.
//

#import "JHViewController.h"
#import "JHActivityButton.h"

@interface JHViewController (){
    UIScrollView *_masterScrollView;
}

@end

@implementation JHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _masterScrollView = [[UIScrollView alloc]init];
    [self.view addSubview:_masterScrollView];
    
    CGFloat yLoc = 100;
    
    [[JHActivityButton appearance]setAnimationTime:0.5];
    
    for (int i=0; i<11; i++){
        
        JHActivityButton* activityButton = [[JHActivityButton alloc]initFrame:CGRectMake(100, yLoc, 100, 50) style:i];
        [activityButton setBackgroundColor:[UIColor purpleColor] forState:UIControlStateNormal];
        [activityButton setBackgroundColor:[UIColor orangeColor] forState:UIControlStateSelected];
        
        [activityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [activityButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [activityButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
                
        /** the bounds of the title label is always limited to the bounds of the original button size before expansion */
        [activityButton setTitle:@"WWDC" forState:UIControlStateNormal];
        [activityButton setTitle:@"2013" forState:UIControlStateSelected];
        
        [activityButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:22]];
        
        [activityButton.indicator setColor:[UIColor blackColor]];

        [_masterScrollView addSubview:activityButton];
        
        yLoc += 120;
    }
    
     _masterScrollView.backgroundColor = [UIColor whiteColor];
    [_masterScrollView setContentSize:CGSizeMake(self.view.bounds.size.width, yLoc)];

}

-(void)fauxbutton:(UIButton*)sender{
    [sender setSelected:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [_masterScrollView setFrame:self.view.bounds];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
