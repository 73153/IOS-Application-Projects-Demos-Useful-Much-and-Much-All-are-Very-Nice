//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "TapView.h"

@class TapNetworkImageView;

@interface KippyPhoto : TapView<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>  {
  TapNetworkImageView* photo;
  UIActivityIndicatorView* spinner;
}

- (id)initWithWhiteMask:(BOOL)whiteMask;
-(void)setup:(NSDictionary*)info;


@end
