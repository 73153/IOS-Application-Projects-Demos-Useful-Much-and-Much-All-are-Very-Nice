//
//  ChatMessageTableViewCell.m
//  sample-chat
//
//  Created by Igor Khomenko on 10/19/13.
//  Copyright (c) 2013 Igor Khomenko. All rights reserved.
//

#import "ChatMessageTableViewCell.h"
#import "ImageViewController.h"

#define padding 20

@implementation ChatMessageTableViewCell

@synthesize btnImage;
@synthesize activityIndicator;
@synthesize isVideo;
@synthesize isYTVideo;

static NSDateFormatter *messageDateFormatter;
static UIImage *orangeBubble;
static UIImage *aquaBubble;

+ (void)initialize{
    [super initialize];
    
    // init message datetime formatter
    messageDateFormatter = [[NSDateFormatter alloc] init];
    [messageDateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    // init bubbles
    orangeBubble = [[UIImage imageNamed:@"orange.png"] stretchableImageWithLeftCapWidth:24  topCapHeight:15];
    aquaBubble = [[UIImage imageNamed:@"aqua.png"] stretchableImageWithLeftCapWidth:24  topCapHeight:15];
}

+ (CGFloat)heightForCellWithMessage:(QBChatMessage *)message is1To1Chat:(BOOL)is1To1Chat
{
//    // Replace the next line with these lines if you would like to connect to Web XMPP Chat widget
//    //
//    NSString *text;
//    if(!is1To1Chat){
//        NSString *unescapedMessage = [CharactersEscapeService unescape:message.text];
//        NSData *messageAsData = [unescapedMessage dataUsingEncoding:NSUTF8StringEncoding];
//        NSError *error;
//        NSMutableDictionary *messageAsDictionary = [NSJSONSerialization JSONObjectWithData:messageAsData options:NSJSONReadingAllowFragments error:&error];
//        text = messageAsDictionary[@"message"];
//    }else{
//        text = message.text;
//    }
    
    NSString *text = message.text;

    
	CGSize  textSize = {260.0, 10000.0};
	CGSize size = [text sizeWithFont:[UIFont boldSystemFontOfSize:13]
                   constrainedToSize:textSize
                       lineBreakMode:NSLineBreakByWordWrapping];
    
	
	size.height += 45.0;
	return size.height;

}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.dateLabel = [[UILabel alloc] init];
        [self.dateLabel setFrame:CGRectMake(10, 5, 300, 20)];
        [self.dateLabel setFont:[UIFont systemFontOfSize:11.0]];
        [self.dateLabel setTextColor:[UIColor lightGrayColor]];
        [self.dateLabel setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:self.dateLabel];
        
        self.backgroundImageView = [[UIImageView alloc] init];
        [self.backgroundImageView setFrame:CGRectZero];
        [self.backgroundImageView setBackgroundColor:[UIColor clearColor]];
		[self.contentView addSubview:self.backgroundImageView];
        [self.contentView setBackgroundColor:[UIColor clearColor]];
        [self setBackgroundColor:[UIColor clearColor]];
        
		self.messageTextView = [[UITextView alloc] init];
        [self.messageTextView setBackgroundColor:[UIColor clearColor]];
        [self.messageTextView setEditable:NO];
        [self.messageTextView setScrollEnabled:NO];
		[self.messageTextView sizeToFit];
        [self.messageTextView setBackgroundColor:[UIColor clearColor]];
		[self.contentView addSubview:self.messageTextView];
        
        self.btnImage = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.btnImage];
        [btnImage setUserInteractionEnabled:NO];
        if(self.activityIndicator){
            self.activityIndicator = nil;
        }
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [activityIndicator setColor:[UIColor blackColor]];
        [activityIndicator setFrame:CGRectMake(0,0,40,40)];
//        [self.activityIndicator setHidesWhenStopped:YES];
        [self.contentView addSubview:activityIndicator];
    }
    return self;
}

- (UIImage*)loadImage:(NSString *)uid {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *yourArtPath = [NSString stringWithFormat:@"%@/%@.mp4",documentsDirectory,uid];
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:yourArtPath] options:nil];
    AVAssetImageGenerator *generate = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    NSError *err = NULL;
    CMTime time = CMTimeMake(1, 60);
    CGImageRef imgRef = [generate copyCGImageAtTime:time actualTime:NULL error:&err];
    NSLog(@"err==%@, imageRef==%@", err, imgRef);
    return [[UIImage alloc] initWithCGImage:imgRef];
    
}

- (void)completedWithResult:(Result *)result{
    // Download file result
     [activityIndicator stopAnimating];
    if(result.success && [result isKindOfClass:QBCFileDownloadTaskResult.class]){
        // extract image
        QBCFileDownloadTaskResult *res = (QBCFileDownloadTaskResult *)result;
        if(isVideo){
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *yourArtPath = [NSString stringWithFormat:@"%@/%d.mp4",documentsDirectory,res.blob.ID];
            [res.file writeToFile:yourArtPath atomically:YES];
            [btnImage setImage:[self loadImage:[NSString stringWithFormat:@"%d",res.blob.ID]] forState:UIControlStateNormal];
            [btnImage setTag:102];
            isVideo = false;
        } else if (isYTVideo) {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *yourArtPath = [NSString stringWithFormat:@"%@/%d.png",documentsDirectory,res.blob.ID];
            [res.file writeToFile:yourArtPath atomically:YES];
            [btnImage setImage:[UIImage imageWithData:res.file] forState:UIControlStateNormal];
            [btnImage setTag:102];
            isYTVideo = false;
        } else {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *yourArtPath = [NSString stringWithFormat:@"%@/%d.png",documentsDirectory,res.blob.ID];
            [res.file writeToFile:yourArtPath atomically:YES];
            
            UIImage *image = [UIImage imageWithData:res.file];
            [btnImage setImage:image forState:UIControlStateNormal];
        }
        
    }else{
        NSLog(@"Errors=%@", result.errors);
    }
}

- (void) downloadImageWithID:(NSNumber *)imageId{
    isVideo = false;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *yourArtPath = [NSString stringWithFormat:@"%@/%d.png",documentsDirectory,[imageId intValue]];
    if([[NSFileManager defaultManager] fileExistsAtPath:yourArtPath isDirectory:NO]){
        [activityIndicator stopAnimating];
        UIImage *image = [UIImage imageWithContentsOfFile:yourArtPath];
        [btnImage setImage:image forState:UIControlStateNormal];
    }
    else{
        [activityIndicator startAnimating];
       [QBContent TDownloadFileWithBlobID:[imageId intValue] delegate:self];
    }
}

- (void) downloadVideoWithID:(NSNumber *)imageId{
    NSUInteger uid = [imageId intValue];
    isVideo = true;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *yourArtPath = [NSString stringWithFormat:@"%@/%@.mp4",documentsDirectory,[NSString stringWithFormat:@"%d",uid]];
    if([[NSFileManager defaultManager] fileExistsAtPath:yourArtPath]){
        [activityIndicator stopAnimating];
        UIImage *image = [self loadImage:[NSString stringWithFormat:@"%d",uid]];
        [btnImage setImage:image forState:UIControlStateNormal];
        [btnImage setTag:102];
        isVideo = false;
    }
    else{
       [QBContent TDownloadFileWithBlobID:[imageId intValue] delegate:self];
    }
}

- (void) downloadYTVideoWithID:(NSNumber *)imageId{
    NSUInteger uid = [imageId intValue];
    isYTVideo = true;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *yourArtPath = [NSString stringWithFormat:@"%@/%d.png",documentsDirectory,uid];
    if([[NSFileManager defaultManager] fileExistsAtPath:yourArtPath]){
        [activityIndicator stopAnimating];
        UIImage *image = [UIImage imageWithContentsOfFile:yourArtPath];
        [btnImage setImage:image forState:UIControlStateNormal];
        [btnImage setTag:102];
        isYTVideo = false;
    }
    else{
        [QBContent TDownloadFileWithBlobID:[imageId intValue] delegate:self];
    }
}

- (void)configureCellWithDictionary:(NSDictionary *)dictionary is1To1Chat:(BOOL)is1To1Chat  opponent:(NSString *)oppName
{
    NSLog(@"dictionary=%@",dictionary);
    QBChatMessage *message = [dictionary objectForKey:kMessage];
    NSString *video = message.customParameters[@"video"];
    int imageId = [dictionary[@"image"] intValue];
    [self.activityIndicator startAnimating];
    
    if(video){
        if (message.customParameters[@"isYouTubeVideo"]) {
            [self performSelector:@selector(downloadYTVideoWithID:) withObject:[NSNumber numberWithInt:imageId]];
        } else {
            [self performSelector:@selector(downloadVideoWithID:) withObject:[NSNumber numberWithInt:imageId]];
        }
    }
    else{
       [self performSelector:@selector(downloadImageWithID:) withObject:[NSNumber numberWithInt:imageId] afterDelay:0.5];
    }
    
    NSString *time = [messageDateFormatter stringFromDate:message.datetime];
    // Left/Right bubble
    if ([LocalStorageService shared].currentUser.ID == message.senderID) {
        self.dateLabel.textAlignment = NSTextAlignmentLeft;
        self.dateLabel.text = [NSString stringWithFormat:@"%@ %@", [[LocalStorageService shared].currentUser login], time];
        [self.btnImage setFrame:CGRectMake(20,20,50,50)];
        [activityIndicator setCenter:self.btnImage.center];
        [self.contentView bringSubviewToFront:activityIndicator];
        
    } else {
        self.dateLabel.textAlignment = NSTextAlignmentRight;
        self.dateLabel.text = [NSString stringWithFormat:@"%@ %@", oppName, time];
        [self.btnImage setFrame:CGRectMake(self.frame.size.width-60,20,50,50)];
        [self.activityIndicator setCenter:self.btnImage.center];
        [self.btnImage bringSubviewToFront:self.activityIndicator];
    }
}


- (void)configureCellWithMessage:(QBChatMessage *)message is1To1Chat:(BOOL)is1To1Chat  opponent:(NSString *)oppName
{
    // set message
    
//    // Replace the next line with these lines if you would like to connect to Web XMPP Chat widget
//    //
//    if(!is1To1Chat){
//        NSString *unescapedMessage = [CharactersEscapeService unescape:message.text];
//        NSData *messageAsData = [unescapedMessage dataUsingEncoding:NSUTF8StringEncoding];
//        NSError *error;
//        NSMutableDictionary *messageAsDictionary = [NSJSONSerialization JSONObjectWithData:messageAsData options:NSJSONReadingAllowFragments error:&error];
//        self.messageTextView.text = messageAsDictionary[@"message"];
//    }else{
//        self.messageTextView.text = message.text;
//    }
    
    self.messageTextView.text = message.text;
    
    
    CGSize textSize = { 260.0, 10000.0 };
    
	CGSize size = [self.messageTextView.text sizeWithFont:[UIFont boldSystemFontOfSize:13]
                                        constrainedToSize:textSize
                                            lineBreakMode:NSLineBreakByWordWrapping];
    
	size.width += 10;
    
    NSString *time = [messageDateFormatter stringFromDate:message.datetime];
    // Left/Right bubble
    NSLog(@"%d",[LocalStorageService shared].currentUser.ID);
    NSLog(@"%d",message.senderID);
    if ([LocalStorageService shared].currentUser.ID == message.senderID) {
        [self.messageTextView setFrame:CGRectMake(padding, padding+5, size.width, size.height+padding)];
        [self.messageTextView sizeToFit];
        
        [self.backgroundImageView setFrame:CGRectMake(padding/2, padding+5,
                                                      self.messageTextView.frame.size.width+padding/2, self.messageTextView.frame.size.height+5)];
        self.backgroundImageView.image = orangeBubble;
        
        self.dateLabel.textAlignment = NSTextAlignmentLeft;
        self.dateLabel.text = [NSString stringWithFormat:@"%@ %@", [[LocalStorageService shared].currentUser login], time];
        
    } else {
        [self.messageTextView setFrame:CGRectMake(320-size.width-padding/2, padding+5, size.width, size.height+padding)];
        [self.messageTextView sizeToFit];
        
        [self.backgroundImageView setFrame:CGRectMake(320-size.width-padding/2, padding+5,
                                                      self.messageTextView.frame.size.width+padding/2, self.messageTextView.frame.size.height+5)];
        self.backgroundImageView.image = aquaBubble;
        
        self.dateLabel.textAlignment = NSTextAlignmentRight;
        self.dateLabel.text = [NSString stringWithFormat:@"%@ %@", oppName, time];
    }
}

@end
