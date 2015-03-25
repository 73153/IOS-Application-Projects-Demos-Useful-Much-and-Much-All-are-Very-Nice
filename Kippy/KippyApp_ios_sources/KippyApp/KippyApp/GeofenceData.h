//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GeofenceData : NSObject {
  BOOL isLoad;
  BOOL isBusy;
}

-(void)saveData;
-(void)loadData;
-(void)deleteData;

@end
