MIS-Linkedin-Share
==============

By Pedro Milanez

### Make it Simple - Linkedin Share

![Image](https://pbs.twimg.com/media/A30tKJICcAA8vwd.jpg:large)
Introduction
------------

Make it Simple series is a bunch of code to make your life simple! :D

In this episode, I introduce the Linkedin Share simple way of life!


Features
--------

- Only one line of code => share stuff on Linkedin account! Nice, huh? :P

Usage
-----

#### Copy this folder to your project:
    MIS-Linkedin-Share

#### Import:
    #import "MISLinkedinShare.h"

#### Configure your Linkedin API's key (on "MISLinkedinShare.h):
    #define kLinkedinApiKey @"YOUR LINKEDIN KEY"
	#define kLinkedinSecretKey @"YOUR LINKEDIN SECRETKEY"

#### Have fun!
	[[MISLinkedinShare sharedInstance] shareContent:self postTitle:@"Title" postDescription:@"Description" postURL:@"www.google.com" postImageURL:@"http://www.google.com/images/errors/logo_sm.gif"];


Full Example
------------

I've included a full example project in this repository.

In **MIS-Linkedin-Share-Demo**, see **ViewController.h** and **ViewController.m** for details.



TODO Stuff:
-------

A lot! Fell free to help me out! Let's share some code!! :D


This is possible thanks to:
-------

The LinkedIn-OAuth-Sample-Client project by Kirsten Jones.
Some changes were made but the core it's mostly intact.
    https://github.com/synedra/LinkedIn-OAuth-Sample-Client

The JSON library used is JSONKit by John Engelhart.
    https://github.com/johnezang/JSONKit



License
-------

Copyright (c) 2012 Pedro Milanez. All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall remain in place
in this source code.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.