//
// Copyright (c) 2013 Gleb Pinigin (https://github.com/gpinigin)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "GPCopyActivity.h"

NSString *const GPActivityCopy = @"GPActivityCopy";

@implementation GPCopyActivity

- (id)init {
    self = [super init];
    if (self) {
        self.title = NSLocalizedStringFromTable(@"ACTIVITY_COPY", @"GPActivityViewController", @"Copy");
        self.image = [UIImage imageNamed:@"GPActivityViewController.bundle/shareCopy"];
    }
    
    return self;
}

#pragma mark - 

+ (GPActivityCategory)activityCategory {
    return GPActivityCategoryAction;
}

- (NSString *)activityType {
    return GPActivityCopy;
}

- (void)performActivity {
    NSString *text = [self.userInfo objectForKey:@"text"];
    UIImage *image = [self.userInfo objectForKey:@"image"];
    NSURL *url = [self.userInfo objectForKey:@"url"];
    
    if (text) {
        [UIPasteboard generalPasteboard].string = text;
    }
    
    if (url) {
        [UIPasteboard generalPasteboard].URL = url;
    }
    
    if (image) {
        NSData *imageData = UIImageJPEGRepresentation(image, 0.75f);
        [[UIPasteboard generalPasteboard] setData:imageData
                                forPasteboardType:[UIPasteboardTypeListImage objectAtIndex:0]];
    }
    
    [self activityDidFinish:YES];
}

@end
