//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "TapController.h"

typedef NS_ENUM(NSInteger, AppState) {
  AppStateLoading,
  AppStateLogin,
  AppStateSignin,
  AppStateSignup,
  AppStateMap,
  AppStateInfo,
  AppStateTutorial,
  AppStateProfile,
  AppStateKippyProfile,
  AppStateKippyAdd,
  AppStateNotifications
};

@class MenuView;
@class KippyList;

@class LoadingView;
@class LoginView;
@class SigninView;
@class SignupView;
@class MapView;
@class InfoView;
@class TutorialView;
@class ProfileView;
@class KippyProfileAdd;
@class KippyProfileView;
@class NotificationsView;

@interface AppController : TapController {
  MenuView* menuView;
  KippyList* listView;

  LoadingView* loadingView;
  LoginView* loginView;
  SigninView* signinView;
  SignupView* signupView;
  MapView* mapView;
  InfoView* infoView;
  TutorialView* tutorialView;
  ProfileView* profileView;
  KippyProfileAdd* kippyProfileAdd;
  KippyProfileView* kippyProfileView;
  NotificationsView* notificationsView;

  AppState state;

  BOOL menuOpened;
  BOOL listOpened;

  BOOL firstTime;
}

@end
