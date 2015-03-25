//
//  Utility.h
//  Chanda
//
//  Created by Mohammad Azam on 10/25/11.
//  Copyright (c) 2011 HighOnCoding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h" 

@interface Utility : NSObject
{
    
}

+(NSString *) getDatabasePath; 
+(void) showAlert:(NSString *) title message:(NSString *) msg; 

@end
