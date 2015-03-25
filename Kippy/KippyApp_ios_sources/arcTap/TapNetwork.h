//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface TapNetwork : NSObject {
  NSMutableArray* observers;
}

-(void)registerDownload:(ASIHTTPRequest*)request sender:(NSObject*)sender;
-(void)downloadResource:(NSString*)url sender:(NSObject*)sender;
-(void)downloadResourceToPath:(NSString*)url sender:(NSObject*)sender path:(NSString*)path;
-(void)cancelDownloadResource:(NSObject*)sender;

@end
