//  EKNotifView.m
//
//  Created by Ethan Kramer on 1/3/13.
//  Copyright (c) 2013 Ethan Kramer. All rights reserved.

#import "EKNotifView.h"
#import "MBCategory.h"

@implementation EKNotifView

-(id)initWithNotifViewType:(EKNotifViewType)notifViewType notifPosition:(EKNotifViewPosition)notifViewPosition notifTextStyle:(EKNotifViewTextStyle)notifTextStyle andParentView:(UIView *)containingView{
 
    self = [super init];
    
    
    if (self) {
        
        self.textStyle = notifTextStyle;
        
        if (self.textStyle == EKNotifViewTextStyleTitle) {
            
            self.view = [[[NSBundle mainBundle] loadNibNamed:@"EKNotifView-titleOnly" owner:self options:nil] lastObject];
            
            self.titleLabel = ((UILabel *)[self.view viewWithTag:101]);
            self.activityIndicator = ((UIActivityIndicatorView *)[self.view viewWithTag:201]);
            self.imageView = ((UIImageView *)[self.view viewWithTag:301]);
            self.infoLabel = ((UILabel *)[self.view viewWithTag:401]);
            
        }else if(self.textStyle == EKNotifViewTextStyleSubtitle){
            
            self.view = [[[NSBundle mainBundle] loadNibNamed:@"EKNotifView-subtitle" owner:self options:nil] lastObject];
            
            self.titleLabel = ((UILabel *)[self.view viewWithTag:101]);
            self.activityIndicator = ((UIActivityIndicatorView *)[self.view viewWithTag:201]);
            self.imageView = ((UIImageView *)[self.view viewWithTag:301]);
            self.descLabel = ((UILabel *)[self.view viewWithTag:401]);
            self.infoTitleLabel = ((UILabel *)[self.view viewWithTag:501]);
            self.infoDescLabel = ((UILabel *)[self.view viewWithTag:601]);
        }
        
        self.parentView = containingView;
        self.notifHeight = 50.0f;
        self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.viewPosition = notifViewPosition;
        
        if (self.viewPosition == EKNotifViewPositionTop) {
            self.view.frame = CGRectMake(0,(0-self.notifHeight), self.parentView.bounds.size.width, self.notifHeight);
        }else if(self.viewPosition == EKNotifViewPositionBottom){
            self.view.frame = CGRectMake(0, (self.parentView.bounds.size.height + 1), self.parentView.bounds.size.width, self.notifHeight);
            
        }
        
        self.viewType = notifViewType;
        self.isShown = NO;
        self.secondsToDisplay = 2.0f;
        self.animationDuration = 0.25f;
        
        self.loadingBackgroundColor = [UIColor blackColor];
        self.infoBackgroundColor = self.loadingBackgroundColor;
        self.successBackgroundColor = [UIColor colorWithHexString:@"#62A300"];
        self.failureBackgroundColor = [UIColor colorWithHexString:@"#f22222"];
        
        if (notifViewType == EKNotifViewTypeFailure || notifViewType == EKNotifViewTypeSuccess || notifViewType == EKNotifViewTypeInfo) {
            
            self.allowsTapToDismiss = YES;
            self.allowsAutomaticDismissal = YES;
            
            self.activityIndicator.hidden = YES;
            self.imageView.hidden = NO;
            self.titleLabel.hidden = NO;
            self.infoLabel.hidden = YES;
            self.descLabel.hidden = NO;
            self.infoTitleLabel.hidden = YES;
            self.infoDescLabel.hidden = YES;
            
            if (notifViewType == EKNotifViewTypeSuccess) {
                self.view.backgroundColor = self.successBackgroundColor;
                self.imageView.image = [UIImage imageNamed:@"check"];
            }else if(notifViewType == EKNotifViewTypeFailure){
                self.view.backgroundColor = self.failureBackgroundColor;
                self.imageView.image = [UIImage imageNamed:@"ex"];
            }else if(notifViewType == EKNotifViewTypeLoading){
                self.view.backgroundColor = self.loadingBackgroundColor;
            }else if(notifViewType == EKNotifViewTypeInfo){
                self.view.backgroundColor = self.infoBackgroundColor;
                
                self.infoLabel.hidden = NO;
                self.titleLabel.hidden = YES;
                self.imageView.hidden = YES;
                self.infoDescLabel.hidden = NO;
                self.infoTitleLabel.hidden = NO;
                self.descLabel.hidden = YES;
                
            }
            
            UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
            
            self.view.gestureRecognizers = @[tapRec];
            
        }else if(notifViewType == EKNotifViewTypeLoading){
            
            self.activityIndicator.hidden = NO;
            self.imageView.hidden = YES;
            self.titleLabel.hidden = NO;
            self.infoLabel.hidden = YES;
            self.descLabel.hidden = NO;
            self.infoTitleLabel.hidden = YES;
            self.infoDescLabel.hidden = YES;
            
            self.allowsTapToDismiss = NO;
            self.allowsAutomaticDismissal = NO;
            self.loadingBackgroundColor = [UIColor blackColor];
            self.view.backgroundColor = self.loadingBackgroundColor;
            
            self.view.gestureRecognizers = nil;
        }
        
        self.isTransitioning = NO;
        
        if(self.allowsTapToDismiss){
            UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
            
            self.view.gestureRecognizers = @[tapRec];
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupView) name:EKNotifViewAutoResizeNotification object:nil];
        
        
    }
    
    return self;
}

-(void)show{
    
    
    if (!self.isShown && !self.isTransitioning) {
        [self.parentView addSubview:self.view];
        
        [UIView animateWithDuration:self.animationDuration
                         animations:^ {
                             
                             self.isTransitioning = YES;
                             self.isShown = YES;
                             self.view.gestureRecognizers = nil;
                             
                             if (self.viewPosition == EKNotifViewPositionTop) {
                                 self.view.frame = CGRectMake(0, 0, self.parentView.bounds.size.width, self.notifHeight);
                             }else if(self.viewPosition == EKNotifViewPositionBottom){
                                 self.view.frame = CGRectMake(0, (self.parentView.bounds.size.height - self.notifHeight),self.parentView.bounds.size.width,self.notifHeight);
                                 
                             }
                             
                         }
                         completion:^(BOOL finished) {
                             
                             self.isShown = YES;
                             self.isTransitioning = NO;
                             
                             if(self.allowsTapToDismiss){
                                 UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
                                 
                                 self.view.gestureRecognizers = @[tapRec];
                             }
                             
                             
                             if (self.viewType == EKNotifViewTypeLoading) {
                                 [self.activityIndicator startAnimating];
                             }
                             
                             if (self.allowsAutomaticDismissal) {
                                 
                                 [self performSelector:@selector(hide) withObject:nil afterDelay:self.secondsToDisplay];
                             }
                             
                         }
         ];

    }
    
    
}

-(void)hide{
    if(!self.isTransitioning && self.isShown){
    
        self.isTransitioning = YES;
        self.view.gestureRecognizers = nil;
        
        // delay selector execution
        
        [UIView animateWithDuration:self.animationDuration
                         animations:^ {
                             
                             self.isShown = YES;
                             self.isTransitioning = YES;
                             
                             if (self.viewPosition == EKNotifViewPositionTop) {
                                 self.view.frame = CGRectMake(0,(0-self.notifHeight), self.parentView.bounds.size.width, self.view.frame.size.height);
                             }else if(self.viewPosition == EKNotifViewPositionBottom){
                                 self.view.frame = CGRectMake(0, (self.parentView.bounds.size.height + 1), self.parentView.bounds.size.width, self.notifHeight);
                                 
                             }
                             
                             
                             
                         }completion:^(BOOL finished) {
                             
                             self.isShown = NO;
                             self.isTransitioning = NO;
                             
                             if (self.allowsTapToDismiss) {
                                 UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
                                 
                                 self.view.gestureRecognizers = @[tapRec];
                             }
                             
                         }
         ];

    
    }
}

-(void)setupView{
    
    if (self.viewPosition == EKNotifViewPositionTop) {
        self.view.frame = CGRectMake(0,(0-self.notifHeight), self.parentView.bounds.size.width, self.notifHeight);
    }else if(self.viewPosition == EKNotifViewPositionBottom){
        self.view.frame = CGRectMake(0, (self.parentView.bounds.size.height + 1), self.parentView.bounds.size.width, self.notifHeight);
        
    }
    
}

-(void)changeBackgroundColorToColor:(UIColor *)color forViewType:(EKNotifViewType)noteViewType{
    
    if (noteViewType == EKNotifViewTypeFailure) {
        self.failureBackgroundColor = color;
        self.view.backgroundColor = self.failureBackgroundColor;
    }else if(noteViewType == EKNotifViewTypeInfo){
        self.infoBackgroundColor = color;
        self.view.backgroundColor = self.infoBackgroundColor;
    }else if(noteViewType == EKNotifViewTypeLoading){
        self.loadingBackgroundColor = color;
        self.view.backgroundColor = self.loadingBackgroundColor;
    }else if(noteViewType == EKNotifViewTypeSuccess){
        self.successBackgroundColor = color;
        self.view.backgroundColor = self.successBackgroundColor;
    }
    
}

-(void)changeTitleOfLabel:(EKNotifViewLabelType)notifLabelType to:(NSString *)noteTitle{
    
    if (notifLabelType == EKNotifViewLabelTypeAll) {
        
        self.titleLabel.text = noteTitle;
        self.infoLabel.text = noteTitle;
        self.descLabel.text = noteTitle;
        self.infoTitleLabel.text = noteTitle;
        self.infoDescLabel.text = noteTitle;
    }else if(notifLabelType == EKNotifViewLabelTypeTitle){
        
        self.titleLabel.text = noteTitle;
        self.infoLabel.text = noteTitle;
        self.infoTitleLabel.text = noteTitle;
    }else if(notifLabelType == EKNotifViewLabelTypeSubtitle){
    
        self.descLabel.text = noteTitle;
        self.infoDescLabel.text = noteTitle;
        
    }
    
}

-(void)changeFontOfLabel:(EKNotifViewLabelType)notifLabelType to:(UIFont *)daFont{

    if (notifLabelType == EKNotifViewLabelTypeAll) {
        
        self.titleLabel.font = daFont;
        self.infoLabel.font = daFont;
        self.descLabel.font = daFont;
        self.infoTitleLabel.font = daFont;
        self.infoDescLabel.font = daFont;
    }else if(notifLabelType == EKNotifViewLabelTypeTitle){
        
        self.titleLabel.font = daFont;
        self.infoLabel.font = daFont;
        self.infoTitleLabel.font = daFont;
    }else if(notifLabelType == EKNotifViewLabelTypeSubtitle){
        
        self.descLabel.font = daFont;
        self.infoDescLabel.font = daFont;
        
    }
    
}

@end
