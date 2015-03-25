//
//  PSTableViewController.h
//  PSFilePickerController
//
//  Created by Josh Kugelmann on 18/08/12.
//  Copyright (c) 2012 Josh Kugelmann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSDirectoryListViewController : UITableViewController <UIAlertViewDelegate> {
    NSString *_path;
    NSArray *_files;
}

@property (nonatomic, copy) NSString *path;
@property (nonatomic, retain) NSArray *files;

- (PSDirectoryListViewController *)initWithDirectoryAtPath:(NSString *)aPath;
- (void)rebuildFileList;
- (void)newFolderButtonTapped;

@end
