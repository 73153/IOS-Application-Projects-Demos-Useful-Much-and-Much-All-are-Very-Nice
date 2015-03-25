//
//  FriendsViewController.m
//  Holaout
//
//  Created by Amit Parmar on 06/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "FriendsViewController.h"
#import "ChatViewController.h"
#import "PhotoViewController.h"
#import "VideoViewController.h"
#import "DrawingViewController.h"
#import "FriendsViewCell.h"
#import "DetailFriendsViewController.h"
#import "DataManager.h"

@implementation FriendsViewController
@synthesize tblView;
@synthesize friendsOnHolaout;
@synthesize checkInsData;

- (void)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)leftSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
        [self setupMenuBarButtonItems];
    }];
}

- (void)rightSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleRightSideMenuCompletion:^{
        [self setupMenuBarButtonItems];
    }];
}

- (UIBarButtonItem *)leftMenuBarButtonItem {
    return [[UIBarButtonItem alloc]
            initWithImage:[UIImage imageNamed:@"menu-icon.png"] style:UIBarButtonItemStyleBordered
            target:self
            action:@selector(leftSideMenuButtonPressed:)];
}

- (UIBarButtonItem *)backBarButtonItem {
    return [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back-arrow"]
                                            style:UIBarButtonItemStyleBordered
                                           target:self
                                           action:@selector(backButtonPressed:)];
}

- (void)setupMenuBarButtonItems {
    if(self.menuContainerViewController.menuState == MFSideMenuStateClosed &&
       ![[self.navigationController.viewControllers objectAtIndex:0] isEqual:self]) {
        self.navigationItem.leftBarButtonItem = [self backBarButtonItem];
    } else {
        self.navigationItem.leftBarButtonItem = [self leftMenuBarButtonItem];
    }
}

- (UIBarButtonItem *)rightMenuBarButtonItem {
    return [[UIBarButtonItem alloc]
            initWithImage:[UIImage imageNamed:@"menu-icon.png"] style:UIBarButtonItemStyleBordered
            target:self
            action:@selector(rightSideMenuButtonPressed:)];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setupMenuBarButtonItems];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismiss) name:@"BACKTOINDEXNOTE" object:nil];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
}

-(void)returnContactArray:(NSArray *)dataArray{
    NSLog(@"%@",dataArray);
    NSMutableArray *holaoutArray  = [[NSMutableArray alloc] init];
    
    for(int i=0;i<[dataArray count];i++){
        
        if([[[dataArray objectAtIndex:i] objectForKey:kISBlocked] intValue] != 1){
            if([[[dataArray objectAtIndex:i] objectForKey:kContactIsHolaout] intValue] == 1){
                [holaoutArray addObject:[dataArray objectAtIndex:i]];
            }
        }
        
    }
    friendsOnHolaout = holaoutArray;
    [self.tblView reloadData];
    [self getCheckIns];
    
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [DataManager sharedDataManager].contactDelegate = self;
    [QBCustomObjects objectsWithClassName:KCustomClassName delegate:self];
    NSDictionary *dictionary = [[NSUserDefaults standardUserDefaults] objectForKey:kStoredData];
    NSString *userId = [dictionary objectForKey:kUserId];
    [[DataManager sharedDataManager] getHolaoutContactsData:userId];
    [QBChat instance].delegate = [AppDelegate appdelegate];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnPhotoClicked:(id)sender{
    PhotoViewController *photoViewController;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        photoViewController = [[PhotoViewController alloc] initWithNibName:@"PhotoViewController_iPhone" bundle:nil];
    }
    else{
         photoViewController = [[PhotoViewController alloc] initWithNibName:@"PhotoViewController_iPad" bundle:nil];
    }
    [self presentViewController:photoViewController animated:YES completion:nil];
}
- (IBAction)btnVideoClicked:(id)sender{
    VideoViewController *videoViewController;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        videoViewController = [[VideoViewController alloc] initWithNibName:@"VideoViewController_iPhone" bundle:nil];
    }
    else{
        videoViewController = [[VideoViewController alloc] initWithNibName:@"VideoViewController_iPad" bundle:nil];
    }
    [self presentViewController:videoViewController animated:YES completion:nil];
}
- (IBAction)btnDrawingClicked:(id)sender{
    DrawingViewController *drawingViewController;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        drawingViewController = [[DrawingViewController alloc] initWithNibName:@"DrawingViewController_iPhone" bundle:nil];
    }
    else{
        drawingViewController = [[DrawingViewController alloc] initWithNibName:@"DrawingViewController_iPad" bundle:nil];
    }
    [self presentViewController:drawingViewController animated:YES completion:nil];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [friendsOnHolaout count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FriendsViewCell *cell =(FriendsViewCell*) [tableView dequeueReusableCellWithIdentifier:@"Identifier"];
    if (cell == nil){
        NSArray *topLevelObjects;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
           topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"FriendsViewCell" owner:self options:nil];
        }
        else{
            topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"FriendsViewCell_iPad" owner:self options:nil];
        }
        for (id currentObject in topLevelObjects){
            if ([currentObject isKindOfClass:[UITableViewCell class]]){
                cell =  (FriendsViewCell *) currentObject;
                break;
            }
        }
    }
    cell.lblname.text = [[friendsOnHolaout objectAtIndex:indexPath.row] objectForKey:kContactName];
    if([checkInsData count] > indexPath.row){
        QBLGeoData *geodata = [checkInsData objectAtIndex:indexPath.row];
        cell.txtViewLocation.text = geodata.status;
    }
    cell.imgView.image = [UIImage imageWithContentsOfFile:[[friendsOnHolaout objectAtIndex:indexPath.row] objectForKey:kContactImage]];
    cell.imgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.imgView.layer.borderWidth = 3.0;
    cell.imgView.layer.cornerRadius = 25.0;
    cell.imgView.layer.masksToBounds = YES;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailFriendsViewController *detailFriendsView;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        detailFriendsView = [[DetailFriendsViewController alloc] initWithNibName:@"DetailFriendsViewController_iPhone" bundle:nil];
    }
    else{
        detailFriendsView = [[DetailFriendsViewController alloc] initWithNibName:@"DetailFriendsViewController_iPad" bundle:nil];
    }
    
    detailFriendsView.selectedFriend = [friendsOnHolaout objectAtIndex:indexPath.row];
    [self presentViewController:detailFriendsView animated:YES completion:nil];
}

- (void) getCheckIns{
    QBLGeoDataGetRequest *getRequest = [QBLGeoDataGetRequest request];
    getRequest.status = YES;
    getRequest.lastOnly = YES;
    [QBLocation geoDataWithRequest:getRequest delegate:self];
}

- (void) completeGeodataArray{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for(int i=0;i<[friendsOnHolaout count];i++){
        NSDictionary *dataDictionary = [friendsOnHolaout objectAtIndex:i];
        int userId = [[dataDictionary objectForKey:kContactHolaoutId] intValue];
        for(int j=0;j<[checkInsData count];j++){
            QBLGeoData *geoData = [checkInsData objectAtIndex:j];
            if(geoData.userID == userId)
                [tempArray addObject:geoData];
        }
    }
    checkInsData = tempArray;
    [self.tblView reloadData];
}
- (void)completedWithResult:(Result *)result{
    if(result.success && [result isKindOfClass:QBLGeoDataPagedResult.class]){
        QBLGeoDataPagedResult *checkinsResult = (QBLGeoDataPagedResult *)result;
        NSLog(@"Checkins: %@", checkinsResult.geodata);
        checkInsData = checkinsResult.geodata;
        [self completeGeodataArray];
    }
    else{
        NSLog(@"errors=%@",result.errors);
    }
}
@end
