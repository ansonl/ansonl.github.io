---
title: Easy analytics in-app w/ Alernalytics on GitHub
author: Anson Liu
layout: post
permalink: /2011/01/easy-analytics-with-alernalytics
dsq_thread_id:
  - 358993072
categories:
  - Development
tags:
  - alernalytics
  - github
  - uialertview
  - user data
---
It&#8217;s difficult to track how your app&#8217;s users found your app on the App Store. The process if usually **Source** -> **App Stor**e -> **Device**. We can determine how many customers went to the app&#8217;s store page from a promotional page or link by adding a page in between with some tracking code such as Google Analytics and so forth. Once the prospective user is on the App Store page, however, it is next to impossible to figure out whether they clicked the purchase button or not. Users tend to avoid taking a long surveys or doing something that takes extra effort and gives back little in return — a Thank You here and there, perhaps.

<img class="alignleft size-full wp-image-362" title="stats gathering" src="https://i2.wp.com/apparentetch.com/wp-content/uploads/2011/01/stats-gathering.png?resize=300%2C431" alt="stats gathering in alert view" data-recalc-dims="1" />Today, I decided to code a quick statistic gathering alert into Geometry Stash. Did I mention that users hate being taken into a web browser — especially when they are switched out into Safari?

I would check to see if it was the first run and launch an alert view asking the user how he/she found the app.

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

`UIAlertView *infoView = [[UIAlertView alloc] initWithTitle:@"Hey there!"<br />
message:@"How did you hear about Geometry Stash? n Just select your venue below:"<br />
delegate:self<br />
cancelButtonTitle:nil<br />
otherButtonTitles:@"Word of mouth", @"Advertisement", @"App Store", @"Other", nil];<br />
[infoView show];<br />
[infoView release];`

This should be easy to interpret. The idea behind the alert view was partly inspired by <a rel="nofollow" href="http://arashpayan.com/blog/index.php/2009/09/07/presenting-appirater/">Appirater</a>, written by Arash Payan (Alernalytics serves a different purpose than Appirater; the two share little alike.). If you wanted to get more info from the Other choice, you could follow up with a textbox asking the user to specify. Next comes the code that lets you know what the user picks.

<p style="text-align: center;">
  <!--more Read More → -->
</p>

`-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {<br />
NSString *statsMethod = [[NSString alloc] initWithFormat:@"not selected yet"];<br />
if(buttonIndex == 0){<br />
statsMethod = @"Word of Mouth";<br />
}<br />
if(buttonIndex == 1){<br />
statsMethod = @"Advertisement";<br />
}<br />
if(buttonIndex == 2){<br />
statsMethod = @"AppStore";<br />
}<br />
if(buttonIndex == 3){<br />
statsMethod = @"Other";<br />
}<br />
NSString *urlAddress = nil;<br />
urlAddress = [[NSString alloc]initWithFormat:@"http://example.com/datamechanism.php"];<br />
NSLog(@"%@",urlAddress);<br />
//Create a URL object.<br />
NSURL *url = [NSURL URLWithString:urlAddress];<br />
//URL Requst Object<br />
NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];<br />
//Load the request in the UIWebView.<br />
[webView loadRequest:requestObj];<br />
[statsMethod release];`

The code checks the index of the button clicked and sends the data to a website of your choice. I used a hidden web view, but any method would work. I recommend sending the data to a php file through POST. An alert view appeals to users over other interfaces. The users are familiar with the alert view, having used it before, and expect the experience to be short and straight forward.

So there you have it, a complete device side method of sending analytics to your website. I was surprised that apps currently on the App Store still redirect to a lengthy survey or webpage. I&#8217;ve decided to name this <a rel="nofollow" href="https://github.com/ansonl/Alernalytics">Alernalytics and have posted it on GitHub</a> if you would like to use that instead.

Now, if only iTunes Connect support will get back to me on fixing the issue on not being able to submit an update to Geometry Stash&#8230;