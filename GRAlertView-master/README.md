GRAlertView
===========

GRAlertView is a subclass from UIAlertView with color customization and CoreGraphics animation.

## Screenshots

<img src="https://raw.github.com/goncz9/GRAlertView/master/custom_line.png">
<img src="https://raw.github.com/goncz9/GRAlertView/master/sucess_border.png">
<img src="https://raw.github.com/goncz9/GRAlertView/master/alert.png">


## Features:
- animation
- custom style
- predefined styles
- custom icon (64x64)
- ARC compatible

## Predefinied styles:
- `GRAlertStyleAlert` (red)
- `GRAlertStyleWarning` (yellow)
- `GRAlertStyleSuccess` (green)
- `GRAlertStyleInfo` (blue)

## Customizable:
- 3 background gradient colors (bottom, middle, top)
- line color (for animation)
- label font color, label shadow color, font name

## Usage

- add&import `QuartzCore` framework to your project
- add `GRAlertView.h` and `GRAlertView.m` to your project
- import `GRAlertView.h`

## Examples

Alert with icon:
``` objective-c
    GRAlertView *alert = [[GRAlertView alloc] initWithTitle:@"Alert"
                                                    message:@"Be careful!"
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"OK", nil];
    alert.style = GRAlertStyleAlert;            // set UIAlertView style
    alert.animation = GRAlertAnimationLines;    // set animation type
    [alert setImage:@"alert.png"];              // add icon image
    [alert show];
```
Custom Alert with icon:
``` objective-c
    GRAlertView *alert = [[GRAlertView alloc] initWithTitle:@"Custom Alert"
                                           message:@"Merry Christmas!"
                                          delegate:self
                                 cancelButtonTitle:nil
                                 otherButtonTitles:@"Close", nil];

        [alert setTopColor:[UIColor colorWithRed:0.7 green:0 blue:0 alpha:1]
               middleColor:[UIColor colorWithRed:0.5 green:0 blue:0 alpha:1]
               bottomColor:[UIColor colorWithRed:0.4 green:0 blue:0 alpha:1]
                 lineColor:[UIColor colorWithRed:0.7 green:0 blue:0 alpha:1]];

        [alert setFontName:@"Cochin-BoldItalic"
                 fontColor:[UIColor greenColor]
           fontShadowColor:[UIColor colorWithRed:0.8 green:0 blue:0 alpha:1]];
        
        [alert setImage:@"santa.png"];
        [alert show];
```
## License (MIT)
Copyright (c) 2012 Robert Goncz

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
