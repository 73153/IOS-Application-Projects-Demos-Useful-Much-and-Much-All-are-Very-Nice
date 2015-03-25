PTSSpringBoard
==============

The PTSSpringBoard class provides the functionalities of a springboard as known from the iOS mainscreen. It supports moving and deleting items.

## Author
Ralph Gasser (pontius software GmbH)

## Requirements
* QuartzCore.framework
* Only implemented to work with ARC (Automated Reference Counting)

## Legal
Copyright 2012 by pontius software GmbH (Switzerland), All rights reserved

The code and its documentation are provided free of charge under the terms of the Creative Commons BY-SA 3.0 license.

You are allowed to use this class for any of your projects (be it commercial or open source). If you do so, you are invited to give credits to the author Ralph Gasser (pontius software GmbH, Switzerland). If you alter the class and/or improve upon it, you are kindly asked to share your work under the same terms.

## Description
The PTSSpringBoard class provides the functionalities of a springboard as known from the iOS mainscreen. It supports moving and deleting items. 

PTSSpringboard uses a delegation pattern to communicate with its data source and delegate, similar to that of the UITableView. By changing the implementation at the data source or delegate, you can completely control the behavior of the springboard and its items.

The class should be working on the iPhone (3.3 inch & 4inch) and iPad (although I only really tested the iPhones) and with all interface-orientations.  

## To-Do's
* Implementation for Retain/Release environment.
* Tweaking of the code - e.g. only re-layouting visible portions of the springboard.
* Testing and implementation for very lager numbers of items.
* Testing different combinations of size (label, badge, item).

