---
title: 'How-to: Install iWork for iOS beta'
author: Anson L
layout: post
permalink: /2011/08/how-to-install-iwork-for-ios-beta
dsq_thread_id:
  - 393010090
categories:
  - Development
tags:
  - beta
  - iCloud
  - ios
  - iWork
  - Xcode
---
Some of you might be wondering, &#8220;I&#8217;ve downloaded these iWork for iOS beta apps, but how do I use them?&#8221;.

Once you&#8217;ve unzipped the downloaded archive from Apple&#8217;s [iCloud Downloads page][1], fire up Xcode and make sure that your development device is connected and showing in the organizer.

<img title="application tab organizer.png" src="https://i2.wp.com/apparentetch.com/wp-content/uploads/2011/08/application-tab-organizer2.png?resize=176%2C115" border="0" alt="Application tab organizer" data-recalc-dims="1" /> <img title="add button.png" src="https://i0.wp.com/apparentetch.com/wp-content/uploads/2011/08/add-button1.png?resize=148%2C59" border="0" alt="Add button" data-recalc-dims="1" />

Select the Applications tab under the target device and there should be an Add button at the button of the screen. Click Add and simply select the desired iWork beta app file as shown below.

<img style="display: block; margin-left: auto; margin-right: auto;" title="select app file.png" src="https://i0.wp.com/apparentetch.com/wp-content/uploads/2011/08/select-app-file.png?resize=427%2C377" border="0" alt="Select app file" data-recalc-dims="1" />

After opening the app file, Xcode will automatically begin the transfer process. The app files are over 100 mbs in size, so it may take a few minutes to install. You can view the current progress of the transfer by clicking the target device&#8217;s name, the &#8220;Anson Liu&#8217;s iPhone&#8221; item for example, to go to the overview and see a progress bar.

Note that if you already have an App Store iWork app installed on your device, you should backup and uninstall it before installing the beta. Not doing so may cause a error of &#8220;Unable to communicate with device&#8221; during the install.

If you found this helpful or have additional tips, please comment below.

<!-- Technorati Tags Start -->

Technorati Tags: <a rel="tag" href="http://technorati.com/tag/ios%205">ios 5</a>, <a rel="tag" href="http://technorati.com/tag/iWork">iWork</a>, <a rel="tag" href="http://technorati.com/tag/beta">beta</a>, <a rel="tag" href="http://technorati.com/tag/iCloud">iCloud</a>, <a rel="tag" href="http://technorati.com/tag/Xcode">Xcode</a>

<!-- Technorati Tags End -->

 [1]: https://developer.apple.com/icloud/downloads/