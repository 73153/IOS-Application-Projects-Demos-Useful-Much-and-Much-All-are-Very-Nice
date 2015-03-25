//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "TapView.h"

@interface HeaderView : TapView {
  UIButton* btnBack;
  UIButton* btnSettings;
  UIButton* btnList;
  UILabel* label;
}

- (id)initWithTitle:(NSString*)title;
- (id)initWithKippy:(NSDictionary*)dictionary;

@end
