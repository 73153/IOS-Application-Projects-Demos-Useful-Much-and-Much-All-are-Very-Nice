//
// UIScrollView+BalloonPullToRefresh.h
// Balloon Pull Demo
//
//  Created by Dmitry Klimkin on 5/5/13.
//  Copyright (c) 2013 Dmitry Klimkin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    BalloonPullToRefreshStateStopped = 0,
    BalloonPullToRefreshStateTriggered,
    BalloonPullToRefreshStateLoading
} BalloonPullToRefreshState;

typedef enum {
    BalloonPullToRefreshWaitAnimationSpin = 0,
    BalloonPullToRefreshWaitAnimationFade
} BalloonPullToRefreshWaitAnimation;

@class BalloonPullToRefreshView;

@interface UIScrollView (BalloonPullToRefresh)

- (void)addPullToRefreshWithActionHandler:(void (^)(void))actionHandler;
- (void)triggerPullToRefresh;

@property (nonatomic, strong, readonly) BalloonPullToRefreshView *pullToRefreshController;
@property (nonatomic, assign) BOOL showsPullToRefresh;

@end

@interface BalloonPullToRefreshView : UIImageView {    
    BOOL isRefreshing;
    NSTimer *animationTimer;
    float lastOffset;
    int animationStep;
}

@property (nonatomic, readonly) BalloonPullToRefreshState currentState;
@property (nonatomic, assign) BalloonPullToRefreshWaitAnimation waitingAnimation;
@property (nonatomic) int particlesCount;

- (void)startAnimating;
- (void)didFinishRefresh;

@end