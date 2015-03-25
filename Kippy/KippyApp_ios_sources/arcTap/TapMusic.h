//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "TapView.h"
#import <AVFoundation/AVFoundation.h>

@interface TapMusic : TapView {
  AVAudioPlayer* music;
  SystemSoundID soundId;
}

-(id)initWithName:(NSString*)name;
- (id)initWithName:(NSString*)name numberOfLoops:(int)n;
-(void)playSound:(NSString*)name;

@end
