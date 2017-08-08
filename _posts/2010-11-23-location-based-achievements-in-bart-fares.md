---
title: Location based achievements in BART Fares
author: Anson Liu
layout: post
permalink: /2010/11/location-based-achievements-in-bart-fares
dsq_thread_id:
  - 359231666
categories:
  - Development
tags:
  - game center
---
When Game Center was released, I thought, &#8220;Ha, wouldn&#8217;t it be fun to have Game Center in one of my apps!&#8221;. Well, I added support in BART Fares and the free update was released last week.

To do so, I added the `GameKit` Framework into the project and appended `#import` into the view controller&#8217;s header. When the user checked in at a particular place, code to earn an achievement were run. The code I modified and used from Apple&#8217;s documentation is:

`NSString *identifier = @"fareidentifier";<br />
GKAchievement *achievement = [[[GKAchievement alloc] initWithIdentifier: identifier] autorelease];<br />
if (achievement) {<br />
achievement.percentComplete = 100;<br />
[achievement reportAchievementWithCompletionHandler:^(NSError *error)<br />
{<br />
if(error != nil) {<br />
NSLog(@"error with %@ achievement",identifier);<br />
}}];<br />
}`

The &#8220;identifier&#8221; string would be replaced with the appropriate achievement&#8217;s identifier. The location based achievements in the app did not incorporate progress, so I simply set the percent complete to 100. If there is an error, the program would spit out the achievement identifier. You could have it display the error, too.

<p style="text-align: center;">
  <!--more Read More → -->
</p>

Note: If progress is needed, you may want to just store the current progress and just add and subtract to its value whenever the correct/incorrect action is triggered.

Now the creative part starts. You can login to iTunes Connect to create and save achievements. I took most pictures using my [iphone] camera. Even though the image needs to be 512x512px, they&#8217;ll be displayed in 50x50px circles on the devices. If you&#8217;re still reading this, you should try out BART Fares on your idevice; the app is free. Game Center is a great way to get attention and will make the user want to use the app more.

<p style="text-align: center;">
  <img class="aligncenter size-full wp-image-271" title="gamecenter screenshot" src="https://i2.wp.com/apparentetch.com/wp-content/uploads/2010/11/gamecenter-screenshot.png?resize=484%2C323" alt="gamecenter screenshot" data-recalc-dims="1" />
</p>