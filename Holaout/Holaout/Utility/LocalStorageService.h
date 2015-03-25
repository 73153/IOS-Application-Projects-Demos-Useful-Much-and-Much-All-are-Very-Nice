//
//  LocalStorageService.h
//  sample-chat
//
//  Created by Igor Khomenko on 10/16/13.
//  Copyright (c) 2013 Igor Khomenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol chatDelegate <NSObject>
-(void)historyWithUserID:(NSMutableArray *)dataArray;
@end

@interface LocalStorageService : NSObject <QBActionStatusDelegate>

@property (nonatomic) id<chatDelegate> chatDelegate;
@property (nonatomic, strong) QBUUser *currentUser;

+ (instancetype)shared;
- (void)receiveChat:(NSUInteger)userID;
- (void)saveMessageToHistory:(QBChatMessage *)message withUserID:(NSUInteger)userID;
- (void)messageHistoryWithUserID:(NSUInteger)oppID;
- (void)saveImageToHistory:(NSDictionary *)message withUserID:(NSUInteger)userID;
- (void)clearChatHistoryWithUserID:(NSMutableArray *)deleteIDsArray;
- (void)clearChatHistoryByRowID:(NSString *)objectID;
- (void)clearChatMessagesOnDestruction:(NSMutableArray *)destructIDsArray;

@end
