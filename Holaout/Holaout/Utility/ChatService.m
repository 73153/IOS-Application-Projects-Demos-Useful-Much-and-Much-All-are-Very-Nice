//
//  ChatService.m
//  sample-chat
//
//  Created by Igor Khomenko on 10/21/13.
//  Copyright (c) 2013 Igor Khomenko. All rights reserved.
//

#import "ChatService.h"

typedef void(^CompletionBlock)();
typedef void(^JoinRoomCompletionBlock)(QBChatRoom *);
typedef void(^CompletionBlockWithResult)(NSArray *);

@interface ChatService () <QBChatDelegate,QBActionStatusDelegate>

@property (copy) QBUUser *currentUser;
@property (retain) NSTimer *presenceTimer;

@property (copy) CompletionBlock loginCompletionBlock;
@property (copy) JoinRoomCompletionBlock joinRoomCompletionBlock;
@property (copy) CompletionBlockWithResult requestRoomsCompletionBlock;

@end


@implementation ChatService

+ (instancetype)instance{
    static id instance_ = nil;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance_ = [[self alloc] init];
	});
	
	return instance_;
}

- (id)init{
    self = [super init];
    if(self){
        [QBChat instance].delegate = self;
    }
    return self;
}

- (void)loginWithUser:(QBUUser *)user completionBlock:(void(^)())completionBlock{
    self.loginCompletionBlock = completionBlock;
    
    self.currentUser = user;
    
    [[QBChat instance] loginWithUser:user];
}

- (void)sendMessage:(QBChatMessage *)message{
    [[QBChat instance] sendMessage:message];
}

- (void)sendMessage:(NSString *)message toRoom:(QBChatRoom *)chatRoom{
    [[QBChat instance] sendMessage:message toRoom:chatRoom];
}

- (void)createOrJoinRoomWithName:(NSString *)roomName completionBlock:(void(^)(QBChatRoom *))completionBlock{
    self.joinRoomCompletionBlock = completionBlock;
    
    [[QBChat instance] createOrJoinRoomWithName:roomName membersOnly:NO persistent:YES];
}

- (void)joinRoom:(QBChatRoom *)room completionBlock:(void(^)(QBChatRoom *))completionBlock{
    self.joinRoomCompletionBlock = completionBlock;
    
    [[QBChat instance] joinRoom:room];
}

- (void)leaveRoom:(QBChatRoom *)room{
    [[QBChat instance] leaveRoom:room];
}

- (void)requestRoomsWithCompletionBlock:(void(^)(NSArray *))completionBlock{
    self.requestRoomsCompletionBlock = completionBlock;
    
    [[QBChat instance]  requestAllRooms];
}


#pragma mark
#pragma mark QBChatDelegate

- (void)chatDidLogin{
    // Start sending presences
    [self.presenceTimer invalidate];
    self.presenceTimer = [NSTimer scheduledTimerWithTimeInterval:30
                                     target:[QBChat instance] selector:@selector(sendPresence)
                                   userInfo:nil repeats:YES];
    
    if(self.loginCompletionBlock != nil){
        self.loginCompletionBlock();
        self.loginCompletionBlock = nil;
    }
}

- (void)chatDidFailWithError:(int)code{
    // relogin here
    [[QBChat instance] loginWithUser:self.currentUser];
}

- (void)chatRoomDidEnter:(QBChatRoom *)room{
    self.joinRoomCompletionBlock(room);
    self.joinRoomCompletionBlock = nil;
    
    // To be able to edit rooms, created by API users, in Admin panel - just add Admin user ID to room
    [room addUsers:@[@(291)]];
}

- (void)chatDidReceiveListOfRooms:(NSArray *)rooms{
    self.requestRoomsCompletionBlock(rooms);
    self.requestRoomsCompletionBlock = nil;
}

- (void)chatDidReceiveMessage:(QBChatMessage *)message{
    NSUInteger fileID = [message.customParameters[@"fileID"] integerValue];
    if(fileID != 0){
        [self playNotificationSound];
//        [[LocalStorageService shared] saveImageToHistory:[NSDictionary dictionaryWithObjectsAndKeys:message,kMessage,[NSString stringWithFormat:@"%d",fileID],@"image", nil] withUserID:message.senderID];
        [[LocalStorageService shared] receiveChat:message.senderID];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationDidReceiveNewMessage
                                                            object:nil userInfo:@{kMessage: message,@"image":[NSString stringWithFormat:@"%d",fileID]}];
    }
    else{
        [self playNotificationSound];
//        [[LocalStorageService shared] saveMessageToHistory:message withUserID:message.senderID];
        [[LocalStorageService shared] receiveChat:message.senderID];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationDidReceiveNewMessage
                                                            object:nil userInfo:@{kMessage: message}];
    }
}

- (void)chatRoomDidReceiveMessage:(QBChatMessage *)message fromRoom:(NSString *)roomName{
    // play sound notification
    [self playNotificationSound];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationDidReceiveNewMessageFromRoom
                                                        object:nil userInfo:@{kMessage: message, kRoomName: roomName}];
}


#pragma mark
#pragma mark Additional

static SystemSoundID soundID;
- (void)playNotificationSound
{
    if(soundID == 0){
        NSString *path = [NSString stringWithFormat: @"%@/sound.mp3", [[NSBundle mainBundle] resourcePath]];
        NSURL *filePath = [NSURL fileURLWithPath: path isDirectory: NO];

        AudioServicesCreateSystemSoundID((__bridge CFURLRef)filePath, &soundID);
    }
    
    AudioServicesPlaySystemSound(soundID);
}

@end
