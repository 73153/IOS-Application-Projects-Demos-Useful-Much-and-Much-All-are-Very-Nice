LBReadingTime
=============

LBReadingTime is a UITextView's category to compute the total reading time or remaining reading and UITextView indicator's panel showing the remaing reading time. Check out the component in action on [this video](https://www.youtube.com/watch?v=0G071OifGbU).

![image](https://raw.github.com/lukabernardi/LBReadingTime/master/screenshot_remaining_time.png)

This component is inspired by [iA blog](http://informationarchitects.net/blog/) and use some code from the [Florian Mielke's article about scroll indicator panel](http://blog.madefm.com/post/13817640556/ios-devcorner-attaching-an-info-panel-to-a)

Installation
=====
The preferred way to install is by using CocoaPods, but you can alway copy the files.

## Copy file
This code must be used with deploy target 5.0+ and under ARC. 
If your code doesn't use ARC you can [mark this source with the compiler flag](http://www.codeography.com/2011/10/10/making-arc-and-non-arc-play-nice.html) `-fobjc-arc` 

- Just grab the file in the folder named ReadingTime and drag them into your project

## CocoaPods

You can use [CocoaPods](http://cocoapods.org) to manage your dependencies and install *LBReadingTime*.
Follow the instructions on the CocoaPods site to [install the gem](https://github.com/CocoaPods/CocoaPods#installation) and add `pod 'LBReadingTime', :git => 'https://github.com/lukabernardi/LBReadingTime.git'` to your *Podfile*.

Usage
=====
You can use this component to show to your user how long will take to read a text or tho costantly show the remaining reading time while the user scroll in your UITextView.

This componet is made up of two main classes namely `UITextView+ReadingTime` and `LBReadingTimeScrollPanel`. 

The first one is a UITextView's category that enable the count of remaining reading time. It can be used independently for programmatically obtain the reading time. This category swizzle a UITextView method in order to know when the text changes and add some associated object, this is done at `+load:` but for actually start the counting you should set the property `enableReadingTime` to `YES`. This is done because counting the word introduce a slight overhead, therefor be sure to enable it only if you need it.
You can also customize the value of Words per Minute via the property `wordsPerMinute`, by default this value is set to 200 words per minute (According to [http://en.wikipedia.org/wiki/Words_per_minute](http://en.wikipedia.org/wiki/Words_per_minute)).

If you want to simply know the total reading time or the reamaining reading time you can use the properties `readingTime` and `remainingReadingTime`. Both returns the time in minute, is so little precise and all the computations are rounded cause doens't make sense to be precise at seconds in this kind of calcualtions. Consider this more like a guess than a perfect measure.

`LBReadingTimeScrollPanel`, instead, is the view that is attached to the `UIScrollView`'s indicator. In order to work correctly you should set this view as your `UITextView` delegate or also forward the delegate call to the view. This view resize itself automatically to match the label width.

The usage is pretty simple:

1. Instantiate the `LBReadingTimeScrollPanel` (hold it in a strong property since it's repeatedly added and removed as subview)
2. Enable the reading time in the `UITextView`
3. Set the scoll panel as `UITextView` delegate

		self.scrollPanel = [[LBReadingTimeScrollPanel alloc] initWithFrame:CGRectZero];
		self.textView.enableReadingTime = YES;
		self.textView.delegate = self.scrollPanel;
4. If your class need to be the UITextView delegate be sure to forward the delegate's message call to the `LBReadingTimeScrollPanel` instance:
		- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
		{
		    [self.scrollPanel scrollViewWillBeginDragging:scrollView];
		}
		
		- (void)scrollViewDidScroll:(UIScrollView *)scrollView
		{
		    [self.scrollPanel scrollViewDidScroll:scrollView];
		}
		
		- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
		{
		    [self.scrollPanel scrollViewDidEndScrollingAnimation:scrollView];
		}
    
    
If you need to localize or change the message in your .string file make an entry for the string `NSLocalizedString(@"%d min left", nil)`.
 
Stay in touch
============

Tweet me [@luka_bernardi](https://twitter.com/luka_bernardi) if you use this code or simply want to tell me what you think about it.

License
============
LBReadingTime is available under the MIT license. See the LICENSE file for more info.