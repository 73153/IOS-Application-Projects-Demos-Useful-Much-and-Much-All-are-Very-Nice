# HPLTagCloudGenerator

Create tag clouds on iOS. Algorithm based on http://stackoverflow.com/a/1478314/1454634, using an [Archimedean spiral](http://en.wikipedia.org/wiki/Archimedean_spiral)

### Example

<p align="center">
  <img src="http://i.imgur.com/SEyh5Yq.png" height="50%" width="auto" />
</p>

## Installation

Install from cocoapods:

```
pod 'HPLTagCloudGenerator', '~> 0.0.3'
```

## Usage

```objective-c
dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    // This runs in a background thread

    // dictionary of tags
    NSDictionary *tagDict = @{@"tag1": @3,
                              @"tag2": @5,
                              @"tag3": @7,
                              @"tag4": @2};


    HPLTagCloudGenerator *tagGenerator = [[HPLTagCloudGenerator alloc] init];
    tagGenerator.size = CGSizeMake(self.tagView.frame.size.width, self.tagView.frame.size.height);
    tagGenerator.tagDict = tagDict;

    NSArray *views = [tagGenerator generateTagViews];

    dispatch_async( dispatch_get_main_queue(), ^{
        // This runs in the UI Thread

        for(UIView *v in views) {
            // Add tags to the view we created it for
            [self.tagView addSubview:v];
        }

    });
});
```

## Authors

* [Matthew Conlen](http://www.github.com/mathisonian) mc@mathisonian.com

## License

The MIT License (MIT)

Copyright (c) 2013 Huffington Post Labs

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
