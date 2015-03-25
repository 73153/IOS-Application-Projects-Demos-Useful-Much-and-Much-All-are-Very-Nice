//
// ILBarButtonItem.h
// Version 1.1
// Created by Isaac Lim (isaacl.net) on 1/1/13.
//

// This code is distributed under the terms and conditions of the MIT license.
//
// Copyright (c) 2013 isaacl.net. All rights reserved.
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

#import <UIKit/UIKit.h>

@interface ILBarButtonItem : UIBarButtonItem {
    UIImage *customImage;
    UIImage *customSelectedImage;
    SEL customAction;
}

/**
 * Create and return a new image-based bar button item.
 * @param image The image of the button to show when unselected. Works best with images under 44x44.
 * @param selectedImage The image of the button to show when the button is tapped. Works best with images under 44x44.
 * @param target The target of the selector
 * @param action The selector to perform when the button is tapped
 *
 * @return An instance of the new button to be used like a normal UIBarButtonItem
 */
+ (ILBarButtonItem *)barItemWithImage:(UIImage *)image
                        selectedImage:(UIImage *)selectedImage
                               target:(id)target
                               action:(SEL)action;

/**
 * Create and return a new text-based bar button item (like iOS 7).
 * @param title The title string of the button. These have no length limit,
 * but use wisely.
 * @param themeColor The color of the text, much like an app's "theme" color
   in iOS 7. Note: a gray tint is automatically applied for the "down" state.
 * @param target The target of the selector
 * @param action The selector to perform when the button is tapped
 *
 * @return An instance of the new button to be used like a normal UIBarButtonItem
 */
+ (ILBarButtonItem *)barItemWithTitle:(NSString *)title
                           themeColor:(UIColor *)themeColor
                               target:(id)target
                               action:(SEL)action;

- (void)setCustomImage:(UIImage *)image;
- (void)setCustomSelectedImage:(UIImage *)image;

- (void)setCustomAction:(SEL)action;

@end
