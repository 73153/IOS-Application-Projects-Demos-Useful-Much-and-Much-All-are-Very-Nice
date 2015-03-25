//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "TapUtils.h"
#import "AppDelegate.h"
#import <CommonCrypto/CommonDigest.h>
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation TapUtils

+(void)showAvailableFonts {
  for(NSString* familyName in [UIFont familyNames])
    for(NSString* name in [UIFont fontNamesForFamilyName:familyName]) {
      NSLog(@"%@", name);
    }
}

+(NSString*)retina {
  if (IS_RETINA) {
    return @"@2x";
  }
  return @"";
}

+(NSString*)machine {
  NSString *machine;
  size_t size;
  sysctlbyname("hw.machine", NULL, &size, NULL, 0);
  char *name = malloc(size);
  sysctlbyname("hw.machine", name, &size, NULL, 0);
  machine = [NSString stringWithUTF8String:name];
  free(name);
  return machine;
}

+(NSString*)date2string:(NSDate*)date format:(NSString*)format locale:(NSString*)locale {
  NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:locale]];
  [dateFormatter setDateFormat:format];
  NSString* string = [dateFormatter stringFromDate:date];
  return string;
}

+(NSDate*)string2date:(NSString*)string format:(NSString*)format locale:(NSString*)locale {
  NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:locale]];
  [dateFormatter setDateFormat:format];
  NSDate* date = [dateFormatter dateFromString:string];
  return date;
}

+(NSDate*)monday {
  NSDate* today = [NSDate date];
  NSDateComponents* components = [[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:today];
  int weekday = (int)[components weekday];
  return [TapUtils dateByAddingDays:today days:-weekday+2];
}

+(NSDate*)dateByAddingDays:(NSDate*)date days:(int)n {
  NSDateComponents *components = [[NSDateComponents alloc] init];
  [components setDay:n];
  NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
  return [gregorian dateByAddingComponents:components toDate:date options:0];
}

+(NSString*)documentDirectory {
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  return [[NSString alloc] initWithString:[paths objectAtIndex:0]];
}

+ (NSString*)md5:(NSString*)string {
  if(string != nil) {
    const char* str = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (int)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
      [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
  } else
    return nil;
}

+(void)playSound:(NSString*)resource ofType:(NSString*)ofType {
  AppDelegate* app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  [app playSound:resource ofType:ofType];
}

@end
