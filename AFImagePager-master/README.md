## AFImagePager

This UIView Subclass is used to present Images loaded from the Web and is inspired from foursquare's Image Slideshow. For async load of the Images AFNetworking is used, this has been added as a git Submodule. To initialize and checkout this Submodule after you clone the AFImagePager repository please do the following:

```objective-c
git submodule update --init --recursive
```

Implementing the ImagePager is fairly easy, just set it up in Interface Builder:
![Setup in Interface Builder](http://kimar.github.io/screenshots/kiimagepager/ibsetup.png)

Optionally customize the PageControl's appearance:

```objective-c
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _imagePager.pageControl.currentPageIndicatorTintColor = [UIColor lightGrayColor];
    _imagePager.pageControl.pageIndicatorTintColor = [UIColor blackColor];
}
```

Now implement it's DataSource and (optionally) Delegate methods:

```objective-c
- (NSArray *) arrayWithImageUrlStrings
{
    return [NSArray arrayWithObjects:
            @"https://raw.github.com/kimar/tapebooth/master/Screenshots/Screen1.png",
            @"https://raw.github.com/kimar/tapebooth/master/Screenshots/Screen2.png",
            @"https://raw.github.com/kimar/tapebooth/master/Screenshots/Screen3.png",
            nil];
}

- (UIViewContentMode) contentModeForImage:(NSUInteger)image
{
    return UIViewContentModeScaleAspectFill;
}
```

This is how it looks like, after you've set it up:

![While loading the Image](http://kimar.github.io/screenshots/kiimagepager/1.png)
![After loading the Image](http://kimar.github.io/screenshots/kiimagepager/2.png)

This project is modification of KIImagePager (https://github.com/kimar/KIImagePager). Thank You Marcus Kida.

**The MIT License (MIT)**

Copyright (c) 2013 Marcus Kida

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.