
#PXPGradientColor

iOS 4.0 minimum.

##License

Without any further information, all the sources provided here are under the MIT License quoted in PXPGradientColor/LICENSE.


##What is PXPGradientColor

PXPGradientColor is an Objective-C wrapper for CGGradient. Useful for your iOS projects.
It Offers you the ability to create a nice gradient with just one line of code.
For example:

	+ (id)gradientWithStartingColor:(UIColor *)startingColor 
						endingColor:(UIColor *)endingColor;
	+ (id)gradientWithColors:(NSArray *)colors
	
Once your PXPGradientColor object has been created, you can use the drawing method from any graphics context :


	@implement MyCustomView
	@synthesize gradient = _gradient;
	
	- (void)drawRect:(CGRect)rect
	{
		[[self gradient] drawInRect:rect angle:90];
	}
	
	@end
	
Or even :

	@implement MyCustomView
	@synthesize gradient = _gradient;
	
	- (void)drawRect:(CGRect)rect
	{
		[[self gradient] drawInBezierPath:[UIBezierPath bezierPathWithOvalInRect:rect] angle:90];
	}
	
	@end
	
As simple as that.

Please notice that this is a first draft of the wrapper. So please report any issue you may encounter.
I'm also working on methods for drawing a radial gradient.

Thank you.