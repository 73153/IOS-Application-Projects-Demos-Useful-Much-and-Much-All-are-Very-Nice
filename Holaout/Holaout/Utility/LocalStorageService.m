//
//  LocalStorageService.m
//  sample-chat
//
//  Created by Igor Khomenko on 10/16/13.
//  Copyright (c) 2013 Igor Khomenko. All rights reserved.
//

#import "LocalStorageService.h"
#import "NSDate+Helper.h"

@implementation LocalStorageService{
    
}

@synthesize chatDelegate;
@synthesize currentUser;

+ (instancetype)shared
{
	static id instance = nil;
	static dispatch_once_t onceToken;
	
	dispatch_once(&onceToken, ^{
		instance = [[self alloc] init];
	});
	
	return instance;
}

- (id)init
{
    self = [super init];
    if(self){
    }
    return self;
}

- (void)saveImageToHistory:(NSDictionary *)message withUserID:(NSUInteger)userID
{
    QBChatMessage *msg = [message objectForKey:@"message"];
    NSString *senderID = [@(msg.senderID) stringValue];
    NSString *recipientID = [@(msg.recipientID) stringValue];
    NSString *txtMessage = @"0";
    NSString *txtTime = [NSDate stringFromDate:msg.datetime];
    NSString *isVideo;
    NSString *isYTVideo;
    NSString *txtImageID;
    NSString *txtVideoID;
    if (msg.customParameters[@"video"]) {
        isVideo = @"1";
        txtImageID = msg.customParameters[@"fileID"];
        txtVideoID = msg.customParameters[@"videoID"];
        if (msg.customParameters[@"isYouTubeVideo"]) {
            isYTVideo = @"1";
        }
        else
        {
            isYTVideo = @"0";
        }
    }
    else {
        isVideo = @"0";
        isYTVideo = @"0";
        txtImageID = message[@"image"];
        txtVideoID = @"0";
    }
    
    NSString *txtDestructer;
    if ([msg.customParameters objectForKey:kDestructTime] != nil) {
        txtDestructer = [msg.customParameters objectForKey:kDestructTime];
    } else {
        txtDestructer = @"0";
    }
    
    QBCOCustomObject *object = [ QBCOCustomObject customObject];
    object.className = kChatClass;
    [object.fields setObject:senderID forKey:@"senderID"];
    [object.fields setObject:recipientID forKey:@"recipientID"];
    [object.fields setObject:txtMessage forKey:@"chatMessage"];
    [object.fields setObject:txtTime forKey:@"chatTime"];
    [object.fields setObject:txtImageID forKey:@"chatImageID"];
    [object.fields setObject:txtDestructer forKey:@"destructer"];
    [object.fields setObject:isVideo forKey:@"isVideo"];
    [object.fields setObject:isYTVideo forKey:@"isYoutubeVideo"];
    [object.fields setObject:txtVideoID forKey:@"videoID"];

//    QBCOPermissions *permissions = [QBCOPermissions permissions];
//    permissions.deleteAccess = QBCOPermissionsAccessOpenForUsersIDs;
//    permissions.usersIDsForDeleteAccess = (NSMutableArray *)@[@(currentUser.ID), @(userID)];
//    object.permissions = permissions;
    [QBCustomObjects createObject:object delegate:self];
}


- (void)saveMessageToHistory:(QBChatMessage *)message withUserID:(NSUInteger)userID
{
    NSString *senderID = [@(message.senderID) stringValue];;
    NSString *recipientID = [@(message.recipientID) stringValue];;
    NSString *txtMessage = message.text;
    NSString *txtTime = [NSDate stringFromDate:message.datetime];
    NSString *txtImageID = @"0";
    NSString *isVideo = @"0";
    NSString *isYTVideo = @"0";
    NSString *txtVideoID = @"empty";
    NSString *txtDestructer;
    if ([message.customParameters objectForKey:kDestructTime] != nil) {
        txtDestructer = [message.customParameters objectForKey:kDestructTime];
    } else {
        txtDestructer = @"0";
    }
    
    QBCOCustomObject *object = [ QBCOCustomObject customObject];
    object.className = kChatClass;
    [object.fields setObject:senderID forKey:@"senderID"];
    [object.fields setObject:recipientID forKey:@"recipientID"];
    [object.fields setObject:txtMessage forKey:@"chatMessage"];
    [object.fields setObject:txtTime forKey:@"chatTime"];
    [object.fields setObject:txtImageID forKey:@"chatImageID"];
    [object.fields setObject:txtDestructer forKey:@"destructer"];
    [object.fields setObject:isYTVideo forKey:@"isYoutubeVideo"];
    [object.fields setObject:isVideo forKey:@"isVideo"];
    [object.fields setObject:txtVideoID forKey:@"videoID"];

//    QBCOPermissions *permissions = [QBCOPermissions permissions];
//    permissions.deleteAccess = QBCOPermissionsAccessOpenForUsersIDs;
//    permissions.usersIDsForDeleteAccess = (NSMutableArray *)@[@(currentUser.ID), @(userID)];
//    object.permissions = permissions;
    [QBCustomObjects createObject:object delegate:self];
}

- (void)messageHistoryWithUserID:(NSUInteger)oppID {
    [[NSUserDefaults standardUserDefaults] setObject:[@(oppID) stringValue] forKey:kOpponentID];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [QBCustomObjects objectsWithClassName:kChatClass delegate:self];
}

- (void)receiveChat:(NSUInteger)userID {
    [QBCustomObjects objectsWithClassName:kChatClass delegate:self];
}

- (void)clearChatHistoryWithUserID:(NSMutableArray *)deleteIDsArray {
    [QBCustomObjects deleteObjectsWithIDs:deleteIDsArray className:kChatClass delegate:self];
}

- (void)clearChatHistoryByRowID:(NSString *)objectID {
    [QBCustomObjects deleteObjectWithID:objectID className:kChatClass delegate:self];
}

- (void)clearChatMessagesOnDestruction:(NSMutableArray *)destructIDsArray {
    [QBCustomObjects deleteObjectsWithIDs:destructIDsArray className:kChatClass delegate:self];
}

- (void) completedWithResult:(Result *)result {
    if(result.success && [result isKindOfClass:QBCOCustomObjectPagedResult.class]){
        
        QBCOCustomObjectPagedResult *objectResult = (QBCOCustomObjectPagedResult *)result;
        NSLog(@"objectResult:%lu",(unsigned long)objectResult.objects.count);
        NSMutableArray *chatArray = [NSMutableArray array];
        NSMutableArray *dataQBArray = [NSMutableArray array];
        QBCOCustomObject *objectDict;
        for (objectDict in objectResult.objects) {
            NSLog(@"objectDict:%@",objectDict);
            NSString *strSender = objectDict.fields[@"senderID"];
            NSString *strRecipient =  objectDict.fields[@"recipientID"];
            NSString *strMessage =  objectDict.fields[@"chatMessage"];
            NSString *strTime =  objectDict.fields[@"chatTime"];
            NSString *strImgID =  objectDict.fields[@"chatImageID"];
            NSString *strIsVid =  objectDict.fields[@"isVideo"];
            NSString *strIsYTVid =  objectDict.fields[@"isYoutubeVideo"];
            NSString *strVidID =  objectDict.fields[@"videoID"];
            NSString *strDestructer =  objectDict.fields[@"destructer"];
            NSString *strDeleteID =  objectDict.ID;

            NSString *chkUserID = [@(self.currentUser.ID) stringValue];
            NSString *chkOpponentID = [[NSUserDefaults standardUserDefaults] objectForKey:kOpponentID];
            
            NSDictionary *dict;
            if (([strSender isEqual:chkUserID] && [strRecipient isEqual:chkOpponentID])  ||  ([strSender isEqual:chkOpponentID] && [strRecipient isEqual:chkUserID])) {
                
                dict = [[NSDictionary alloc] initWithObjectsAndKeys:strSender,@"Sender",strRecipient,@"Recipient",strMessage,@"TxtMessage",strTime,@"Time",strImgID,@"ImageID",strIsVid,@"IsVid",strIsYTVid,@"IsYTVid",strVidID,@"VideoID",strDestructer,@"Destruction",strDeleteID,@"DeleteID", nil];
                [dataQBArray addObject:dict];
            }
        }
        

        for (int i = 0; i < [dataQBArray count]; i++) {
            QBChatMessage *chatMessage = [[QBChatMessage alloc] init];
            [chatMessage setSenderID:[dataQBArray[i][@"Sender"] intValue]];
            [chatMessage setRecipientID:[dataQBArray[i][@"Recipient"] intValue]];
            [chatMessage setText:dataQBArray[i][@"TxtMessage"]];
            [chatMessage setDatetime:[NSDate dateFromString:dataQBArray[i][@"Time"]]];
            
            if ([dataQBArray[i][@"ImageID"] isEqual:@"0"]  && ![dataQBArray[i][@"TxtMessage"] isEqual:@""]) {
                [chatMessage setCustomParameters:(NSMutableDictionary *)@{@"destructID": dataQBArray[i][@"Destruction"],@"deleteID": dataQBArray[i][@"DeleteID"]}];
                [chatArray addObject:chatMessage];
            }
            else {
                if ([dataQBArray[i][@"IsVid"] isEqual:@"1"]) {
                    if ([dataQBArray[i][@"IsYTVid"] isEqual:@"1"]) {
                        [chatMessage setCustomParameters:(NSMutableDictionary *)@{@"fileID": @([dataQBArray[i][@"ImageID"] integerValue]),@"destructID": dataQBArray[i][@"Destruction"],@"deleteID": dataQBArray[i][@"DeleteID"],@"video": @"YES",@"isYouTubeVideo": @"YES",@"videoID": dataQBArray[i][@"VideoID"]}];
                    } else {
                        [chatMessage setCustomParameters:(NSMutableDictionary *)@{@"fileID": @([dataQBArray[i][@"ImageID"] integerValue]),@"destructID": dataQBArray[i][@"Destruction"],@"deleteID": dataQBArray[i][@"DeleteID"],@"video": @"YES"}];
                    }
                } else {
                    [chatMessage setCustomParameters:(NSMutableDictionary *)@{@"fileID": @([dataQBArray[i][@"ImageID"] integerValue]),@"destructID": dataQBArray[i][@"Destruction"],@"deleteID": dataQBArray[i][@"DeleteID"]}];
                }
                NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                [dict setObject:dataQBArray[i][@"ImageID"] forKey:@"image"];
                [dict setObject:chatMessage forKey:kMessage];
                [dict setObject:[NSDate dateFromString:dataQBArray[i][@"Time"]] forKey:kDate];
                [chatArray addObject:dict];
            }
        }
        [chatDelegate historyWithUserID:chatArray];
        
    } else if (result.success && [result isKindOfClass:QBCOCustomObjectResult.class]) {
        
            QBCOCustomObjectResult *updateObjectResult = (QBCOCustomObjectResult *)result;
            NSLog(@"Object: %@", updateObjectResult.object);
            [QBCustomObjects objectsWithClassName:kChatClass delegate:self];
        
    } else if (result.success && [result isKindOfClass:QBCOMultiDeleteResult.class]) {
        
            QBCOMultiDeleteResult *res = (QBCOMultiDeleteResult *)result;
            NSLog(@"QBCOMultiDeleteResult, deletedObjectsIDs: %@, notFoundObjectsIDs: %@, wrongPermissionsObjectsIDs: %@",
                  res.deletedObjectsIDs, res.notFoundObjectsIDs, res.wrongPermissionsObjectsIDs);
            [QBCustomObjects objectsWithClassName:kChatClass delegate:self];

    } else{
            NSLog(@"errors=%@", result.errors);
    }
}

@end
