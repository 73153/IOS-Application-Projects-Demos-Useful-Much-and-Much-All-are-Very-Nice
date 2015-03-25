//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "AppController.h"
#import "AppDelegate.h"
#import "LoadingView.h"
#import "LoginView.h"
#import "SigninView.h"
#import "SignupView.h"
#import "MapView.h"
#import "InfoView.h"
#import "TutorialView.h"
#import "NotificationsView.h"
#import "ProfileView.h"
#import "KippyProfileAdd.h"
#import "KippyProfileView.h"
#import "MenuView.h"
#import "KippyList.h"
#import "TapUtils.h"

@implementation AppController

-(void)loadUi {
  firstTime = YES;
  loadingView = nil;
  if([self app].appCode != nil && [self app].appVerificationCode != nil && [self app].userId != nil) {
    state = AppStateMap;
    [self loadData];
    [self loadUserData];
  } else {
    state = AppStateLogin;
  }
  loginView = [[LoginView alloc] init];
  [self.view addSubview:loginView];
  signinView = [[SigninView alloc] initWithTitle:@"SIGN IN"];
  [self.view addSubview:signinView];
  signupView = [[SignupView alloc] initWithTitle:@"SIGN UP"];
  [self.view addSubview:signupView];
  infoView = [[InfoView alloc] initWithTitle:@"INFO"];
  [self.view addSubview:infoView];
  tutorialView = [[TutorialView alloc] initWithTitle:@"TUTORIAL"];
  [self.view addSubview:tutorialView];
  profileView = [[ProfileView alloc] initWithTitle:@"PROFILE"];
  [self.view addSubview:profileView];
  kippyProfileView = [[KippyProfileView alloc] initWithTitle:@"EDIT KIPPY"];
  [self.view addSubview:kippyProfileView];
  kippyProfileAdd = [[KippyProfileAdd alloc] initWithTitle:@"ADD KIPPY"];
  [self.view addSubview:kippyProfileAdd];
  notificationsView = [[NotificationsView alloc] initWithTitle:@"NOTIFICATIONS"];
  [self.view addSubview:notificationsView];
  mapView = nil;
  menuView = [[MenuView alloc] init];
  [self.view addSubview:menuView];
  menuView.alpha = 0;
  menuOpened = NO;
  listView = [[KippyList alloc] init];
  [self.view addSubview:listView];
  listOpened = NO;

  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goBack) name:@"Back" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showSignin) name:@"Signin" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showSignup) name:@"Signup" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMap:) name:@"Map" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showInfo) name:@"Info" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showTutorial) name:@"Tutorial" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNotifications) name:@"Notifications" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showProfile) name:@"Profile" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKippyProfile) name:@"KippyProfile" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKippyAdd) name:@"KippyAdd" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"Load" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toggleSettings) name:@"ToggleSettings" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toggleKippyList) name:@"ToggleKippyList" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectKippy:) name:@"SelectKippy" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadUserData) name:@"UserDataExpired" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showSignin) name:@"Signout" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showSignup) name:@"FBUserDataDictInfo" object:nil];
  for(UIView* view in [self.view subviews]) {
    if(![view isKindOfClass:[MenuView class]] && ![view isKindOfClass:[KippyList class]]) {
      view.alpha = 0;
      view.frame = CGRectZero;
    }
  }
}

//
//- (BOOL)prefersStatusBarHidden {
//  return NO;
//}

-(void)loadData {
  if(loadingView != nil) {
    [loadingView removeFromSuperview];
  }
  loadingView = [[LoadingView alloc] init];
  loadingView.alpha = 0;
  [self.view addSubview:loadingView];
  [self needsSetupUi];
  state = AppStateLoading;
  [self setupUiAnimated];
}

-(void)loadUserData {
  [[self app] downloadResource:[NSString stringWithFormat:@"%@kippymap_getUserData.php?app_code=%@&app_verification_code=%@", SERVER_URL, [self app].appCode, [self app].appVerificationCode] sender:self];
}

-(void)downloadResourceSuccess:(ASIHTTPRequest*)request {
  NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[request responseData] options: NSJSONReadingMutableContainers error: nil];
  [self app].userData = dictionary;
  [[NSNotificationCenter defaultCenter] postNotificationName:@"UserDataChanged" object:nil];
}

-(void)downloadResourceFailed:(ASIHTTPRequest*)request {
}

-(void)toggleSettings {
  menuOpened = !menuOpened;
  [self setupUiAnimated];
}

-(void)toggleKippyList {
  listOpened = !listOpened;
  [self setupUiAnimated];
}

-(void)goBack {
  if(listOpened) {
    if(state != AppStateKippyAdd) {
      [self toggleKippyList];
      return;
    } else {
      listOpened = NO;
    }
  }
  if(state == AppStateSignin || state == AppStateSignup) {
    state = AppStateLogin;
  }
  if(state == AppStateInfo || state == AppStateNotifications || state == AppStateTutorial || state == AppStateProfile || state == AppStateKippyProfile || state == AppStateKippyAdd) {
    state = AppStateMap;
  }
  [self setupUiAnimated];
}

-(void)showSignin {
  [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"appCode"];
  [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"appVerificationCode"];
  [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userId"];
  [[NSUserDefaults standardUserDefaults] synchronize];
  menuOpened = NO;
  state = AppStateSignin;
  [self setupUiAnimated];
}

-(void)showSignup {
  if(state == AppStateLogin) {
    state = AppStateSignup;
    [self setupUiAnimated];
  }
}

-(void)showInfo {
  state = AppStateInfo;
  menuOpened = NO;
  [infoView setup];
  [self setupUiAnimated];
}

-(void)showTutorial {
  state = AppStateTutorial;
  menuOpened = NO;
  [tutorialView setup];
  [self setupUiAnimated];
}

-(void)showNotifications {
  state = AppStateNotifications;
  menuOpened = NO;
  [self setupUiAnimated];
}

-(void)showProfile {
  state = AppStateProfile;
  menuOpened = NO;
  [profileView setup];
  [self setupUiAnimated];
}

-(void)showKippyProfile {
  state = AppStateKippyProfile;
  [kippyProfileView setup:[self app].selectedKippy];
  menuOpened = NO;
  [self setupUiAnimated];
}

-(void)showMap:(NSNotification*)notification {
  if(state != AppStateMap) {
    if(mapView != nil) {
      [mapView removeFromSuperview];
    }
    NSArray* kippyList = [notification.object objectForKey:@"data"];
    if(![[notification.object objectForKey:@"data"] isKindOfClass:[NSNull class]]) {
      int lastKippy = [[[NSUserDefaults standardUserDefaults] objectForKey:@"lastKippy"] intValue];
      if(lastKippy >= [kippyList count]) {
        lastKippy = 0;
      }
      [notificationsView setup:([kippyList count] > 0)?[kippyList objectAtIndex:lastKippy]:nil];
      mapView = [[MapView alloc] initWithKippy:([kippyList count] > 0)?[kippyList objectAtIndex:lastKippy]:nil];
    } else {
      mapView = [[MapView alloc] initWithKippy:nil];
    }
    [self.view addSubview:mapView];
    mapView.alpha = 0;
    [self.view bringSubviewToFront:menuView];
    [self needsSetupUi];
    state = AppStateMap;
    [self setupUiAnimated];
  }
}

-(void)selectKippy:(NSNotification*)notification {
  listOpened = NO;
  CGRect frame = CGRectZero;
  if(mapView != nil) {
    frame = mapView.frame;
    [mapView removeFromSuperview];
  }

  [notificationsView setup:notification.object];

  mapView = [[MapView alloc] initWithKippy:notification.object];
  mapView.frame = frame;
  [self.view addSubview:mapView];
  mapView.alpha = 0;
  [self.view bringSubviewToFront:menuView];
  state = AppStateMap;
  [self setupUiAnimated];
}

-(void)showKippyAdd {
  listOpened = NO;
  [kippyProfileAdd setup:nil];
  state = AppStateKippyAdd;
  [self setupUiAnimated];
}

-(void)setupUiAnimated {
  [super setupUiAnimated];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"Standby" object:nil];
}

-(void)setupUi:(CGSize)size {
  loginView.alpha = (state == AppStateLogin);
  signinView.alpha = (state == AppStateSignin);
  signupView.alpha = (state == AppStateSignup);
  infoView.alpha = (state == AppStateInfo);
  tutorialView.alpha = (state == AppStateTutorial);
  notificationsView.alpha = (state == AppStateNotifications);
  profileView.alpha = (state == AppStateProfile);
  kippyProfileAdd.alpha = (state == AppStateKippyAdd);
  kippyProfileView.alpha = (state == AppStateKippyProfile);
  if(loadingView != nil) {
    loadingView.alpha = (state == AppStateLoading);
  }
  if(mapView != nil) {
    mapView.alpha = (state == AppStateMap);
  }
  int x = 0;
  if(menuOpened) {
    x = 320-44;
    menuView.frame = CGRectMake(0,[self y0],320-44,size.height-[self y0]);
  } else {
    menuView.frame = CGRectMake(-(320-44),[self y0],320-44,size.height-[self y0]);
  }
  if(listOpened) {
    x = -size.width;
    listView.frame = CGRectMake(0,[self y0],size.width,size.height-[self y0]);
  } else {
    listView.frame = CGRectMake(size.width,[self y0],size.width,size.height-[self y0]);
  }
  menuView.alpha = 1;
  for(UIView* view in [self.view subviews]) {
    if(![view isKindOfClass:[MenuView class]] && ![view isKindOfClass:[KippyList class]]) {
      view.frame = CGRectMake(0,[self y0],size.width,size.height-[self y0]);
      view.bounds = CGRectMake(0,0,size.width,size.height-[self y0]);
      if(firstTime) {
        firstTime = NO;
      } else {
        view.center = CGPointMake(x+((YES)?size.width/2:size.width+size.width/2),(size.height+[self y0])/2);
      }
    }
  }
}

-(void)idle {
  if(loginView != nil) {
    [loginView idle];
  }
  if(mapView != nil) {
    [mapView idle];
  }
  if(loadingView != nil) {
    [loadingView idle];
  }
}

- (BOOL)prefersStatusBarHidden {
  return NO;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
  return UIStatusBarStyleLightContent;
}

@end
