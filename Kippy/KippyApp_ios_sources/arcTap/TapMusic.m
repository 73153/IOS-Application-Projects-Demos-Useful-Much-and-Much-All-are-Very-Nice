//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "TapMusic.h"

@implementation TapMusic

- (id)initWithName:(NSString*)name {
  self = [super init];
  if (self) {
    NSURL* url = [[NSBundle mainBundle] URLForResource:name withExtension:@"mp3"];
    music = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [music play];
    music.numberOfLoops = -1;
    soundId = 0;
  }
  return self;
}

- (id)initWithName:(NSString*)name numberOfLoops:(int)n {
  self = [self initWithName:name];
  if (self) {
    music.numberOfLoops = n;
  }
  return self;
}

-(void)playSound:(NSString*)name {
  if(soundId != 0) {
    AudioServicesDisposeSystemSoundID(soundId);
  }
  NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"mp3"];
  NSURL *url = [NSURL fileURLWithPath:path];
  SystemSoundID soundID;
  AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
  AudioServicesPlaySystemSound(soundID);
}

-(void)dealloc {
  if(soundId != 0) {
    AudioServicesDisposeSystemSoundID(soundId);
  }
  [music stop];
}

@end
