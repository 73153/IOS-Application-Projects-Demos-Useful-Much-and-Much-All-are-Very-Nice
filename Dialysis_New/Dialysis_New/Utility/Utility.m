//
//  Utility.m
//  Chanda
//
//  Created by Mohammad Azam on 10/25/11.
//  Copyright (c) 2011 HighOnCoding. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+(NSString *) getDatabasePath
{
     NSString *databasePath = [(AppDelegate *)[[UIApplication sharedApplication] delegate] databasePath];
    
    return databasePath; 
}

+(void) showAlert:(NSString *)title message:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];

    [alert show];
}

@end
