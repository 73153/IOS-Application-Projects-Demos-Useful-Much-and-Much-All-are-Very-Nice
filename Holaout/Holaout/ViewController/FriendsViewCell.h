//
//  FriendsViewCell.h
//  Holaout
//
//  Created by Amit Parmar on 23/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendsViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *imgView;
@property (nonatomic, strong) IBOutlet UILabel *lblname;
@property (nonatomic, strong) IBOutlet UITextView *txtViewLocation;

@end
