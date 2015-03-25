//
//  PTEConsoleLogger.h
//  LumberjackConsole
//
//  Created by Ernesto Rivera on 2013/05/23.
//  Copyright (c) 2013.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import <CocoaLumberjack/DDLog.h>

/**
 A DDLogger that displays log messages with a searcheable UITableView.
 
 - Supports colors for log levels.
 - Expands and collapses text.
 - Can be filtered according to log levels or text.
 - Can be minimized, maximized or used in any size in between.
 
 @note You don't need to use this class directly but instead use
 [DDLog addLogger:[PTEDashboard sharedDashboard].logger] or [NBULog addDashboardLogger].
 */
@interface PTEConsoleLogger : DDAbstractLogger <UITableViewDelegate,
                                                UITableViewDataSource,
                                                UISearchBarDelegate>

/// @name Getting the Logger

/// Set the maximum number of messages to be displayed on the Dashboard. Default `100`.
@property (nonatomic)                   NSUInteger maxMessages;

/// @name Outlets

/// The UITableView used to display log messages.
@property (weak, nonatomic) IBOutlet    UITableView * tableView;

/// The UISearchBar used to filter log messages.
@property (weak, nonatomic) IBOutlet    UISearchBar * searchBar;

@end

