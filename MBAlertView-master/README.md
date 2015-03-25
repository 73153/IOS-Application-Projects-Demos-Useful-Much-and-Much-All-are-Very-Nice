 MBAlertView
===================

`MBAlertView` is a fast block-based alert and HUD library with a simple API. 


### Features
<ul>
	<li>Nested alerts and HUDs</li>
	<li>Block based</li>
	<li>Images</li>
	<li>Nice animations</li>
	<li>Doesn't use any PNG files. Everything is drawn with code.</li>
</ul>


## Usage


### Alerts: Flat


[![](http://i.imgur.com/08iRFnk.png)](http://i.imgur.com/08iRFnk.png)


``` objective-c
MBFlatAlertView *alert = [MBFlatAlertView alertWithTitle:@"Special Instructions" detailText:@"Are you sure?" cancelTitle:@"Cancel" cancelBlock:nil];
[alert addButtonWithTitle:@"Hello" type:MBFlatAlertButtonTypeBold action:^{}];
[alert addToDisplayQueue];
```

### Alerts: Classic


[![](http://i.imgur.com/3s3eJ.png)](http://i.imgur.com/3s3eJ.png)
[![](http://i.imgur.com/7CbbT.png)](http://i.imgur.com/7CbbT.png) 
[![](http://i.imgur.com/lq53u.png)](http://i.imgur.com/lq53u.png)
[![](http://i.imgur.com/Aqfnr.png)](http://i.imgur.com/Aqfnr.png)

``` objective-c
MBAlertView *alert = [MBAlertView alertWithBody:@"Are you sure you want to delete this note? You cannot undo this." cancelTitle:@"Cancel" cancelBlock:nil];
[alert addButtonWithText:@"Delete" type:MBAlertViewItemTypeDestructive block:^{}];
[alert addToDisplayQueue];
```

### HUDs
``` objective-c
[MBHUDView hudWithBody:@"Wait." type:MBAlertViewHUDTypeActivityIndicator hidesAfter:4.0 show:YES];
```

You can see more in the easy to follow demo.

##Other

[Bitar](http://www.bitar.io/paragraphs/) [@bitario](https://twitter.com/bitario)

## License
MBAlertView is available under the MIT license.
