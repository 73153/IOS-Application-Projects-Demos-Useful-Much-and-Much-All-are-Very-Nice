//
//  DataManager.h
//  Dialysis_New
//
//  Created by Amit Parmar on 27/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@protocol ContactDelegate <NSObject>

-(void)returnContactArray:(NSArray *)dataArray;

@end

@interface DataManager : NSObject <QBActionStatusDelegate>

+(DataManager *) sharedDataManager;

@property (nonatomic) id<ContactDelegate> contactDelegate;
@property (nonatomic, strong) QBUUser *user;

- (BOOL) insertContactsData:(NSDictionary *)dictionary;
-(void) updateContactsData:(NSDictionary *)dictionary forRowId:(NSString*) rowId;
- (void) getHolaoutContactsData:(NSString *)userId;
- (NSArray *) getOtherContactsData;
-(BOOL) deleteContactsDataForRowId:(NSString*) rowId;
-(BOOL) deleteAllContacts;
//- (NSArray*) getParticularContact:(NSDictionary *)dictionary forRowId:(NSString*) rowId;
-(BOOL) deleteContactsDataForId:(NSString *) holaoutId;
-(void) deleteotherContacts:(NSArray*)dictionary;
-(void)callCompleteWithgResultToLoadDataIntially;

@end
