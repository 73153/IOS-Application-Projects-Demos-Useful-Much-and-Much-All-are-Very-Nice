//
//  FriendsViewCell.m
//  Holaout
//
//  Created by Amit Parmar on 23/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "FriendsViewCell.h"

@implementation FriendsViewCell

@synthesize imgView;
@synthesize lblname;
@synthesize txtViewLocation;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
