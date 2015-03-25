//
//  DataManager.m
//  Dialysis_New
//
//  Created by Amit Parmar on 27/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "DataManager.h"
#import "AppConstant.h"

static DataManager *dataManager;
@implementation DataManager


+(DataManager *)sharedDataManager{
    if(!dataManager){
        dataManager = [[DataManager alloc]init];
    }
    return dataManager;
}

- (BOOL) insertPersonalInformation:(NSDictionary *)dictionary{
    NSString *name = [dictionary objectForKey:kName];
    NSString *physicianName = [dictionary objectForKey:kPhysicianName];
    NSString *nephrologistName = [dictionary objectForKey:kNephrologistName];
    NSString *surgenName = [dictionary objectForKey:kSurgenName];
    
    NSString *physicianPhone = [dictionary objectForKey:kPhysicianPhone];
    NSString *nephrologistPhone = [dictionary objectForKey:kNephrologistPhone];
    NSString *surgenPhone = [dictionary objectForKey:kSurgenPhone];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    NSString *query = [NSString stringWithFormat:@"insert into personalInformation values('%@','%@','%@','%@','%@','%@','%@')",name,physicianName,physicianPhone,nephrologistName,nephrologistPhone,surgenName,surgenPhone];
    BOOL success =  [db executeUpdate:query];
    [db close];
    return success;
}

-(BOOL) updatepersonalInformation:(NSDictionary *)dictionary forName:(NSString *)oldName{
    NSString *name = [dictionary objectForKey:kName];
    NSString *physicianName = [dictionary objectForKey:kPhysicianName];
    NSString *nephrologistName = [dictionary objectForKey:kNephrologistName];
    NSString *surgenName = [dictionary objectForKey:kSurgenName];
    
    NSString *physicianPhone = [dictionary objectForKey:kPhysicianPhone];
    NSString *nephrologistPhone = [dictionary objectForKey:kNephrologistPhone];
    NSString *surgenPhone = [dictionary objectForKey:kSurgenPhone];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    BOOL success = [db executeUpdate:[NSString stringWithFormat:@"UPDATE personalInformation SET %@ = '%@', %@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@' where %@ = '%@'",kName,name,kPhysicianName,physicianName,kPhysicianPhone,physicianPhone,kNephrologistName,nephrologistName,kNephrologistPhone,nephrologistPhone,kSurgenName,surgenName,kSurgenPhone,surgenPhone,kName,oldName]];
    [db close];
    return success;
}

- (NSArray *) getPersonalInformation{
    NSMutableArray *personalInformations = [[NSMutableArray alloc] init];
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    FMResultSet *results = [db executeQuery:@"SELECT * FROM personalInformation"];
    while([results next]){
        NSString *name = [results stringForColumn:kName];
        NSString *physicianName = [results stringForColumn:kPhysicianName];
        NSString *physicianPhone = [results stringForColumn:kPhysicianPhone];
        
        NSString *nephrologistName = [results stringForColumn:kNephrologistName];
        NSString *nephrologistPhone = [results stringForColumn:kNephrologistPhone];
        
        NSString *surgenName = [results stringForColumn:kSurgenName];
        NSString *surgenPhone = [results stringForColumn:kSurgenPhone];
        
        
        NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] init];
        [dataDictionary setObject:name forKey:kName];
        [dataDictionary setObject:physicianName forKey:kPhysicianName];
        [dataDictionary setObject:physicianPhone forKey:kPhysicianPhone];
        [dataDictionary setObject:nephrologistName forKey:kNephrologistName];
        [dataDictionary setObject:nephrologistPhone forKey:kNephrologistPhone];
        [dataDictionary setObject:surgenName forKey:kSurgenName];
        [dataDictionary setObject:surgenPhone forKey:kSurgenPhone];
        
        [personalInformations addObject:dataDictionary];
    }
    [db close];
    return personalInformations;
}


-(BOOL) deletepersonalInformationforRowId:(NSString *)name{
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    BOOL success = [db executeUpdate:[NSString stringWithFormat:@"delete from personalInformation where %@='%@'",kName,name]];
    [db close];
    return success;
}

// Insert,update,retrieve and delete dialysis reading data

- (NSDate *) getDateOnlyFromDate:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar]
                                        components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
                                        fromDate:date];
    NSDate *selectedDateOnly = [[NSCalendar currentCalendar]
                                dateFromComponents:dateComponents];
    return selectedDateOnly;
}

- (BOOL) insertDialysisreading:(NSDictionary *)dictionary{
   
    NSDate *date = [self getDateOnlyFromDate:[dictionary objectForKey:kDate]];
    
    int timeinterval = [date timeIntervalSince1970];
    NSString *vp = [dictionary objectForKey:kVP];
    NSString *ap = [dictionary objectForKey:kAP];
    NSString *bf = [dictionary objectForKey:kBF];
    NSString *systolic = [dictionary objectForKey:kSystolic];
    NSString *diastolic = [dictionary objectForKey:kdiastolic];
    NSString *dryWeight = [dictionary objectForKey:kDryWeight];
    NSString *fluidGain = [dictionary objectForKey:kFluidGain];
    NSString *hb = [dictionary objectForKey:kHB];
    NSString *bun = [dictionary objectForKey:kBun];
    NSString *cr = [dictionary objectForKey:kCR];
    NSString *albiumin = [dictionary objectForKey:kAlbiumin];
    NSString *phosph = [dictionary objectForKey:kPhosph];
    NSString *pth = [dictionary objectForKey:kPTH];
    NSString *kt = [dictionary objectForKey:kKT];
    NSString *inr = [dictionary objectForKey:kINR];
    NSString *ktv = [dictionary objectForKey:kKTV];
    
    if(!vp)
        vp = @"0";
    if(!ap)
        ap = @"0";
    if(!bf)
        bf = @"0";
    if(!systolic)
        systolic = @"0";
    if(!diastolic)
        diastolic = @"0";
    if(!dryWeight)
        dryWeight = @"0";
    if(!fluidGain)
        fluidGain = @"0";
    if(!hb)
        hb= @"0";
    if(!bun)
        bun = @"0";
    if(!cr)
        cr = @"0";
    if(!albiumin)
        albiumin = @"0";
    if(!phosph)
        phosph = @"0";
    if(!pth)
        pth = @"0";
    if(!kt)
        kt = @"0";
    if(!inr)
        inr = @"0";
    if(!ktv)
        ktv = @"0";
    
    int rowId = [[self getDialysisReading] count]+1;
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    NSString *query = [NSString stringWithFormat:@"insert into dialysisReading values(%d,%d,'%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",rowId,timeinterval,vp,ap,bf,systolic,diastolic,dryWeight,fluidGain,hb,bun,cr,albiumin,phosph,pth,kt,inr,ktv];
    NSError *error;
    BOOL success =  [db executeUpdate:query error:&error withArgumentsInArray:nil orVAList:nil];
    [db close];
    return success;
}

-(BOOL) updateDialysisReading:(NSDictionary *)dictionary forRowId:(int) rowId{
    NSDate *date = [dictionary objectForKey:kDate];
    int timeInterval =[date timeIntervalSince1970];
    NSString *vp = [dictionary objectForKey:kVP];
    NSString *ap = [dictionary objectForKey:kAP];
    NSString *bf = [dictionary objectForKey:kBF];
    NSString *systolic = [dictionary objectForKey:kSystolic];
    NSString *diastolic = [dictionary objectForKey:kdiastolic];
    NSString *dryWeight = [dictionary objectForKey:kDryWeight];
    NSString *fluidGain = [dictionary objectForKey:kFluidGain];
    NSString *hb = [dictionary objectForKey:kHB];
    NSString *bun = [dictionary objectForKey:kBun];
    NSString *cr = [dictionary objectForKey:kCR];
    NSString *albiumin = [dictionary objectForKey:kAlbiumin];
    NSString *phosph = [dictionary objectForKey:kPhosph];
    NSString *pth = [dictionary objectForKey:kPTH];
    NSString *kt = [dictionary objectForKey:kKT];
    NSString *inr = [dictionary objectForKey:kINR];
    NSString *ktv = [dictionary objectForKey:kKTV];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    BOOL success = [db executeUpdate:[NSString stringWithFormat:@"UPDATE dialysisReading SET %@ = %d,%@ ='%@',%@ ='%@',%@ ='%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@' where %@=%d",kDate,timeInterval,kVP,vp,kAP,ap,kBF,bf,kSystolic,systolic,kdiastolic,diastolic,kDryWeight,dryWeight,kFluidGain,fluidGain,kHB,hb,kBun,bun,kCR,cr,kAlbiumin,albiumin,kPhosph,phosph,kPTH,pth,kKT,kt,kINR,inr,kKTV,ktv,kRowId,rowId]];
    [db close];
    return success;
}

- (NSArray *) getDialysisReading{
    NSMutableArray *personalInformations = [[NSMutableArray alloc] init];
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    FMResultSet *results = [db executeQuery:@"SELECT * FROM dialysisReading"];
    while([results next]){
        
        NSDate *date = [results dateForColumn:kDate];
        NSString *vp = [results stringForColumn:kVP];
        NSString *ap = [results stringForColumn:kAP];
        NSString *bf = [results stringForColumn:kBF];
        NSString *systolic = [results stringForColumn:kSystolic];
        NSString *diastolic = [results stringForColumn:kdiastolic];
        NSString *dryWeight = [results stringForColumn:kDryWeight];
        NSString *fluidGain = [results stringForColumn:kFluidGain];
        NSString *hb = [results stringForColumn:kHB];
        NSString *bun = [results stringForColumn:kBun];
        NSString *cr = [results stringForColumn:kCR];
        NSString *albiumin = [results stringForColumn:kAlbiumin];
        NSString *phosph = [results stringForColumn:kPhosph];
        NSString *pth = [results stringForColumn:kPTH];
        NSString *kt = [results stringForColumn:kKT];
        NSString *inr = [results stringForColumn:kINR];
        NSString *ktv = [results stringForColumn:kKTV];
        NSString *rowId = [NSString stringWithFormat:@"%d",[results intForColumn:kRowId]];
        
        NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] init];
        [dataDictionary setObject:date forKey:kDate];
        [dataDictionary setObject:vp forKey:kVP];
        [dataDictionary setObject:ap forKey:kAP];
        [dataDictionary setObject:bf forKey:kBF];
        [dataDictionary setObject:systolic forKey:kSystolic];
        [dataDictionary setObject:diastolic forKey:kdiastolic];
        [dataDictionary setObject:dryWeight forKey:kDryWeight];
        [dataDictionary setObject:fluidGain forKey:kFluidGain];
        [dataDictionary setObject:hb forKey:kHB];
        [dataDictionary setObject:bun forKey:kBun];
        [dataDictionary setObject:cr forKey:kCR];
        [dataDictionary setObject:albiumin forKey:kAlbiumin];
        [dataDictionary setObject:phosph forKey:kPhosph];
        [dataDictionary setObject:pth forKey:kPTH];
        [dataDictionary setObject:kt forKey:kKT];
        [dataDictionary setObject:inr forKey:kINR];
        [dataDictionary setObject:ktv forKey:kKTV];
        [dataDictionary setObject:rowId forKey:kRowId];
        
        [personalInformations addObject:dataDictionary];
    }
    [db close];
    return personalInformations;
}


-(BOOL) deleteDialysisReadingForRowId:(int) rowId{
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    BOOL success = [db executeUpdate:[NSString stringWithFormat:@"delete from dialysisReading where %@=%d",kRowId,rowId]];
    [db close];
    return success;
}


// Insert,update,delete,retrieve Pictures

- (NSString *)applicationDocumentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

- (BOOL) insertPictures:(NSDictionary *)dictionary{
    NSDate *date = [self getDateOnlyFromDate:[dictionary objectForKey:kDate]];
    int timeinterval = [date timeIntervalSince1970];
    int rowId = [[self getPictures] count]+1;
    NSData *data = [dictionary objectForKey:kImage];
    NSString *strPath = [NSString stringWithFormat:@"%@/%d.png",[self applicationDocumentsDirectory],rowId];
    [[NSFileManager defaultManager] createFileAtPath:strPath contents:data attributes:nil];
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    NSString *query = [NSString stringWithFormat:@"insert into pictures values(%d,'%@',%d)",rowId,strPath,timeinterval];
    NSError *error;
    BOOL success =  [db executeUpdate:query error:&error withArgumentsInArray:nil orVAList:nil];
    [db close];
    return success;
}

-(BOOL) updatePictures:(NSDictionary *)dictionary forRowId:(int) rowId{
    NSDate *date = [dictionary objectForKey:kDate];
    int timeInterval =[date timeIntervalSince1970];
    NSData *imgData = [dictionary objectForKey:kImage];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    BOOL success = [db executeUpdate:[NSString stringWithFormat:@"UPDATE pictures SET %@=%@,%@=%d where %@=%d",kImage,imgData,kDate,timeInterval,kRowId,rowId]];
    [db close];
    return success;
}

- (NSArray *) getPictures{
    NSMutableArray *pictures = [[NSMutableArray alloc] init];
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    FMResultSet *results = [db executeQuery:@"SELECT * FROM pictures"];
    while([results next]){
        
        NSDate *date = [results dateForColumn:kDate];
        NSString *data = [results stringForColumn:kImage];
        NSString *rowId = [NSString stringWithFormat:@"%d",[results intForColumn:kRowId]];
        NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] init];
        [dataDictionary setObject:date forKey:kDate];
        [dataDictionary setObject:data forKey:kImage];
        [dataDictionary setObject:rowId forKey:kRowId];
        
        [pictures addObject:dataDictionary];
    }
    [db close];
    return pictures;
}

-(BOOL) deletePicturesForRowId:(int) rowId{
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    BOOL success = [db executeUpdate:[NSString stringWithFormat:@"delete from pictures where %@=%d",kRowId,rowId]];
    [db close];
    return success;
}


- (BOOL) insertBallonData:(NSDictionary *)dictionary{
    
    NSDate *date = [self getDateOnlyFromDate:[dictionary objectForKey:kDate]];
    
    int timeinterval = [date timeIntervalSince1970];
    int rowId = [[self getBallonData] count]+1;
    
    NSString *angioGraphy = [dictionary objectForKey:kAngiography];
    NSString *ballonAngioPlasty = [dictionary objectForKey:kBallonAngioPlasty];
    NSString *stentPlacement = [dictionary objectForKey:kStentPlacement];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    NSString *query = [NSString stringWithFormat:@"insert into ballonAngioplasty values(%d,%d,'%@','%@','%@')",rowId,timeinterval,angioGraphy,ballonAngioPlasty,stentPlacement];
    NSError *error;
    BOOL success =  [db executeUpdate:query error:&error withArgumentsInArray:nil orVAList:nil];
    [db close];
    return success;
}

-(BOOL) updateBallonData:(NSDictionary *)dictionary forRowId:(int) rowId{
    NSDate *date = [dictionary objectForKey:kDate];
    int timeInterval =[date timeIntervalSince1970];
    
    NSString *angioGraphy = [dictionary objectForKey:kAngiography];
    NSString *ballonAngioPlasty = [dictionary objectForKey:kBallonAngioPlasty];
    NSString *stentPlacement = [dictionary objectForKey:kStentPlacement];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    BOOL success = [db executeUpdate:[NSString stringWithFormat:@"UPDATE ballonAngioplasty SET %@ = %d,%@ ='%@',%@ ='%@',%@ ='%@' where %@=%d",kDate,timeInterval,kAngiography,angioGraphy,kBallonAngioPlasty,ballonAngioPlasty,kStentPlacement,stentPlacement,kRowId,rowId]];
    [db close];
    return success;
}

- (NSArray *) getBallonData{
    NSMutableArray *personalInformations = [[NSMutableArray alloc] init];
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    FMResultSet *results = [db executeQuery:@"SELECT * FROM ballonAngioplasty"];
    while([results next]){
        
        NSDate *date = [results dateForColumn:kDate];
        NSString *rowId = [NSString stringWithFormat:@"%d",[results intForColumn:kRowId]];
        
        NSString *angioGraphy = [results stringForColumn:kAngiography];
        NSString *ballonAngioplasty = [results stringForColumn:kBallonAngioPlasty];
        NSString *stentPlacement = [results stringForColumn:kStentPlacement];
        
        NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] init];
        [dataDictionary setObject:date forKey:kDate];
        [dataDictionary setObject:rowId forKey:kRowId];
        [dataDictionary setObject:angioGraphy forKey:kAngiography];
        [dataDictionary setObject:ballonAngioplasty forKey:kBallonAngioPlasty];
        [dataDictionary setObject:stentPlacement forKey:kStentPlacement];
        [personalInformations addObject:dataDictionary];
    }
    [db close];
    return personalInformations;
}


-(BOOL) deleteBallonDataForRowId:(int) rowId{
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    BOOL success = [db executeUpdate:[NSString stringWithFormat:@"delete from ballonAngioplasty where %@=%d",kRowId,rowId]];
    [db close];
    return success;
}


- (BOOL) insertBloodPressureData:(NSDictionary *)dictionary{
    NSDate *date = [self getDateOnlyFromDate:[dictionary objectForKey:kDate]];
    int timeinterval = [date timeIntervalSince1970];
    int rowId = [[self getBloodPressureData] count]+1;
    NSString *systolic = [dictionary objectForKey:kSystolic];
    NSString *diastolic = [dictionary objectForKey:kdiastolic];
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    NSString *query = [NSString stringWithFormat:@"insert into bloodPressure values(%d,%d,'%@','%@')",rowId,timeinterval,systolic,diastolic];
    NSError *error;
    BOOL success =  [db executeUpdate:query error:&error withArgumentsInArray:nil orVAList:nil];
    [db close];
    return success;
}
-(BOOL) updateBloodPressureData:(NSDictionary *)dictionary forRowId:(int) rowId{
    NSDate *date = [dictionary objectForKey:kDate];
    int timeInterval =[date timeIntervalSince1970];
    
    NSString *systolic = [dictionary objectForKey:kSystolic];
    NSString *diastolic = [dictionary objectForKey:kdiastolic];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    BOOL success = [db executeUpdate:[NSString stringWithFormat:@"UPDATE bloodPressure SET %@ = %d,%@ ='%@',%@ ='%@' where %@=%d",kDate,timeInterval,kSystolic,systolic,kdiastolic,diastolic,kRowId,rowId]];
    [db close];
    return success;
}
- (NSArray *) getBloodPressureData{
    NSMutableArray *personalInformations = [[NSMutableArray alloc] init];
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    FMResultSet *results = [db executeQuery:@"SELECT * FROM bloodPressure"];
    while([results next]){
        
        NSDate *date = [results dateForColumn:kDate];
        NSString *rowId = [NSString stringWithFormat:@"%d",[results intForColumn:kRowId]];
        
        NSString *systolic = [results stringForColumn:kSystolic];
        NSString *diastolic = [results stringForColumn:kdiastolic];
        
        NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] init];
        [dataDictionary setObject:date forKey:kDate];
        [dataDictionary setObject:rowId forKey:kRowId];
        [dataDictionary setObject:systolic forKey:kSystolic];
        [dataDictionary setObject:diastolic forKey:kdiastolic];
        [personalInformations addObject:dataDictionary];
    }
    [db close];
    return personalInformations;
}
-(BOOL) deleteBloodPressureDataForRowId:(int) rowId{
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    BOOL success = [db executeUpdate:[NSString stringWithFormat:@"delete from bloodPressure where %@=%d",kRowId,rowId]];
    [db close];
    return success;
}


// Insert,update,retrieve and delete dialysis reading data


- (BOOL) insertLabData:(NSDictionary *)dictionary{
    
    NSDate *date = [self getDateOnlyFromDate:[dictionary objectForKey:kDate]];
    
    int timeinterval = [date timeIntervalSince1970];
    int rowId = [[self getLabData] count]+1;
    
    NSString *hb = [dictionary objectForKey:kHB];
    NSString *bun = [dictionary objectForKey:kBun];
    NSString *cr = [dictionary objectForKey:kCR];
    NSString *albiumin = [dictionary objectForKey:kAlbiumin];
    NSString *phosph = [dictionary objectForKey:kPhosph];
    NSString *pth = [dictionary objectForKey:kPTH];
    NSString *kt = [dictionary objectForKey:kKT];
    NSString *inr = [dictionary objectForKey:kINR];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    NSString *query = [NSString stringWithFormat:@"insert into lab values(%d,%d,'%@','%@','%@','%@','%@','%@','%@','%@')",rowId,timeinterval,hb,bun,cr,albiumin,phosph,pth,kt,inr];
    NSError *error;
    BOOL success =  [db executeUpdate:query error:&error withArgumentsInArray:nil orVAList:nil];
    [db close];
    return success;
}

-(BOOL) updateLabData:(NSDictionary *)dictionary forRowId:(int) rowId{
    NSDate *date = [dictionary objectForKey:kDate];
    int timeInterval =[date timeIntervalSince1970];
    
    NSString *hb = [dictionary objectForKey:kHB];
    NSString *bun = [dictionary objectForKey:kBun];
    NSString *cr = [dictionary objectForKey:kCR];
    NSString *albiumin = [dictionary objectForKey:kAlbiumin];
    NSString *phosph = [dictionary objectForKey:kPhosph];
    NSString *pth = [dictionary objectForKey:kPTH];
    NSString *kt = [dictionary objectForKey:kKT];
    NSString *inr = [dictionary objectForKey:kINR];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    BOOL success = [db executeUpdate:[NSString stringWithFormat:@"UPDATE lab SET %@=%d,%@='%@',%@='%@',%@='%@',%@='%@',%@='%@',%@='%@',%@='%@',%@='%@' where %@=%d",kDate,timeInterval,kHB,hb,kBun,bun,kCR,cr,kAlbiumin,albiumin,kPhosph,phosph,kPTH,pth,kKT,kt,kINR,inr,kRowId,rowId]];
    [db close];
    return success;
}

- (NSArray *) getLabData{
    NSMutableArray *personalInformations = [[NSMutableArray alloc] init];
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    FMResultSet *results = [db executeQuery:@"SELECT * FROM lab"];
    while([results next]){
        
        NSDate *date = [results dateForColumn:kDate];
        NSString *hb = [results stringForColumn:kHB];
        NSString *bun = [results stringForColumn:kBun];
        NSString *cr = [results stringForColumn:kCR];
        NSString *albiumin = [results stringForColumn:kAlbiumin];
        NSString *phosph = [results stringForColumn:kPhosph];
        NSString *pth = [results stringForColumn:kPTH];
        NSString *kt = [results stringForColumn:kKT];
        NSString *inr = [results stringForColumn:kINR];
        NSString *rowId = [NSString stringWithFormat:@"%d",[results intForColumn:kRowId]];
        
        NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] init];
        [dataDictionary setObject:date forKey:kDate];
        [dataDictionary setObject:hb forKey:kHB];
        [dataDictionary setObject:bun forKey:kBun];
        [dataDictionary setObject:cr forKey:kCR];
        [dataDictionary setObject:albiumin forKey:kAlbiumin];
        [dataDictionary setObject:phosph forKey:kPhosph];
        [dataDictionary setObject:pth forKey:kPTH];
        [dataDictionary setObject:kt forKey:kKT];
        [dataDictionary setObject:inr forKey:kINR];
        [dataDictionary setObject:rowId forKey:kRowId];
        
        [personalInformations addObject:dataDictionary];
    }
    [db close];
    return personalInformations;
}


-(BOOL) deleteLabDataForRowId:(int) rowId{
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    BOOL success = [db executeUpdate:[NSString stringWithFormat:@"delete from lab where %@=%d",kRowId,rowId]];
    [db close];
    return success;
}


// Insert,update,retrieve and delete dialysis reading data


- (BOOL) insertMedicineData:(NSDictionary *)dictionary{
    int rowId = [[self getMedicineData] count]+1;
    NSString *pharmacyName = [dictionary objectForKey:kPharmacyName];
    NSString *location = [dictionary objectForKey:kLocation];
    NSString *firstContactNo = [dictionary objectForKey:kFirstContactNO];
    NSString *secondContactNo = [dictionary objectForKey:kSecondContactNo];
    NSString *medicine1 = [dictionary objectForKey:kMedicine1];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    NSString *query = [NSString stringWithFormat:@"insert into medicine values(%d,'%@','%@','%@','%@','%@')",rowId,pharmacyName,location,firstContactNo,secondContactNo,medicine1];
    NSError *error;
    BOOL success =  [db executeUpdate:query error:&error withArgumentsInArray:nil orVAList:nil];
    [db close];
    return success;
}

-(BOOL) updateMedicineData:(NSDictionary *)dictionary forRowId:(int) rowId{
    
    NSString *pharmacyName = [dictionary objectForKey:kPharmacyName];
    NSString *location = [dictionary objectForKey:kLocation];
    NSString *firstContactNo = [dictionary objectForKey:kFirstContactNO];
    NSString *secondContactNo = [dictionary objectForKey:kSecondContactNo];
    NSString *medicine1 = [dictionary objectForKey:kMedicine1];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    BOOL success = [db executeUpdate:[NSString stringWithFormat:@"UPDATE medicine SET %@='%@',%@='%@',%@='%@',%@='%@',%@='%@' where %@=%d",kPharmacyName,pharmacyName,kLocation,location,kFirstContactNO,firstContactNo,kSecondContactNo,secondContactNo,kMedicine1,medicine1,kRowId,rowId]];
    [db close];
    return success;
}

- (NSArray *) getMedicineData{
    NSMutableArray *personalInformations = [[NSMutableArray alloc] init];
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    FMResultSet *results = [db executeQuery:@"SELECT * FROM medicine"];
    while([results next]){
        
        NSString *pharmacyName = [results stringForColumn:kPharmacyName];
        NSString *location = [results stringForColumn:kLocation];
        NSString *firstContactNo = [results stringForColumn:kFirstContactNO];
        NSString *secondContactNo = [results stringForColumn:kSecondContactNo];
        NSString *medicine1 = [results stringForColumn:kMedicine1];
        NSString *rowId = [NSString stringWithFormat:@"%d",[results intForColumn:kRowId]];
        
        NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] init];
        [dataDictionary setObject:rowId forKey:kRowId];
        [dataDictionary setObject:pharmacyName forKey:kPharmacyName];
        [dataDictionary setObject:location forKey:kLocation];
        [dataDictionary setObject:firstContactNo forKey:kFirstContactNO];
        [dataDictionary setObject:secondContactNo forKey:kSecondContactNo];
        [dataDictionary setObject:medicine1 forKey:kMedicine1];
        [personalInformations addObject:dataDictionary];
    }
    [db close];
    return personalInformations;
}


-(BOOL) deleteMedicineDataForRowId:(int) rowId{
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    BOOL success = [db executeUpdate:[NSString stringWithFormat:@"delete from medicine where %@=%d",kRowId,rowId]];
    [db close];
    return success;
}

// Insert,retrieve and delete gfr reading data
- (BOOL) insertGFRData:(NSDictionary *)dictionary{
    int rowId = [[self getGFRData] count]+1;
    NSDate *date = [self getDateOnlyFromDate:[dictionary objectForKey:kDate]];
    int timeinterval = [date timeIntervalSince1970];
    
    NSString *creatinine = [dictionary objectForKey:kCreatinine];
    NSString *gfr = [dictionary objectForKey:kGFR];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    NSString *query = [NSString stringWithFormat:@"insert into gfr values(%d,'%@','%@',%d)",rowId,creatinine,gfr,timeinterval];
    NSError *error;
    BOOL success =  [db executeUpdate:query error:&error withArgumentsInArray:nil orVAList:nil];
    [db close];
    return success;
}

- (NSArray *) getGFRData{
    NSMutableArray *gfrInformation = [[NSMutableArray alloc] init];
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    FMResultSet *results = [db executeQuery:@"SELECT * FROM gfr"];
    while([results next]){
        NSString *creatinine = [results stringForColumn:kCreatinine];
        NSString *gfr = [results stringForColumn:kGFR];
        NSString *rowId = [NSString stringWithFormat:@"%d",[results intForColumn:kRowId]];
        NSDate *date = [results dateForColumn:kDate];
        
        NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] init];
        [dataDictionary setObject:rowId forKey:kRowId];
        [dataDictionary setObject:creatinine forKey:kCreatinine];
        [dataDictionary setObject:gfr forKey:kGFR];
        [dataDictionary setObject:date forKey:kDate];
        [gfrInformation addObject:dataDictionary];
    }
    [db close];
    return gfrInformation;
}

-(BOOL) deleteGFRDataForRowId:(int) rowId{
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    BOOL success = [db executeUpdate:[NSString stringWithFormat:@"delete from gfr where %@=%d",kRowId,rowId]];
    [db close];
    return success;
}
@end
