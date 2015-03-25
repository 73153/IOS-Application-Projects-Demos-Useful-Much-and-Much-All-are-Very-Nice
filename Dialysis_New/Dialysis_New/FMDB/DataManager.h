//
//  DataManager.h
//  Dialysis_New
//
//  Created by Amit Parmar on 27/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface DataManager : NSObject

+(DataManager *) sharedDataManager;

// Personal Information Table Methods
- (BOOL) insertPersonalInformation:(NSDictionary *)dictionary;
- (NSArray *) getPersonalInformation;
- (BOOL) updatepersonalInformation:(NSDictionary *)dictionary forName:(NSString *)oldName;
- (BOOL) deletepersonalInformationforRowId:(NSString *)name;

// Insert,update,retrieve and delete dialysis reading data
- (BOOL) insertDialysisreading:(NSDictionary *)dictionary;
-(BOOL) updateDialysisReading:(NSDictionary *)dictionary forRowId:(int) rowId;
- (NSArray *) getDialysisReading;
-(BOOL) deleteDialysisReadingForRowId:(int) rowId;

// Insert,update,delete and retrieve pictures
- (BOOL) insertPictures:(NSDictionary *)dictionary;
- (BOOL) updatePictures:(NSDictionary *)dictionary forRowId:(int) rowId;
- (NSArray *) getPictures;
- (BOOL) deletePicturesForRowId:(int) rowId;


- (BOOL) insertBallonData:(NSDictionary *)dictionary;
-(BOOL) updateBallonData:(NSDictionary *)dictionary forRowId:(int) rowId;
- (NSArray *) getBallonData;
-(BOOL) deleteBallonDataForRowId:(int) rowId;

- (BOOL) insertBloodPressureData:(NSDictionary *)dictionary;
-(BOOL) updateBloodPressureData:(NSDictionary *)dictionary forRowId:(int) rowId;
- (NSArray *) getBloodPressureData;
-(BOOL) deleteBloodPressureDataForRowId:(int) rowId;

// Insert,update,retrieve and delete dialysis reading data
- (BOOL) insertLabData:(NSDictionary *)dictionary;
-(BOOL) updateLabData:(NSDictionary *)dictionary forRowId:(int) rowId;
- (NSArray *) getLabData;
-(BOOL) deleteLabDataForRowId:(int) rowId;

// Insert,update,retrieve and delete mecicine reading data
- (BOOL) insertMedicineData:(NSDictionary *)dictionary;
- (BOOL) updateMedicineData:(NSDictionary *)dictionary forRowId:(int) rowId;
- (NSArray *) getMedicineData;
-(BOOL) deleteMedicineDataForRowId:(int) rowId;

// Insert,retrieve and delete gfr reading data
- (BOOL) insertGFRData:(NSDictionary *)dictionary;
- (NSArray *) getGFRData;
-(BOOL) deleteGFRDataForRowId:(int) rowId;

@end
