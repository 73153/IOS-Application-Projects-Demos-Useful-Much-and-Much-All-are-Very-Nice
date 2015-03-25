# FTWButton


`FTWButton` is a `UIControl` subclass that lets you easily set color, gradient, text, shadow, border, and icon properties for various states and animates between them.

## Usage

Using `FTWButton` is similar to UIButton, but it's built from the ground-up. Instead of relying on background images, `FTWButton` draws itself.

### Properties

FTWButton has several properties, that can be set for each state:

* Frame
* Background Color
* Background Gradient Colors
* Corner Radius
* Icon
* Text
* Text Color
* Text Shadow Color
* Text Shadow Offset
* Border Color
* Border Gradient Colors
* Border Width
* Shadow Color
* Shadow Offset
* Shadow Opacity
* Shadow Blur Radius
* Inner Shadow Color
* Inner Shadow Offset
* Inner Shadow Blur Radius

They are all animatable and transition between states.


### Example Code

	button1 = [[FTWButton alloc] init];
	
	button1.frame = CGRectMake(20, 20, 280, 40);
	[button1 setColors:[NSArray arrayWithObjects:
				  [UIColor colorWithRed:2.0f/255 green:184.0f/255 blue:255.0f/255 alpha:1.0f],
				  [UIColor colorWithRed:0.0f/255 green:68.0f/255 blue:255.0f/255 alpha:1.0f],
				  nil] forControlState:state];
	
	
	[button1 setInnerShadowColor:[UIColor colorWithRed:108.0f/255 green:221.0f/255 blue:253.0f/255 alpha:1.0f] forControlState:UIControlStateNormal];
	[button1 setInnerShadowOffset:CGSizeMake(0, 1) forControlState:UIControlStateNormal];
	
	[button1 setShadowColor:[UIColor blackColor] forControlState:UIControlStateNormal];
	[button1 setShadowOffset:CGSizeMake(0, 1) forControlState:UIControlStateNormal];
	[button1 setShadowOpacity:1.0f forControlState:UIControlStateNormal];
	
	[button1 setTextColor:[UIColor colorWithWhite:1.0f alpha:1.0f] forControlState:UIControlStateNormal];
	[button1 setTextShadowColor:[UIColor colorWithWhite:78.0f/255 alpha:1.0f] forControlState:UIControlStateNormal];
	[button1 setTextShadowOffset:CGSizeMake(0, -1) forControlState:UIControlStateNormal];
	
	[button1 setText:@"Tap me" forControlState:UIControlStateNormal];
	[button1 setText:@"Tapped!" forControlState:UIControlStateSelected];
	
	[button1 addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:button1];
	
You can combine this code and other styles in any way you like.

## Built-in Styles

This code is a bit verbose, so we've included several default styles, with colors chosen by our designer.

These styles are:

* A disabled style (gray gradient background, gray text)
* A delete style (red)
* A gray style
* A light blue style
* A richer blue style
* A yellow style
* A black style

Feel free to use the format to add your own. Please note that many of the styles add a highlighted state as well.

With those styles, the code becomes much simpler:

	button1 = [[FTWButton alloc] init];
	
	button1.frame = CGRectMake(20, 20, 280, 40);
	[button1 addBlueStyleForState:UIControlStateNormal];
	[button1 addYellowStyleForState:UIControlStateSelected];
	
	[button1 setText:@"Tap me" forControlState:UIControlStateNormal];
	[button1 setText:@"Tapped!" forControlState:UIControlStateSelected];
	
	[button1 addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:button1];

Setting `button1.selected` to `YES` will change the color to yellow, and fade the text from "Tap me" to "Tapped".

## Your designer will thank you

There are several things that Photoshop makes easy, such as inner shadows and border gradients, that are fairly difficult to do without images (and in some cases, even with images) in iOS. If you're building a dynamic button with text and colors, consider making it with FTWButton, so you can rapidly see what it would look like in the app itself.

Also, consider a color framework such as [EDColor](https://github.com/thisandagain/color), which can make adding colors to FTWButton much easier.

## Demo App

The demo app contains several demos of `FTWButton`, including changing color on selection, border animations, gradient borders, fancy inner shadows, icons, and changing the frame on selection. 