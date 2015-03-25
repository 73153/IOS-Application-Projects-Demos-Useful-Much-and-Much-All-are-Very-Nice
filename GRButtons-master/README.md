# GRButtons

- create social network buttons without any image
- easy to embed into any project, two files are needed
- example project included
- ARC compatible

Avaliable buttons:
- Facebook
- Twitter
- Google+
- Pinterest
- Dribble
- Flickr
- Email

<img src="https://raw.github.com/goncz9/GRButtons/master/buttons_screenshot.png" alt="GRButtons" title="GRButtons" style="display:block; margin: 10px auto 30px auto;" class="center">

## Usage

- add&import `QuartzCore` framework to your project
- add `GRButtons.h` and `GRButons.m` to your project
- import `GRButtons.h`

# Examples:

Simple UIButton:
``` objective-c
	[self.view addSubview:GRButton(GRTypeMailRect, 10, 160, 32, self, @selector(action:), [UIColor grayColor], GRStyleIn)];
```
UIBarButtonItem:
``` objective-c
	UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithCustomView:GRButton(GRTypeTwitter, 0, 0, 64, self, @selector(action:), color, GRStyleIn)];
```	
## License (MIT)
Copyright (c) 2012 Robert Goncz

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
