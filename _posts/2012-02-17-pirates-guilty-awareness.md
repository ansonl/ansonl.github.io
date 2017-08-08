---
title: 'Pirates&#8217; Guilty awareness'
author: Anson Liu
layout: post
permalink: /2012/02/pirates-guilty-awareness
dsq_thread_id:
  - 564586983
categories:
  - Development
tags:
  - andriod
  - anticrack
  - AppTrackr
  - Crackulous
  - geometry stash
  - Installous
  - ios
  - pirate
  - trial
  - Xcode
---
4/29/13 &#8211; It looks like Greenheart Games took a <a href="http://www.greenheartgames.com/2013/04/29/what-happens-when-pirates-play-a-game-development-simulator-and-then-go-bankrupt-because-of-piracy/" target="_blank">similar approach to piracy</a> a year later in 2013 with Game Dev Tycoon. 

This article was first published on <a href="http://blogcritics.org/scitech/article/pirates-guilty-awareness-cracking-down-on/" target="_blank">Blogcritics</a>.

If you&#8217;ve developed a paid app for iOS or Android, you have probably seen illicit versions of your work up for download.  
Many developers try to fight it by adding piracy code into the &#8220;production&#8221; version of apps. This added code is supposed detect if the app has been cracked and take necessary action (quit the app, etc).  
That technique works counterintuitively. Nowadays, apps&#8217; cracked status is even harder to detect due to improved cracking tools. **The Game Has Changed**  
So instead of detecting a cracked version of a production app on the App Store, we will upload an upsell version of the app directly to the illicit download site. This way we can bypass the App Store and detection issues.  
<center>
  <!--more-->
</center>

**So here&#8217;s the plan:**  
Put a UIAlertView in the iOS app that asks users to download the it from the App Store. One button will send them to the App Store and another button will dismiss the alert.

*Show the alert*  
`UIAlertView *sellAlert = [[UIAlertView alloc] initWithTitle:@"Attention"<br />
message:@"If you like this app, please buy it from the App Store to support the developers.nnThis way we can continue coding great apps! "<br />
delegate:self<br />
cancelButtonTitle:nil<br />
otherButtonTitles:@"Goto store",@"Not yet",nil];<br />
[sellAlert show];<br />
[sellAlert release];`

*UIAlertViewDelegate actions*  
`-(void)alertView:(UIAlertView *)alertView<br />
clickedButtonAtIndex:(NSInteger)buttonIndex {<br />
if(buttonIndex == 0) {<br />
NSURL *url = [[NSURL alloc] initWithString: @"http://itunes.com/apps/geometrystash"];<br />
[[UIApplication sharedApplication] openURL:url];<br />
[url release];<br />
}<br />
}`

``  
[<img class="aligncenter size-full wp-image-1382" title="App Store Alert" src="https://ansonliu.com/wp-content/uploads/2012/02/appstore-alert.png" alt="" width="283" height="244" />][1]

You can add whatever you want cracked users to see. I&#8217;d rather let them use the app lest they just move on in frustration. Convert the app for sharing through *Organizer > Archives > Share&#8230;*.

Now that your guilt-inducing app is coded, you want to put it onto <a href="http://apptrackr.org" target="_blank">AppTrackr.org</a>, one of the most widely used sites for downloading apps. In theory, users will download your cracked app and then buy it if they would like to use it further. This strategy can be adopted for Android apps, too.

You navigate over to the site and make an account. When trying to upload the modified IPA file. You&#8217;ll see this message if you&#8217;re a first timer.

<p style="text-align: center;">
  <a href="https://ansonliu.com/wp-content/uploads/2012/02/moderated-account.png"><img class="aligncenter  wp-image-1373" title="Your account is currently moderated, so you are only allowed to submit new versions or applications until we approve you. " src="https://ansonliu.com/wp-content/uploads/2012/02/moderated-account.png" alt="Your account is currently moderated, so you are only allowed to submit new versions or applications until we approve you. " width="580" height="26" /></a>
</p>

<p style="text-align: left;">
  If your app has already has a cracked file for your target version available, you can&#8217;t upload your IPA file. So now what?
</p>

<p style="text-align: left;">
  Use the <a href="http://hackulo.us/wiki/Crackulous" target="_blank">Crackulous</a> app. Crackulous allows ordinary users to &#8220;crack&#8221; apps and submit them to AppTrackr. Other users can then download the IPA file onto their computer or directly to their device through the <a href="http://hackulo.us/wiki/Installous" target="_blank">Installous</a> app.
</p>

<p style="text-align: left;">
  Very easy to get the warez. Also very tempting to just use the cracked app without buying it.
</p>

<p style="text-align: left;">
  So you&#8217;ve built and installed your modified app on your device. Launch Crackulous on the device. You might not find your app there because Crackulous only lists apps that have been downloaded from the App Store.
</p>

<p style="text-align: left;">
  So go download your app from the App Store.
</p>

<p style="text-align: center;">
  <a href="https://ansonliu.com/wp-content/uploads/2012/02/install-from-app-store.png"><img class="size-full wp-image-1376 aligncenter" title="Install" src="https://ansonliu.com/wp-content/uploads/2012/02/install-from-app-store.png" alt="" width="92" height="41" /></a>
</p>

<p style="text-align: left;">
  Your app will now show up in Crackulous but it is not the version that your want to upload to AppTrackr. Build and install your app onto your device from Xcode. <strong>Do not</strong> delete the App Store originating app when installing the modified version.
</p>

<p style="text-align: center;">
  <a href="https://ansonliu.com/wp-content/uploads/2012/02/app-in-crackulous.png"><img class="size-full wp-image-1379 aligncenter" title="In Crackulous" src="https://ansonliu.com/wp-content/uploads/2012/02/app-in-crackulous.png" alt="" width="176" height="83" /></a>
</p>

<p style="text-align: left;">
  The app is now shown in Crackulous. Go create a FileDude or Fileape account. Crackulous can automatically upload the cracked IPA to either of those services and submit the link to AppTrackr using what I assume to be the AppTrackr API.
</p>

<p style="text-align: left;">
  Now enter your credentials into the Settings pane and crack your modified app. Submit to AppTrackr as prompted.
</p>

<p style="text-align: left;">
  Now young pirateers and testing users can try out your app and be reminded that they can buy the app out of the App Store if they enjoy it.
</p>

Now you probably want to know whether this works. I&#8217;ll show a bar graph for clicks over one month.

<p style="text-align: center;">
  <a href="https://ansonliu.com/wp-content/uploads/2012/02/graph.png"><img class="aligncenter  wp-image-1393" title="Clicks per day" src="https://ansonliu.com/wp-content/uploads/2012/02/graph.png" alt="Clicks per day" width="897" height="272" /></a>
</p>

<p style="text-align: left;">
  Half of the links from US with other countries taking up the other half. If you want to see updated numbers, go to the link&#8217;s info page <a href="https://bitly.com/geometrypiratelink+" target="_blank">HERE</a>.
</p>

<p style="text-align: left;">
  35 more copies of Geometry Stash were brought in January than in December. I started using the link on 1/4. It&#8217;s not possible to tell whether the increase in sales was from the modified version of the app or just a monthly fluctuation.
</p>

<p style="text-align: left;">
  Apple should provide some App Store statistics for developers such as referral links and success rate per link in order for developers and companies to better market their apps.
</p>

**Update:** Crackulous cracks app without the need for extensive knowledge. Users only need to click the app and a button to crack. You can do the same to crack your app in Crackulous.

 [1]: https://ansonliu.com/wp-content/uploads/2012/02/appstore-alert.png