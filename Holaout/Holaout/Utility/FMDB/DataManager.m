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
@synthesize contactDelegate;
@synthesize user;

+(DataManager *)sharedDataManager{
    if(!dataManager){
        dataManager = [[DataManager alloc]init];
    }
    return dataManager;
}



// Insert,update,retrieve and delete dialysis reading data

- (NSString *)applicationDocumentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}


- (BOOL) insertContactsData:(NSDictionary *)dictionary{
//    NSString *currentUser = [NSString stringWithFormat:@"%d",user.ID];
    
    //    int rowId = [[self getHolaoutContactsData:currentUser]  +[[self getOtherContactsData] count] + 1;
    NSString *contactName = [dictionary objectForKey:kContactName];
    NSString *contactPhone = [dictionary objectForKey:KContactPhone];
    NSString *contactEmail = [dictionary objectForKey:kContactEmail];
    NSString *contactIsHolaout = [dictionary objectForKey:kContactIsHolaout];
    NSString *contactHolaoutId = [dictionary objectForKey:kContactHolaoutId];
    NSData *contactData = [dictionary objectForKey:kContactImage];
    
    if(!contactName){
        contactName = @"";
    }
    if(!contactPhone){
        contactPhone = @"";
    }
    if(!contactEmail){
        contactEmail = @"";
    }
    if(!contactIsHolaout){
        contactIsHolaout = @"1";
    }
    if(!contactHolaoutId){
        contactHolaoutId = @"";
    }
    NSString *contactImage;
    if(contactData){
        contactImage = [NSString stringWithFormat:@"%@/%d.png",[self applicationDocumentsDirectory],[contactHolaoutId intValue]];
        [[NSFileManager defaultManager] createFileAtPath:contactImage contents:contactData attributes:nil];
    }
    else{
        contactImage = @"";
    }
    
    QBCOCustomObject *object = [QBCOCustomObject customObject];
    
    object.className = KCustomClassName;
    //NSString *ID = [NSString stringWithFormat:@"%d", rowId];
    [object.fields setObject:[NSString stringWithFormat:@"%d",user.ID] forKey:kContactId];
    [object.fields setObject:contactName forKey:kContactName];
    [object.fields setObject:contactPhone forKey:KContactPhone];
    [object.fields setObject:contactEmail forKey:kContactEmail];
    [object.fields setObject:contactIsHolaout forKey:kContactIsHolaout];
    [object.fields setObject:contactHolaoutId forKey:kContactHolaoutId];
    [object.fields setObject:contactImage forKey:kContactImage];
    [object.fields setObject:@"0" forKey:kISBlocked];
    
    [QBCustomObjects createObject:object delegate:self];
    
    return YES;
}

- (void)completedWithResult:(Result *)result{
    // Get objects result
    if(result.success && [result isKindOfClass:QBCOCustomObjectPagedResult.class]){
        QBCOCustomObjectPagedResult *getObjectsResult = (QBCOCustomObjectPagedResult *)result;
        NSLog(@"Objects: %@, count: %d", getObjectsResult.objects, getObjectsResult.count);
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for(int i=0;i<[getObjectsResult.objects count];i++){
            QBCOCustomObject *objectDict = [getObjectsResult.objects objectAtIndex:i];
            NSString *contactId = objectDict.fields[kContactId];
            NSString *isBlocked = objectDict.fields[kISBlocked];
            NSString *contactName = objectDict.fields[kContactName];
            NSString *contactPhone = objectDict.fields[KContactPhone];
            NSString *contactEmail = objectDict.fields[kContactEmail];
            NSString *contactHolaoutId = objectDict.fields[kContactHolaoutId];
            NSString *contactImage = objectDict.fields[kContactImage];
            NSString *contactIsHolaout = objectDict.fields[kContactIsHolaout];
            NSString *ID = objectDict.ID;
            if(!ID){
                ID = @"";
            }
            if(!isBlocked){
                isBlocked = @"";
            }
            if(!contactId || [contactId isEqual:[NSNull null]]){
                contactId = @"";
            }
            if(!contactName || [contactName isEqual:[NSNull null]]){
                contactName = @"";
            }
            if(!contactPhone ||[contactPhone isEqual:[NSNull null]]){
                contactPhone = @"";
            }
            if(!contactEmail ||[contactEmail isEqual:[NSNull null]]){
                contactEmail = @"";
            }
            if(!contactHolaoutId ||[contactHolaoutId isEqual:[NSNull null]]){
                contactHolaoutId = @"";
            }
            if(!contactImage ||[contactImage isEqual:[NSNull null]]){
                contactImage = @"";
            }
            if(!contactIsHolaout ||[contactIsHolaout isEqual:[NSNull null]]){
                contactIsHolaout = @"";
            }
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:contactId,kContactId,contactName,kContactName,contactPhone,KContactPhone,contactEmail,kContactEmail,contactHolaoutId,kContactHolaoutId,contactImage,kContactImage,contactIsHolaout,kContactIsHolaout,ID,KID,isBlocked,kISBlocked,nil];
            [array addObject:dictionary];
        }
        [contactDelegate returnContactArray:array];
    }
    else if (result.success && [result isKindOfClass:QBCOMultiDeleteResult.class]) {
        NSLog(@"Delete Objects Called");
    }
    else if(result.success && [result isKindOfClass:QBCOCustomObjectResult.class]){
        QBCOCustomObjectResult *updateObjectResult = (QBCOCustomObjectResult *)result;
        [QBCustomObjects objectsWithClassName:KCustomClassName delegate:self];
        NSLog(@"Object: %@", updateObjectResult.object);
    }
    else{
        NSLog(@"errors=%@",result.errors);
    }
}

-(void) updateContactsData:(NSDictionary *)dictionary forRowId:(NSString*) rowId{
    
    NSString *contactName = [dictionary objectForKey:kContactName];
    NSString *contactPhone = [dictionary objectForKey:KContactPhone];
    NSString *contactEmail = [dictionary objectForKey:kContactEmail];
    NSString *contactIsHolaout = [dictionary objectForKey:kContactIsHolaout];
    NSString *contactHolaoutId = [dictionary objectForKey:kContactHolaoutId];
    NSString *isBlocked = [dictionary objectForKey:kISBlocked];
    NSData *contactData = [dictionary objectForKey:kContactImage];
    NSString *contactId = [dictionary objectForKey:kContactId];
    NSString *contactImage = [NSString stringWithFormat:@"%@/%@.png",[self applicationDocumentsDirectory],rowId];
    [[NSFileManager defaultManager] createFileAtPath:contactImage contents:contactData attributes:nil];
    
    if(!contactName){
        contactName = @"";
    }
    if(!contactPhone){
        contactPhone = @"";
    }
    if(!contactEmail){
        contactEmail = @"";
    }
    if(!contactIsHolaout){
        contactIsHolaout = @"0";
    }
    if(!contactHolaoutId){
        contactHolaoutId = @"";
    }
    if(!contactImage){
        contactImage=@"";
    }
    if(!contactId){
        contactId = @"";
    }
    if(!isBlocked){
        isBlocked = @"0";
    }
    
    QBCOCustomObject *object = [QBCOCustomObject customObject];
    
    object.className = KCustomClassName;
    object.ID = rowId;
    [object.fields setObject:contactName forKey:kContactName];
    [object.fields setObject:contactPhone forKey:KContactPhone];
    [object.fields setObject:contactEmail forKey:kContactEmail];
    [object.fields setObject:contactIsHolaout forKey:kContactIsHolaout];
    [object.fields setObject:contactHolaoutId forKey:kContactHolaoutId];
    [object.fields setObject:contactImage forKey:kContactImage];
    [object.fields setObject:isBlocked forKey:kISBlocked];
    [object.fields setObject:contactId forKey:kContactId];
    
    [QBCustomObjects updateObject:object delegate:self];
}

-(void)callCompleteWithgResultToLoadDataIntially
{
    [QBCustomObjects objectsWithClassName:KCustomClassName delegate:self];
}
- (void) getHolaoutContactsData:(NSString *)userId{
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:userId forKey:@"user_id"];
    [QBCustomObjects objectsWithClassName:KCustomClassName extendedRequest:dictionary delegate:self];
}

#pragma mark -
#pragma mark QBActionStatusDelegate

- (NSArray *) getOtherContactsData{
    NSMutableArray *personalInformations = [[NSMutableArray alloc] init];
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM Contacts where %@=%d",kContactIsHolaout,0]];
    while([results next]){
        NSString *contactName = [results stringForColumn:kContactName];
        NSString *contactPhone = [results stringForColumn:KContactPhone];
        NSString *contactEmail = [results stringForColumn:kContactEmail];
        NSString *contactHolaoutId = [results stringForColumn:kContactHolaoutId];
        NSString *contactIsHolaout = [NSString stringWithFormat:@"%d",[results intForColumn:kContactIsHolaout]];
        NSString *contactImage = [results stringForColumn:kContactImage];
        
        NSString *rowId = [NSString stringWithFormat:@"%d",[results intForColumn:kContactId]];
        
        
        NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] init];
        [dataDictionary setObject:rowId forKey:kContactId];
        [dataDictionary setObject:contactName forKey:kContactName];
        [dataDictionary setObject:contactPhone forKey:KContactPhone];
        [dataDictionary setObject:contactEmail forKey:kContactEmail];
        [dataDictionary setObject:contactIsHolaout forKey:kContactIsHolaout];
        [dataDictionary setObject:contactImage forKey:kContactImage];
        [dataDictionary setObject:contactHolaoutId forKey:kContactHolaoutId];
        [personalInformations addObject:dataDictionary];
    }
    [db close];
    return personalInformations;
}

-(BOOL) deleteContactsDataForRowId:(NSString*) rowId{
    
    [QBCustomObjects deleteObjectWithID:rowId className:KCustomClassName delegate:self];
    return YES;
}

-(BOOL) deleteContactsDataForId:(NSString *) holaoutId{
    
    [QBCustomObjects deleteObjectWithID:holaoutId className:KCustomClassName delegate:self];
    return YES;
}
-(void) deleteotherContacts:(NSArray*)array
{
    [QBCustomObjects deleteObjectsWithIDs:array className:KCustomClassName delegate:self];
}


-(BOOL) deleteAllContacts{
    NSString *query = @"DELETE FROM Contacts";
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    BOOL success = [db executeUpdate:query];
    [db close];
    return success;
}

//- (NSArray*) getParticularContact:(NSDictionary *)dictionary forRowId:(NSString*) rowId{
//    
//    [QBCustomObjects objectWithClassName:KCustomClassName ID:rowId delegate:self];
//}

@end
