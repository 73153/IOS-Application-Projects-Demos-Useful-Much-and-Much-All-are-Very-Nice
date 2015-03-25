//
//  ChatMessageTableViewCell.h
//  sample-chat
//
//  Created by Igor Khomenko on 10/19/13.
//  Copyright (c) 2013 Igor Khomenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatMessageTableViewCell : UITableViewCell<QBActionStatusDelegate>

@property (nonatomic, strong) UITextView  *messageTextView;
@property (nonatomic, strong) UILabel     *dateLabel;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIButton *btnImage;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic) BOOL isVideo;
@property (nonatomic) BOOL isYTVideo;

+ (CGFloat)heightForCellWithMessage:(QBChatMessage *)message is1To1Chat:(BOOL)is1To1Chat;
- (void)configureCellWithMessage:(QBChatMessage *)message is1To1Chat:(BOOL)is1To1Chat  opponent:(NSString *)oppName;
- (void)configureCellWithDictionary:(NSDictionary *)dictionary is1To1Chat:(BOOL)is1To1Chat  opponent:(NSString *)oppName;
@end
