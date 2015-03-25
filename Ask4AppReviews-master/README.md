Introduction
------------
Ask4AppReviews is a class that you can drop into any iPhone app (iOS 5.0 or later) that will help remind your users
to review your app on the App Store. The code is released under the MIT/X11, so feel free to
modify and share your changes with the world. To find out more, check out the [homepage].


Getting Started
---------------
1. Add the Ask4AppReviews code into your project
2. Add the `CFNetwork` and `SystemConfiguration` and 'MessageUI' frameworks to your project
3. Call `[Ask4AppReviews appLaunched:YES]` at the end of your app delegate's `application:didFinishLaunchingWithOptions:` method.
4. Call `[Ask4AppReviews appEnteredForeground:YES]` in your app delegate's `applicationWillEnterForeground:` method. and provide a navigationController for the MailComposer message to appear
5. (OPTIONAL) Call `[Ask4AppReviews userDidSignificantEvent:YES]` when the user does something 'significant' in the app.
6. Finally, set the `AppStoreId` in your project info.plist (AppStoreId) and 'DeveloperEmail' which is the email which the positive feedback goes too.

License
-------
Copyright 2012. [luke durrant].
This library is distributed under the terms of the MIT/X11.



While not required, I greatly encourage and appreciate any improvements that you make
to this library be contributed back for the benefit of all who use it.
the original forked code can be found at the project
https://github.com/arashpayan/appirater


--------------

[homepage]: http://lukedurrant.com/2012/07/appirater-github-fork/
[luke durrant]: http://lukedurrant.com
