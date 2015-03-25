//
//  GraphViewController.m
//  Dialysis_New
//
//  Created by Amit Parmar on 27/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "GraphViewController.h"
#import "DataManager.h"
#import "AppConstant.h"

@implementation GraphViewController

@synthesize isFromPush;
@synthesize btnBack;
@synthesize timeSegment;
@synthesize graphSegment;
@synthesize dataArray;
@synthesize finalGraphArray;
@synthesize scrollView;
@synthesize nonDialysisGraphSegment;
@synthesize alert1Dictionary;
@synthesize alert2Dictionary;
@synthesize lineChart;
@synthesize array1;
@synthesize array2;
@synthesize array3;
@synthesize array4;
@synthesize webView;

@synthesize arrayGFR;
@synthesize arrayYValues;
@synthesize arrayDates;
@synthesize isGFRGraph;
@synthesize isBPGraph;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.image = [UIImage imageNamed:@"tabGraph.png"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"tabGraphSelected.png"];
    }
    return self;
}

- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer {
    // Zoom out slightly, capping at the minimum zoom scale specified by the scroll view
    CGFloat newZoomScale = self.scrollView.zoomScale / 1.5f;
    newZoomScale = MAX(newZoomScale, self.scrollView.minimumZoomScale);
    [self.scrollView setZoomScale:newZoomScale animated:YES];
}

- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer {
    // 1
    CGPoint pointInView = [recognizer locationInView:lineChart];
    
    // 2
    CGFloat newZoomScale = self.scrollView.zoomScale * 1.5f;
    newZoomScale = MIN(newZoomScale, self.scrollView.maximumZoomScale);
    
    // 3
    CGSize scrollViewSize = self.scrollView.bounds.size;
    
    CGFloat w = scrollViewSize.width / newZoomScale;
    CGFloat h = scrollViewSize.height / newZoomScale;
    CGFloat x = pointInView.x - (w / 2.0f);
    CGFloat y = pointInView.y - (h / 2.0f);
    
    CGRect rectToZoomTo = CGRectMake(x, y, w, h);
    
    // 4
    [self.scrollView zoomToRect:rectToZoomTo animated:YES];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.scrollView.delegate = self;
    
    UITapGestureRecognizer *twoFingerTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTwoFingerTapped:)];
    twoFingerTapRecognizer.numberOfTapsRequired = 1;
    twoFingerTapRecognizer.numberOfTouchesRequired = 2;
    [self.scrollView addGestureRecognizer:twoFingerTapRecognizer];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *) returnArrayOfProperDates:(NSArray *)array SelectedDate:(NSDate *)date{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for(int i=0;i<[array count];i++){
        NSDictionary *dataDictionary = [array objectAtIndex:i];
        NSDate *storedDate = [dataDictionary objectForKey:kDate];
        if([storedDate compare:date] == NSOrderedDescending){
            [tempArray addObject:dataDictionary];
        }
    }
    return tempArray;
}

- (NSDictionary*)createColorDict:(NSString *)name
{
    NSDictionary *colorDict = [[NSDictionary alloc] initWithObjectsAndKeys:[UIColor whiteColor],name,nil];
    return colorDict;
}

- (NSDictionary*)createColorDictForBloodPressure
{
    NSDictionary *colorDict = [[NSDictionary alloc] initWithObjectsAndKeys:[UIColor whiteColor],@"Systolic",[UIColor redColor],@"Diastolic",nil];
    return colorDict;
}

- (NSDictionary*)createColorDictForGFR
{
    NSDictionary *colorDict = [[NSDictionary alloc] initWithObjectsAndKeys:[UIColor whiteColor],@"GFR",[UIColor redColor],@"Trends",[UIColor redColor],@"10",[UIColor orangeColor],@"25",nil];
    return colorDict;
}

- (NSString *) getDateStringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    return [dateFormatter stringFromDate:date];
}

- (NSMutableArray*)createBloodPressureChart:(NSArray *)records{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSString *string = @"";
    for (int i=0; i<[records count]; i++) {
        NSDictionary *dict = [records objectAtIndex:i];
        WSChartObject *lfcObj = [[WSChartObject alloc] init];
        lfcObj.name = @"Systolic";
        NSDate *date = [[dict allKeys] objectAtIndex:0];
        NSString *currentDate = [self getDateStringFromDate:date];
        if([string isEqualToString:@""]){
            string = currentDate;
        }
        else if([string isEqualToString:currentDate]){
            string = @"";
        }
        else{
            string = currentDate;
        }
        
        lfcObj.xValue = string;
        lfcObj.yValue = [[dict objectForKey:date] objectForKey:kSystolic];
        
        WSChartObject *chObj = [[WSChartObject alloc] init];
        chObj.name = @"Diastolic";
        chObj.xValue = string;
        chObj.yValue = [[dict objectForKey:date] objectForKey:kdiastolic];
        
        NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:lfcObj,@"Systolic",chObj,@"Diastolic",
                              nil];
        [arr addObject:data];
    }
    return arr;
}

- (NSMutableArray*)createGFRChart:(NSArray *)records{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i=0; i<[records count]; i++) {
        NSDictionary *dict = [records objectAtIndex:i];
        WSChartObject *lfcObj = [[WSChartObject alloc] init];
        lfcObj.name = @"GFR";
        NSDate *date = [[dict allKeys] objectAtIndex:0];
        lfcObj.xValue = [self getDateStringFromDate:date];
        lfcObj.yValue = [[dict objectForKey:date] objectForKey:kGFR];
        
        WSChartObject *chObj = [[WSChartObject alloc] init];
        chObj.name = @"Trends";
        chObj.xValue = [self getDateStringFromDate:date];
        chObj.yValue = [[dict objectForKey:date] objectForKey:@"y"];
        NSLog(@"Graph Y Value=%@",[[dict objectForKey:date] objectForKey:@"y"]);
        
        WSChartObject *chObj1 = [[WSChartObject alloc] init];
        //chObj1.name = @"10";
        chObj1.xValue = [NSString stringWithFormat:@"%d",i];
        chObj1.yValue = @"10";
        
        WSChartObject *chObj2 = [[WSChartObject alloc] init];
        //chObj2.name = @"25";
        chObj2.xValue = [NSString stringWithFormat:@"%d",i];
        chObj2.yValue = @"25";
    
        NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:lfcObj,@"GFR",chObj,@"Trends",chObj1,@"10",chObj2,@"25",nil];
        [arr addObject:data];
    }
    return arr;
}


- (NSMutableArray*)createDemoDatas:(NSArray *)records :(NSString *)name
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i=0; i<[records count]; i++) {
        NSDictionary *dict = [records objectAtIndex:i];
        WSChartObject *lfcObj = [[WSChartObject alloc] init];
        lfcObj.name = name;
        NSDate *date = [[dict allKeys] objectAtIndex:0];
        lfcObj.xValue = [self getDateStringFromDate:date];
        lfcObj.yValue = [[dict allValues] objectAtIndex:0];
        NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:lfcObj,name,
                             nil];
        [arr addObject:data];
    }
    return arr;
}

- (void) drawGFRGraphAndDisplay:(NSArray *)records WithName:(NSString *)name{
    if([records count] == 0)
        return;
    if(lineChart){
        [lineChart removeFromSuperview];
        lineChart = nil;
    }
    int width = 0;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        if([records count]*200 > 320)
            width = [records count]*200;
        else
            width = 320;
        
        lineChart = [[WSLineChartView alloc] initWithFrame:CGRectMake(0, 10,width,400)];
        lineChart.rowWidth = 150;
        [scrollView setContentSize:CGSizeMake([records count]*200,500)];
    }
    else{
        if([records count]*300 > 768)
            width = [records count]*300;
        else
            width = 768;
        
        lineChart = [[WSLineChartView alloc] initWithFrame:CGRectMake(0, 10,width,834)];
        lineChart.rowWidth = 300;
        [scrollView setContentSize:CGSizeMake([records count]*300,834)];
    }
    NSMutableArray *arr;
    NSDictionary *colorDict;
    arr = [self createGFRChart:records];
    colorDict = [self createColorDictForGFR];
    
    lineChart.xAxisName = @"Date Status";
    lineChart.title = name;
    lineChart.showZeroValueOnYAxis = YES;
    [lineChart drawChart:arr withColor:colorDict];
    lineChart.backgroundColor = [UIColor blackColor];
   
    [scrollView addSubview:lineChart];
}



- (void) drawGraphAndDisplay:(NSArray *)records WithName:(NSString *)name{
    if([records count] == 0)
        return;
    if(lineChart){
        [lineChart removeFromSuperview];
        lineChart = nil;
    }
    int width = 0;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        if([records count]*200 > 320)
            width = [records count]*200;
        else
            width = 320;
        
       lineChart = [[WSLineChartView alloc] initWithFrame:CGRectMake(0, 10,width,400)];
        lineChart.rowWidth = 150;
        [scrollView setContentSize:CGSizeMake([records count]*200,500)];
    }
    else{
        if([records count]*300 > 768)
            width = [records count]*300;
        else
            width = 768;
        
        lineChart = [[WSLineChartView alloc] initWithFrame:CGRectMake(0, 10,width,834)];
        lineChart.rowWidth = 300;
        [scrollView setContentSize:CGSizeMake([records count]*300,834)];
    }
    NSMutableArray *arr;
    NSDictionary *colorDict;
    if([name isEqualToString:@"Blood Pressure"]){
       arr = [self createBloodPressureChart:records];
       colorDict = [self createColorDictForBloodPressure];
    }
    else{
       arr = [self createDemoDatas:records :name];
        colorDict = [self createColorDict :name];
    }
    
    lineChart.xAxisName = @"Date Status";
    lineChart.title = name;
    lineChart.showZeroValueOnYAxis = YES;
    [lineChart drawChart:arr withColor:colorDict];
    lineChart.backgroundColor = [UIColor blackColor];
    [scrollView addSubview:lineChart];
}

- (void) createGFRdata:(NSArray *)array{
    if([array count] == 0){
        [webView setHidden:YES];
        return;
    }
    NSMutableArray  *arrayDate = [[NSMutableArray alloc] init];
    NSMutableArray *arrayGfr = [[NSMutableArray alloc] init];
    NSMutableArray *arrayYValue = [[NSMutableArray alloc] init];
    for(int i=0;i<[array count];i++){
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[[array objectAtIndex:i] objectForKey:@"date"]];
        NSInteger day = [components day];
        NSInteger month = [components month];
        NSInteger year = [components year];
        
        NSString *dateString = [NSString stringWithFormat:@"Date.UTC(%d,%d,%d)",year,month-1,day];
        [arrayDate addObject:dateString];
        if([[[array objectAtIndex:i] objectForKey:kGFR] intValue] != 0)
            [arrayGfr addObject:[[array objectAtIndex:i] objectForKey:kGFR]];
            
        [arrayYValue addObject:[[array objectAtIndex:i] objectForKey:@"y"]];
    }
    arrayDates = arrayDate;
    arrayGFR = arrayGfr;
    if([array count] < 2){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"No trendline" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
         arrayYValues = arrayYValue;
    }
}

    //Date.UTC(2014,  11, 1);
- (void) createBloodPressuredata:(NSArray *)array{
    if([array count] == 0){
        [webView setHidden:YES];
        return;
    }
    NSMutableArray  *arrayDate = [[NSMutableArray alloc] init];
    NSMutableArray *arraySystolic = [[NSMutableArray alloc] init];
    NSMutableArray *arrayDiastolic = [[NSMutableArray alloc] init];
    NSMutableArray *arrayDay = [[NSMutableArray alloc] init];
    for(int i=0;i<[array count];i++){
      NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[[array objectAtIndex:i] objectForKey:@"date"]];
      NSInteger day = [components day];
      NSInteger month = [components month];
      NSInteger year = [components year];
        
      NSString *dateString = [NSString stringWithFormat:@"Date.UTC(%d,%d,%d)",year,month-1,day];
      [arrayDate addObject:dateString];
      [arraySystolic addObject:[[array objectAtIndex:i] objectForKey:@"systolic"]];
      [arrayDiastolic addObject:[[array objectAtIndex:i] objectForKey:@"diastolic"]];
    }
    array1 = arrayDate;
    array2 = arraySystolic;
    array3 = arrayDate;
    array4 = arrayDiastolic;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    if(isGFRGraph){
        if([arrayDates count] == 0 || [arrayGFR count] == 0){
            [webView setHidden:YES];
            return;
        }
        NSString *finalString = [NSString stringWithFormat:@"getParameters([%@],[%@],[%@])",[arrayDates componentsJoinedByString:@","],[arrayGFR componentsJoinedByString:@","],[arrayYValues componentsJoinedByString:@","]];
        [webView stringByEvaluatingJavaScriptFromString:finalString];
        
            UIView *alert1 = [[UIView alloc] initWithFrame:CGRectMake(10,95,150,60)];
            [alert1 setTag:10001];
            [alert1 setBackgroundColor:[UIColor clearColor]];
            
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 60)];
            [imgView setImage:[UIImage imageNamed:@"alertBackground.png"]];
            [alert1 addSubview:imgView];
        
        if(alert1Dictionary){
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10,0,130,35)];
            [label setBackgroundColor:[UIColor clearColor]];
            [label setText:@"Start Dialysis treatment"];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setTextColor:[UIColor whiteColor]];
            [label setNumberOfLines:2];
            [label setFont:[UIFont boldSystemFontOfSize:13]];
            [alert1 addSubview:label];
            
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0,30,150,25)];
            [label1 setBackgroundColor:[UIColor clearColor]];
            [label1 setText:[NSString stringWithFormat:@"%@",[self getDateStringFromDate:[alert1Dictionary objectForKey:kDate]]]];
            [label1 setTextAlignment:NSTextAlignmentCenter];
            [label1 setTextColor:[UIColor whiteColor]];
            [label1 setFont:[UIFont boldSystemFontOfSize:13]];
            [alert1 addSubview:label1];
        }
        else{
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10,0,130,35)];
            [label setBackgroundColor:[UIColor clearColor]];
            [label setText:@"Start Dialysis treatment"];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setTextColor:[UIColor whiteColor]];
            [label setNumberOfLines:2];
            [label setFont:[UIFont boldSystemFontOfSize:13]];
            [alert1 addSubview:label];
            
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0,30,150,25)];
            [label1 setBackgroundColor:[UIColor clearColor]];
            [label1 setText:@"No Alerts"];
            [label1 setTextAlignment:NSTextAlignmentCenter];
            [label1 setTextColor:[UIColor whiteColor]];
            [label1 setFont:[UIFont boldSystemFontOfSize:13]];
            [alert1 addSubview:label1];
        }
        [self.view addSubview:alert1];
        
        
        UIView *alert2 = [[UIView alloc] initWithFrame:CGRectMake(170,95,150,60)];
        [alert2 setTag:10002];
        [alert2 setBackgroundColor:[UIColor clearColor]];
            
        UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 60)];
        [imgView1 setImage:[UIImage imageNamed:@"alart-bg-orange.png"]];
        [alert2 addSubview:imgView1];
        
        if(alert2Dictionary){
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,150,35)];
            [label setBackgroundColor:[UIColor clearColor]];
            [label setText:@"Needs AV Access Placement"];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setTextColor:[UIColor whiteColor]];
            [label setNumberOfLines:2];
            [label setFont:[UIFont boldSystemFontOfSize:13]];
            [alert2 addSubview:label];
            
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0,30,150,25)];
            [label1 setBackgroundColor:[UIColor clearColor]];
            [label1 setText:[NSString stringWithFormat:@"%@",[self getDateStringFromDate:[alert2Dictionary objectForKey:kDate]]]];
            [label1 setTextAlignment:NSTextAlignmentCenter];
            [label1 setTextColor:[UIColor whiteColor]];
            [label1 setFont:[UIFont boldSystemFontOfSize:13]];
            [alert2 addSubview:label1];
        }
        else{
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,150,35)];
            [label setBackgroundColor:[UIColor clearColor]];
            [label setText:@"Needs AV Access Placement"];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setTextColor:[UIColor whiteColor]];
            [label setNumberOfLines:2];
            [label setFont:[UIFont boldSystemFontOfSize:13]];
            [alert2 addSubview:label];
            
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0,30,150,25)];
            [label1 setBackgroundColor:[UIColor clearColor]];
            [label1 setText:@"No Alerts"];
            [label1 setTextAlignment:NSTextAlignmentCenter];
            [label1 setTextColor:[UIColor whiteColor]];
            [label1 setFont:[UIFont boldSystemFontOfSize:13]];
            [alert2 addSubview:label1];
        }
        [self.view addSubview:alert2];
    }
    else{
        if([array1 count] == 0 || [array2 count] == 0 || [array3 count] == 0 || [array4 count] == 0){
            [webView setHidden:YES];
            return;
        }
        NSString *finalString = [NSString stringWithFormat:@"getParameters([%@],[%@],[%@])",[array1 componentsJoinedByString:@","],[array2 componentsJoinedByString:@","],[array4 componentsJoinedByString:@","]];
        [webView stringByEvaluatingJavaScriptFromString:finalString];
    }
    
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIView *view1 = [self.view viewWithTag:10001];
    UIView *view2 = [self.view viewWithTag:10002];
    if(view1){
        [view1 removeFromSuperview];
    }
    if(view2){
        [view2 removeFromSuperview];
    }
    
    [graphSegment setSelectedSegmentIndex:1];
    [nonDialysisGraphSegment setSelectedSegmentIndex:0];
    [timeSegment setHidden:NO];
    if([[NSUserDefaults standardUserDefaults] boolForKey:kIsDialysis]){
        [graphSegment setHidden:NO];
        [nonDialysisGraphSegment setHidden:YES];
        dataArray = [[DataManager sharedDataManager] getDialysisReading];
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            if([UIScreen mainScreen].bounds.size.height == 568){
                [webView setFrame:CGRectMake(0,118, webView.frame.size.width,399)];
            }
            else{
                [webView setFrame:CGRectMake(0,118, webView.frame.size.width,310)];
            }
        }
        else{
           [webView setFrame:CGRectMake(0,118, webView.frame.size.width,856)];
        }
    }
    else{
        [graphSegment setHidden:YES];
        [nonDialysisGraphSegment setHidden:NO];
        dataArray = [[DataManager sharedDataManager] getBloodPressureData];
        
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            if([UIScreen mainScreen].bounds.size.height == 568){
              [webView setFrame:CGRectMake(0,118, webView.frame.size.width,399)];
            }
            else{
                [webView setFrame:CGRectMake(0,118, webView.frame.size.width,310)];
            }
        }
        else{
            [webView setFrame:CGRectMake(0,118, webView.frame.size.width,856)];
        }
    }
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:kDate
                                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
    dataArray = [dataArray sortedArrayUsingDescriptors:sortDescriptors];
    if([dataArray count] > 0){
        isBPGraph = YES;
        isGFRGraph = NO;
        [self createBloodPressuredata:dataArray];
        [webView setHidden:NO];
        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"graph" ofType:@"htm"]];
        [webView loadRequest:[NSURLRequest requestWithURL:url]];
    }
    else{
       [webView setHidden:YES];
    }
    if(isFromPush){
        [self.btnBack setHidden:NO];
    }
    else{
        [self.btnBack setHidden:YES];
    }
    alert1Dictionary = nil;
    alert2Dictionary = nil;
}
- (IBAction)timeSegmentValueChanged:(id)sender{
    if([[NSUserDefaults standardUserDefaults] boolForKey:kIsDialysis]){
         dataArray = [[DataManager sharedDataManager] getDialysisReading];
    }
    else{
        dataArray = [[DataManager sharedDataManager] getBloodPressureData];
    }
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:kDate
                                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
    dataArray = [dataArray sortedArrayUsingDescriptors:sortDescriptors];
    for(int i=0;i<[[scrollView subviews] count];i++){
        UIView *subview = [scrollView.subviews objectAtIndex:i];
        [subview removeFromSuperview];
    }
    if(timeSegment.selectedSegmentIndex == 0){
//        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
//        for(int i=0;i<[dataArray count];i++){
//            NSDictionary *dataDictionary = [dataArray objectAtIndex:i];
//            NSDictionary *secondDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[dataDictionary objectForKey:kSystolic],kSystolic,[dataDictionary objectForKey:kdiastolic],kdiastolic, nil];
//            NSDictionary *dictionary = [NSDictionary dictionaryWithObject:secondDictionary forKey:[dataDictionary objectForKey:kDate]];
//            [tempArray addObject:dictionary];
//        }
        //[self drawGraphAndDisplay:tempArray WithName:@"Blood Pressure"];
        if([dataArray count] > 0){
            [self createBloodPressuredata:dataArray];
            [webView setHidden:NO];
            NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"graph" ofType:@"htm"]];
            [webView loadRequest:[NSURLRequest requestWithURL:url]];
        }
        else{
            [webView setHidden:YES];
        }
    }
    else if(timeSegment.selectedSegmentIndex == 1){
        NSDate *date  = [[NSDate date] dateByAddingTimeInterval:-(7*24*60*60)];
        dataArray = [self returnArrayOfProperDates:dataArray SelectedDate:date];
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for(int i=0;i<[dataArray count];i++){
            NSDictionary *dataDictionary = [dataArray objectAtIndex:i];
            NSDictionary *secondDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[dataDictionary objectForKey:kSystolic],kSystolic,[dataDictionary objectForKey:kdiastolic],kdiastolic, nil];
            NSDictionary *dictionary = [NSDictionary dictionaryWithObject:secondDictionary forKey:[dataDictionary objectForKey:kDate]];
            [tempArray addObject:dictionary];
        }
         //[self drawGraphAndDisplay:tempArray WithName:@"Blood Pressure"];
        if([dataArray count] > 0){
            [self createBloodPressuredata:dataArray];
            [webView setHidden:NO];
            NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"graph" ofType:@"htm"]];
            [webView loadRequest:[NSURLRequest requestWithURL:url]];
        }
        else{
            [webView setHidden:YES];
        }
    }
    else if(timeSegment.selectedSegmentIndex == 2){
        NSDate *date  = [[NSDate date] dateByAddingTimeInterval:-(3*30*24*60*60)];
        dataArray = [self returnArrayOfProperDates:dataArray SelectedDate:date];
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for(int i=0;i<[dataArray count];i++){
            NSDictionary *dataDictionary = [dataArray objectAtIndex:i];
            NSDictionary *secondDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[dataDictionary objectForKey:kSystolic],kSystolic,[dataDictionary objectForKey:kdiastolic],kdiastolic, nil];
            NSDictionary *dictionary = [NSDictionary dictionaryWithObject:secondDictionary forKey:[dataDictionary objectForKey:kDate]];
            [tempArray addObject:dictionary];
        }
         //[self drawGraphAndDisplay:tempArray WithName:@"Blood Pressure"];
        if([dataArray count] > 0){
            [self createBloodPressuredata:dataArray];
            [webView setHidden:NO];
            NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"graph" ofType:@"htm"]];
            [webView loadRequest:[NSURLRequest requestWithURL:url]];
        }
        else{
            [webView setHidden:YES];
        }
    }
    else if(timeSegment.selectedSegmentIndex == 3){
        NSDate *date  = [[NSDate date] dateByAddingTimeInterval:-(6*30*24*60*60)];
        dataArray = [self returnArrayOfProperDates:dataArray SelectedDate:date];
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for(int i=0;i<[dataArray count];i++){
            NSDictionary *dataDictionary = [dataArray objectAtIndex:i];
            NSDictionary *secondDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[dataDictionary objectForKey:kSystolic],kSystolic,[dataDictionary objectForKey:kdiastolic],kdiastolic, nil];
            NSDictionary *dictionary = [NSDictionary dictionaryWithObject:secondDictionary forKey:[dataDictionary objectForKey:kDate]];
            [tempArray addObject:dictionary];
        }
         //[self drawGraphAndDisplay:tempArray WithName:@"Blood Pressure"];
        if([dataArray count] > 0){
            [self createBloodPressuredata:dataArray];
            [webView setHidden:NO];
            NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"graph" ofType:@"htm"]];
            [webView loadRequest:[NSURLRequest requestWithURL:url]];
        }
        else{
            [webView setHidden:YES];
        }
    }
    else if(timeSegment.selectedSegmentIndex == 4){
        NSDate *date  = [[NSDate date] dateByAddingTimeInterval:-(1*365*24*60*60)];
        dataArray = [self returnArrayOfProperDates:dataArray SelectedDate:date];
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for(int i=0;i<[dataArray count];i++){
            NSDictionary *dataDictionary = [dataArray objectAtIndex:i];
            NSDictionary *secondDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[dataDictionary objectForKey:kSystolic],kSystolic,[dataDictionary objectForKey:kdiastolic],kdiastolic, nil];
            NSDictionary *dictionary = [NSDictionary dictionaryWithObject:secondDictionary forKey:[dataDictionary objectForKey:kDate]];
            [tempArray addObject:dictionary];
        }
         //[self drawGraphAndDisplay:tempArray WithName:@"Blood Pressure"];
        if([dataArray count] > 0){
            [self createBloodPressuredata:dataArray];
            [webView setHidden:NO];
            NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"graph" ofType:@"htm"]];
            [webView loadRequest:[NSURLRequest requestWithURL:url]];
        }
        else{
            [webView setHidden:YES];
        }
    }
    
}
- (IBAction)graphSegmentValueChanged:(id)sender{
    [timeSegment setHidden:YES];
    if([[NSUserDefaults standardUserDefaults] boolForKey:kIsDialysis]){
       dataArray = [[DataManager sharedDataManager] getDialysisReading];
    }
    else{
       dataArray = [[DataManager sharedDataManager] getBloodPressureData];
    }
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:kDate
                                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
    dataArray = [dataArray sortedArrayUsingDescriptors:sortDescriptors];
    
    if(graphSegment.selectedSegmentIndex == 0){
        for(int i=0;i<[[scrollView subviews] count];i++){
            UIView *subview = [scrollView.subviews objectAtIndex:i];
            [subview removeFromSuperview];
        }
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
           [scrollView setContentSize:CGSizeMake(320,399)];
        }
        else{
            [scrollView setContentSize:CGSizeMake(768,856)];
        }
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for(int i=0;i<[dataArray count];i++){
            NSDictionary *dataDictionary = [dataArray objectAtIndex:i];
            NSDictionary *dictionary = [NSDictionary dictionaryWithObject:[dataDictionary objectForKey:kKTV] forKey:[dataDictionary objectForKey:kDate]];
            [tempArray addObject:dictionary];
        }
        [webView setHidden:YES];
        [self drawGraphAndDisplay:tempArray WithName:@"K+/V"];
    }
    else if(graphSegment.selectedSegmentIndex == 1){
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            if([UIScreen mainScreen].bounds.size.height == 568){
                [webView setFrame:CGRectMake(0,118, webView.frame.size.width,399)];
            }
            else{
                [webView setFrame:CGRectMake(0,118, webView.frame.size.width,310)];
            }
        }
        else{
            [webView setFrame:CGRectMake(0,118, webView.frame.size.width,856)];
        }
        [scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            [scrollView setContentSize:CGSizeMake(320,399)];
        }
        else{
            [scrollView setContentSize:CGSizeMake(768,856)];
        }
        [timeSegment setHidden:NO];
        [timeSegment setSelectedSegmentIndex:0];
        if(timeSegment.selectedSegmentIndex == 0){
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            for(int i=0;i<[dataArray count];i++){
                NSDictionary *dataDictionary = [dataArray objectAtIndex:i];
                NSDictionary *secondDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[dataDictionary objectForKey:kSystolic],kSystolic,[dataDictionary objectForKey:kdiastolic],kdiastolic, nil];
                NSDictionary *dictionary = [NSDictionary dictionaryWithObject:secondDictionary forKey:[dataDictionary objectForKey:kDate]];
                [tempArray addObject:dictionary];
            }
            // [self drawGraphAndDisplay:tempArray WithName:@"Blood Pressure"];
            if([dataArray count] > 0){
                [self createBloodPressuredata:dataArray];
                [webView setHidden:NO];
                NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"graph" ofType:@"htm"]];
                [webView loadRequest:[NSURLRequest requestWithURL:url]];
            }
            else{
                [webView setHidden:YES];
            }
        }
        else if(timeSegment.selectedSegmentIndex == 1){
            NSDate *date  = [[NSDate date] dateByAddingTimeInterval:-(7*24*60*60)];
            dataArray = [self returnArrayOfProperDates:dataArray SelectedDate:date];
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            for(int i=0;i<[dataArray count];i++){
                NSDictionary *dataDictionary = [dataArray objectAtIndex:i];
                NSDictionary *secondDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[dataDictionary objectForKey:kSystolic],kSystolic,[dataDictionary objectForKey:kdiastolic],kdiastolic, nil];
                NSDictionary *dictionary = [NSDictionary dictionaryWithObject:secondDictionary forKey:[dataDictionary objectForKey:kDate]];
                [tempArray addObject:dictionary];
            }
             //[self drawGraphAndDisplay:tempArray WithName:@"Blood Pressure"];
            if([dataArray count] > 0){
                [self createBloodPressuredata:dataArray];
                [webView setHidden:NO];
                NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"graph" ofType:@"htm"]];
                [webView loadRequest:[NSURLRequest requestWithURL:url]];
            }
            else{
                [webView setHidden:YES];
            }
        }
        else if(timeSegment.selectedSegmentIndex == 2){
            NSDate *date  = [[NSDate date] dateByAddingTimeInterval:-(3*30*24*60*60)];
            dataArray = [self returnArrayOfProperDates:dataArray SelectedDate:date];
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            for(int i=0;i<[dataArray count];i++){
                NSDictionary *dataDictionary = [dataArray objectAtIndex:i];
                NSDictionary *secondDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[dataDictionary objectForKey:kSystolic],kSystolic,[dataDictionary objectForKey:kdiastolic],kdiastolic, nil];
                NSDictionary *dictionary = [NSDictionary dictionaryWithObject:secondDictionary forKey:[dataDictionary objectForKey:kDate]];
                [tempArray addObject:dictionary];
            }
             //[self drawGraphAndDisplay:tempArray WithName:@"Blood Pressure"];
            if([dataArray count] > 0){
                [self createBloodPressuredata:dataArray];
                [webView setHidden:NO];
                NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"graph" ofType:@"htm"]];
                [webView loadRequest:[NSURLRequest requestWithURL:url]];
            }
            else{
                [webView setHidden:YES];
            }
        }
        else if(timeSegment.selectedSegmentIndex == 3){
            NSDate *date  = [[NSDate date] dateByAddingTimeInterval:-(6*30*24*60*60)];
            dataArray = [self returnArrayOfProperDates:dataArray SelectedDate:date];
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            for(int i=0;i<[dataArray count];i++){
                NSDictionary *dataDictionary = [dataArray objectAtIndex:i];
                NSDictionary *secondDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[dataDictionary objectForKey:kSystolic],kSystolic,[dataDictionary objectForKey:kdiastolic],kdiastolic, nil];
                NSDictionary *dictionary = [NSDictionary dictionaryWithObject:secondDictionary forKey:[dataDictionary objectForKey:kDate]];
                [tempArray addObject:dictionary];
            }
             //[self drawGraphAndDisplay:tempArray WithName:@"Blood Pressure"];
            if([dataArray count] > 0){
                [self createBloodPressuredata:dataArray];
                [webView setHidden:NO];
                NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"graph" ofType:@"htm"]];
                [webView loadRequest:[NSURLRequest requestWithURL:url]];
            }
            else{
                [webView setHidden:YES];
            }
        }
        else if(timeSegment.selectedSegmentIndex == 4){
            NSDate *date  = [[NSDate date] dateByAddingTimeInterval:-(1*365*24*60*60)];
            dataArray = [self returnArrayOfProperDates:dataArray SelectedDate:date];
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            for(int i=0;i<[dataArray count];i++){
                NSDictionary *dataDictionary = [dataArray objectAtIndex:i];
                NSDictionary *secondDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[dataDictionary objectForKey:kSystolic],kSystolic,[dataDictionary objectForKey:kdiastolic],kdiastolic, nil];
                NSDictionary *dictionary = [NSDictionary dictionaryWithObject:secondDictionary forKey:[dataDictionary objectForKey:kDate]];
                [tempArray addObject:dictionary];
            }
             //[self drawGraphAndDisplay:tempArray WithName:@"Blood Pressure"];
            if([dataArray count] > 0){
                [self createBloodPressuredata:dataArray];
                [webView setHidden:NO];
                NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"graph" ofType:@"htm"]];
                [webView loadRequest:[NSURLRequest requestWithURL:url]];
            }
            else{
                [webView setHidden:YES];
            }
        }
    }
    else if(graphSegment.selectedSegmentIndex == 2){
        for(int i=0;i<[[scrollView subviews] count];i++){
            UIView *subview = [scrollView.subviews objectAtIndex:i];
            [subview removeFromSuperview];
        }
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            [scrollView setContentSize:CGSizeMake(320,399)];
        }
        else{
            [scrollView setContentSize:CGSizeMake(768,856)];
        }
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for(int i=0;i<[dataArray count];i++){
            NSDictionary *dataDictionary = [dataArray objectAtIndex:i];
            NSDictionary *dictionary = [NSDictionary dictionaryWithObject:[dataDictionary objectForKey:kBF] forKey:[dataDictionary objectForKey:kDate]];
            [tempArray addObject:dictionary];
        }
        [webView setHidden:YES];
         [self drawGraphAndDisplay:tempArray WithName:@"BF"];
    }
    else if(graphSegment.selectedSegmentIndex == 3){
        for(int i=0;i<[[scrollView subviews] count];i++){
            UIView *subview = [scrollView.subviews objectAtIndex:i];
            [subview removeFromSuperview];
        }
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            [scrollView setContentSize:CGSizeMake(320,399)];
        }
        else{
            [scrollView setContentSize:CGSizeMake(768,856)];
        }
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for(int i=0;i<[dataArray count];i++){
            NSDictionary *dataDictionary = [dataArray objectAtIndex:i];
            NSDictionary *dictionary = [NSDictionary dictionaryWithObject:[dataDictionary objectForKey:kVP] forKey:[dataDictionary objectForKey:kDate]];
            [tempArray addObject:dictionary];
        }
        [webView setHidden:YES];
         [self drawGraphAndDisplay:tempArray WithName:@"VP"];
    }
    
    CGRect scrollViewFrame = self.scrollView.frame;
    CGFloat scaleWidth = scrollViewFrame.size.width / self.scrollView.contentSize.width;
    CGFloat scaleHeight = scrollViewFrame.size.height / self.scrollView.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    self.scrollView.minimumZoomScale = minScale;
    
    // 5
    self.scrollView.maximumZoomScale = 1.0f;
    
}
- (int) returnsDaysBetweenDate:(NSDate *)date1 AndDate:(NSDate *)date2{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit
                                                        fromDate:date1
                                                          toDate:date2
                                                         options:0];
    return components.day;
}
- (NSArray *) calculateDays:(NSArray *)array{
    if([array count] == 0)
        return nil;
    NSDate *firstDate = [[array objectAtIndex:0] objectForKey:kDate];
    NSMutableArray *finalArray = [[NSMutableArray alloc] init];
    for(int i=0;i<[array count];i++){
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary:[array objectAtIndex:i]];
        NSDate *date = [dictionary objectForKey:kDate];
        int day = [self returnsDaysBetweenDate:firstDate AndDate:date];
        if(day == 0 && i == 0)
            day = 1;
        else
            day = day + 1;
        [dictionary setObject:[NSString stringWithFormat:@"%d",day] forKey:@"day"];
        [finalArray addObject:dictionary];
    }
    return finalArray;
}

- (NSArray *)returnCalculations:(NSArray *)array{
    float a = 0;
    float b = 0;
    int b1 = 0;
    float b2 = 0;
    int c = 0;
    for(int i=0;i<[array count];i++){
        NSDictionary *dict = [array objectAtIndex:i];
        a = a + ([[dict objectForKey:@"day"] intValue] * [[dict objectForKey:kGFR] floatValue]);
        b1 = b1 + [[dict objectForKey:@"day"] intValue];
        b2 = b2 + [[dict objectForKey:kGFR] floatValue];
        c = c  + ([[dict objectForKey:@"day"] intValue] * [[dict objectForKey:@"day"] intValue]);
    }
    c = c * [array count];
    a = a  * [array count];
    b = b1 * b2;
    float d = (b1*b1);
    float e = b2;
    float m = (a-b);
    if((c-d) > 0)
        m = m /(c-d);
    float f = m * b1;
    float z = (e-f)/[array count];
    NSMutableArray *finalArray = [[NSMutableArray alloc] init];
    for(int i=0;i<[array count];i++){
        NSDictionary *dict = [array objectAtIndex:i];
        int days = [[dict objectForKey:@"day"] intValue];
        int y = m*days+z;
        NSDictionary *tempDict = [NSDictionary dictionaryWithObjectsAndKeys:[dict objectForKey:kGFR],kGFR,[NSNumber numberWithInt:y],@"y",[dict objectForKey:kDate],kDate, nil];
        [finalArray addObject:tempDict];
    }
    NSDictionary *dict = [array objectAtIndex:0];
    int x2 = round((10-z)/m);
    if(m < 0){
        NSDictionary *tempDict = [NSDictionary dictionaryWithObjectsAndKeys:@"0",kGFR,[NSNumber numberWithInt:10],@"y",[[dict objectForKey:kDate] dateByAddingTimeInterval:x2*24*60*60],kDate, nil];
        alert1Dictionary = tempDict;
        [finalArray addObject:tempDict];
    }
    
    int x3 = round((25-z)/m);
    if(m < 0){
        NSDictionary *tempDict1 = [NSDictionary dictionaryWithObjectsAndKeys:@"0",kGFR,[NSNumber numberWithInt:25],@"y",[[dict objectForKey:kDate] dateByAddingTimeInterval:x3*24*60*60],kDate, nil];
        alert2Dictionary = tempDict1;
        [finalArray addObject:tempDict1];
    }
   
    
    NSArray *darray = [NSArray arrayWithArray:finalArray];
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"y"
                                                                 ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
    NSArray *newArray = [darray sortedArrayUsingDescriptors:sortDescriptors];
    
    NSLog(@"%f",m);
    NSLog(@"newArray=%@",newArray);
    return newArray;
}
- (IBAction)nonDialysisGraphSegmentValueChanged:(id)sender{
    [timeSegment setHidden:YES];
    if([[NSUserDefaults standardUserDefaults] boolForKey:kIsDialysis]){
        dataArray = [[DataManager sharedDataManager] getDialysisReading];
    }
    else{
        dataArray = [[DataManager sharedDataManager] getBloodPressureData];
    }
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:kDate
                                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
    dataArray = [dataArray sortedArrayUsingDescriptors:sortDescriptors];
    if(nonDialysisGraphSegment.selectedSegmentIndex == 0){
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            if([UIScreen mainScreen].bounds.size.height == 568){
                [webView setFrame:CGRectMake(0,118, webView.frame.size.width,399)];
            }
            else{
                [webView setFrame:CGRectMake(0,118, webView.frame.size.width,310)];
            }
        }
        else{
            [webView setFrame:CGRectMake(0,118, webView.frame.size.width,856)];
        }
        UIView *view1 = [self.view viewWithTag:10001];
        UIView *view2 = [self.view viewWithTag:10002];
        if(view1){
            [view1 removeFromSuperview];
        }
        if(view2){
            [view2 removeFromSuperview];
        }
        isGFRGraph = false;
        isBPGraph = true;
        for(int i=0;i<[[scrollView subviews] count];i++){
            UIView *subview = [scrollView.subviews objectAtIndex:i];
            [subview removeFromSuperview];
        }
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            [scrollView setContentSize:CGSizeMake(320,399)];
        }
        else{
            [scrollView setContentSize:CGSizeMake(768,856)];
        }
        [timeSegment setHidden:NO];
        [timeSegment setSelectedSegmentIndex:0];
        if(timeSegment.selectedSegmentIndex == 0){
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            for(int i=0;i<[dataArray count];i++){
                NSDictionary *dataDictionary = [dataArray objectAtIndex:i];
                NSDictionary *secondDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[dataDictionary objectForKey:kSystolic],kSystolic,[dataDictionary objectForKey:kdiastolic],kdiastolic, nil];
                NSDictionary *dictionary = [NSDictionary dictionaryWithObject:secondDictionary forKey:[dataDictionary objectForKey:kDate]];
                [tempArray addObject:dictionary];
            }
            //[self drawGraphAndDisplay:tempArray WithName:@"Blood Pressure"];
            if([dataArray count] > 0){
                [self createBloodPressuredata:dataArray];
                [webView setHidden:NO];
                NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"graph" ofType:@"htm"]];
                [webView loadRequest:[NSURLRequest requestWithURL:url]];
            }
            else{
                [webView setHidden:YES];
            }
        }
        else if(timeSegment.selectedSegmentIndex == 1){
            NSDate *date  = [[NSDate date] dateByAddingTimeInterval:-(7*24*60*60)];
            dataArray = [self returnArrayOfProperDates:dataArray SelectedDate:date];
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            for(int i=0;i<[dataArray count];i++){
                NSDictionary *dataDictionary = [dataArray objectAtIndex:i];
                NSDictionary *secondDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[dataDictionary objectForKey:kSystolic],kSystolic,[dataDictionary objectForKey:kdiastolic],kdiastolic, nil];
                NSDictionary *dictionary = [NSDictionary dictionaryWithObject:secondDictionary forKey:[dataDictionary objectForKey:kDate]];
                [tempArray addObject:dictionary];
            }
            //[self drawGraphAndDisplay:tempArray WithName:@"Blood Pressure"];
            if([dataArray count] > 0){
                [self createBloodPressuredata:dataArray];
                [webView setHidden:NO];
                NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"graph" ofType:@"htm"]];
                [webView loadRequest:[NSURLRequest requestWithURL:url]];
            }
            else{
                [webView setHidden:YES];
            }
        }
        else if(timeSegment.selectedSegmentIndex == 2){
            NSDate *date  = [[NSDate date] dateByAddingTimeInterval:-(3*30*24*60*60)];
            dataArray = [self returnArrayOfProperDates:dataArray SelectedDate:date];
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            for(int i=0;i<[dataArray count];i++){
                NSDictionary *dataDictionary = [dataArray objectAtIndex:i];
                NSDictionary *secondDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[dataDictionary objectForKey:kSystolic],kSystolic,[dataDictionary objectForKey:kdiastolic],kdiastolic, nil];
                NSDictionary *dictionary = [NSDictionary dictionaryWithObject:secondDictionary forKey:[dataDictionary objectForKey:kDate]];
                [tempArray addObject:dictionary];
            }
            //[self drawGraphAndDisplay:tempArray WithName:@"Blood Pressure"];
            if([dataArray count] > 0){
                [self createBloodPressuredata:dataArray];
                [webView setHidden:NO];
                NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"graph" ofType:@"htm"]];
                [webView loadRequest:[NSURLRequest requestWithURL:url]];
            }
        }
        else if(timeSegment.selectedSegmentIndex == 3){
            NSDate *date  = [[NSDate date] dateByAddingTimeInterval:-(6*30*24*60*60)];
            dataArray = [self returnArrayOfProperDates:dataArray SelectedDate:date];
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            for(int i=0;i<[dataArray count];i++){
                NSDictionary *dataDictionary = [dataArray objectAtIndex:i];
                NSDictionary *secondDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[dataDictionary objectForKey:kSystolic],kSystolic,[dataDictionary objectForKey:kdiastolic],kdiastolic, nil];
                NSDictionary *dictionary = [NSDictionary dictionaryWithObject:secondDictionary forKey:[dataDictionary objectForKey:kDate]];
                [tempArray addObject:dictionary];
            }
            //[self drawGraphAndDisplay:tempArray WithName:@"Blood Pressure"];
            if([dataArray count] > 0){
                [self createBloodPressuredata:dataArray];
                [webView setHidden:NO];
                NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"graph" ofType:@"htm"]];
                [webView loadRequest:[NSURLRequest requestWithURL:url]];
            }
            else{
                [webView setHidden:YES];
            }
        }
        else if(timeSegment.selectedSegmentIndex == 4){
            NSDate *date  = [[NSDate date] dateByAddingTimeInterval:-(1*365*24*60*60)];
            dataArray = [self returnArrayOfProperDates:dataArray SelectedDate:date];
//            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
//            for(int i=0;i<[dataArray count];i++){
//                NSDictionary *dataDictionary = [dataArray objectAtIndex:i];
//                NSDictionary *secondDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[dataDictionary objectForKey:kSystolic],kSystolic,[dataDictionary objectForKey:kdiastolic],kdiastolic, nil];
//                NSDictionary *dictionary = [NSDictionary dictionaryWithObject:secondDictionary forKey:[dataDictionary objectForKey:kDate]];
//                [tempArray addObject:dictionary];
//            }
            //[self drawGraphAndDisplay:tempArray WithName:@"Blood Pressure"];
            if([dataArray count] > 0){
                [self createBloodPressuredata:dataArray];
                [webView setHidden:NO];
                NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"graph" ofType:@"htm"]];
                [webView loadRequest:[NSURLRequest requestWithURL:url]];
            }
            else{
                [webView setHidden:YES];
            }
        }
    }
    else if(nonDialysisGraphSegment.selectedSegmentIndex == 1){
        UIView *view1 = [self.view viewWithTag:10001];
        UIView *view2 = [self.view viewWithTag:10002];
        if(view1){
            [view1 removeFromSuperview];
        }
        if(view2){
            [view2 removeFromSuperview];
        }
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            if([UIScreen mainScreen].bounds.size.height == 568){
                [webView setFrame:CGRectMake(0,164, webView.frame.size.width,351)];
            }
            else{
                [webView setFrame:CGRectMake(0,164, webView.frame.size.width,262)];
            }
        }
        else{
           [webView setFrame:CGRectMake(0,164, webView.frame.size.width,810)];
        }
        isGFRGraph = true;
        isBPGraph = false;
        [webView setHidden:YES];
        dataArray = [[DataManager sharedDataManager] getGFRData];
//        if([dataArray count] < 2){
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Insufficient Values" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//            return;
//        }
//        else{
            NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:kDate
                                                                         ascending:YES];
            NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
            NSArray *newArray = [dataArray sortedArrayUsingDescriptors:sortDescriptors];
            dataArray = newArray;
            NSArray *arrayWithDates = [self calculateDays:dataArray];
            if(arrayWithDates){
                arrayWithDates = [self returnCalculations:arrayWithDates];
            }
            dataArray = arrayWithDates;
            [self createGFRdata:dataArray];
            [webView setHidden:NO];
            NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"graph1" ofType:@"htm"]];
            [webView loadRequest:[NSURLRequest requestWithURL:url]];
 
        //}
    //        for(int i=0;i<[[scrollView subviews] count];i++){
//            UIView *subview = [scrollView.subviews objectAtIndex:i];
//            [subview removeFromSuperview];
//        }
//        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
//            [scrollView setContentSize:CGSizeMake(320,399)];
//        }
//        else{
//            [scrollView setContentSize:CGSizeMake(768,856)];
//        }
//        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
//        for(int i=0;i<[dataArray count];i++){
//            NSDictionary *dataDictionary = [dataArray objectAtIndex:i];
//            NSDictionary *secondDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[dataDictionary objectForKey:kGFR],kGFR,[dataDictionary objectForKey:@"y"],@"y", nil];
//            NSDictionary *dictionary = [NSDictionary dictionaryWithObject:secondDictionary forKey:[dataDictionary objectForKey:kDate]];
//            [tempArray addObject:dictionary];
//        }
//        [self drawGFRGraphAndDisplay:tempArray WithName:@"GFR"];
    }
//    CGRect scrollViewFrame = self.scrollView.frame;
//    CGFloat scaleWidth = scrollViewFrame.size.width / self.scrollView.contentSize.width;
//    CGFloat scaleHeight = scrollViewFrame.size.height / self.scrollView.contentSize.height;
//    CGFloat minScale = MIN(scaleWidth, scaleHeight);
//    self.scrollView.minimumZoomScale = minScale;
//    self.scrollView.maximumZoomScale = 1.0f;
}

- (IBAction)backButtonClicked:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return lineChart;
}

@end
