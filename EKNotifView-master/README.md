EKNotifView v0.0.2
===================

A Simple, easily customizable, lightweight notification system for iOS Apps

##Installation

Since **EKNotifView** is available a [Pod](http://cocoapods.org/?q=eknotifview) you can add it to your project simply by adding the following line to the bottom of your `Podfile`


<small>There was an issue with updating CocoaPods to version 0.0.2. That's why its not available as a pod yet. I'll fix that later.</small>

 ```ruby
 pod 'EKNotifView', '~> 0.0.1'
 ```
 
##Usage

To create an **EKNotifiView** you need to create the notification, give it a view to appear in, a direction to slide in from (up or down), a text style (title or subtitle) a view type (loading,success,failure or info), a title, and tell it to show, here's what the code would look like

```
    1. EKNotifView *note = [[EKNotifView alloc] initWithNotifViewType:aType notifPosition:aPosition notifTextStyle:aTextStyle andParentView:aView];
    2. [note changeTitleOfLabel:aLabelType to:theTitleString];
    3. [note show];
```
**Ok  I know that's alot, I'm woking on v0.0.3 which will feature a much shorter init method and more semantic setter methods. I hope to release it soon but I don't want to give any time frames yet (It shouldn't be long though)**

**TL;DR of the above** if you wait a bit for v0.0.3 then it'll be simpler to use *EKNotifView*

**Note:**  the line #2 is necessary because by default both the notification title 

##View Types (for use in the init method an customization methods)

 <table class="table">
	<thead>
		<tr>
			<th>Type</th>
			<th>Description</th>
	</thead>
	<tbody>
		<tr>
            <td><b>EKNotifViewTypeLoading</b></td>
			<td>
Loading Style
<br>
By default a black with small,white activity indicator on the left and the title on the right
    <br><br>
By default doesn't allow tap to dismiss
        <br><br>
            can only hide by calling <code>[note hide];</code>
</td>
		</tr>
         <tr>
             <td><b>EKNotifViewTypeSuccess</b></td>
			<td>
Success Style
<br>
By default a green notification with a white check icon on the left and a title on the right
        <br><br>
By default allows tap to dismiss
</td>
		</tr>
                      <tr>
             <td><b>EKNotifViewTypeFailure</b></td>
			<td>
Failure Style
<br>
By default a red notification with a white "x" icon on the left and a title on the right
        <br><br>
By default allows tap to dismiss

</td>
		</tr>
                                                <tr>
             <td><b>EKNotifViewTypeInfo</b></td>
			<td>
Info Style
<br>
By default a black notification with no icon on the left and a title covering the entire width of the notification
            <br><br>
By default allows tap to dismiss
</td>
		</tr>
		
</table>

##View Positions (for use in the init method)
 <table class="table">
	<thead>
		<tr>
			<th>Type</th>
			<th>Description</th>
	</thead>
	<tbody>
		<tr>
            <td><b>EKNotifViewPositionTop</b></td>
			<td>
View will slide down from bottom
</td>
		</tr>
         <tr>
             <td><b>EKNotifViewPositionBottom</b></td>
			<td>
View will slide up from the bottom
</td>
		</tr>
</table>

##Text Styles (for use in the init method)

 <table class="table">
	<thead>
		<tr>
			<th>Type</th>
			<th>Description</th>
	</thead>
	<tbody>
		<tr>
            <td><b>EKNotifViewTextStyleTitle</b></td>
			<td>
Show only one vertically centered and **bolded** title
</td>
		</tr>
         <tr>
             <td><b>EKNotifViewTextStyleSubtitle</b></td>
			<td>
Show a title on top of the notification, **bolded** and on the bottom show a notification subtitle
</td>
		</tr>		
</table>

##Label Types (for use in the init method an customization methods and changing the initial notification title)

 <table class="table">
	<thead>
		<tr>
			<th>Type</th>
			<th>Description</th>
	</thead>
	<tbody>
		<tr>
            <td><b>EKNotifViewLabelTypeTitle</b></td>
			<td>
The passed text will be used as the text of the title of notification only
</td>
		</tr>
         <tr>
             <td><b>EKNotifViewLabelTypeSubtitle</b></td>
			<td>
The passed text will be used as the text of the subtitle of notification only
</td>
		</tr>	
		 <tr>
             <td><b>EKNotifViewLabelTypeAll</b></td>
			<td>
The passed text will be used as the text of both the title and subtitle of the notification
</td>
		</tr>		
</table>

After creating the notification via `init` we need to specify the text for title of the notification and the subtitle of the notificaiton (if you're using EKNotifViewTextStyleTitle then you don't have to worry about the subtitle)

Here's we'd set the title of the notification

```
[note changeTitleOfLabelType:EKNotifViewLabelTypeTitle to:@"World successfully destroyed!"];
```

And here's how we'd set the subtitle of the notification 

```
[note changeTitleOfLabelType:EKNotifViewLabelTypeSubtitle to:@"World successfully destroyed!"];
```
And to change the text of the title and subtitle to the same thing here's how it would look

```
[note changeTitleOfLabelType:EKNotifViewLabelTypeAll to:@"World successfully destroyed!"];
```

##Custmomization
###Change notification background color
You customize the background of notification of a certain view type by calling 

```
[note changeBackgroundColorToColor:someColor forViewType:aViewType];
```            

**Note:** to use an image for the background color use the `+imageWithPatternImage:` method of `UIColor`
          
###Change font of title and subtitle of notificaiton

``` 
[note changeFontOfLabel:aLabelType to:aUIFontObject];
```                                                    

**Lastly,**

**Ok  I know that's alot, I'm woking on v0.0.3 which will feature a much shorter init method and more semantic setter methods. I hope to release it soon but I don't want to give any time frames yet (It shouldn't be long though)**

**TL;DR of the above** if you wait a bit for v0.0.3 then it'll be simpler to use *EKNotifView*

#Dat's all folks!

