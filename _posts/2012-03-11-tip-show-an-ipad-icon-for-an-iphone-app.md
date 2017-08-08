---
title: 'Tip: Show an iPad icon for an iPhone app'
author: Anson Liu
layout: post
permalink: /2012/03/tip-show-an-ipad-icon-for-an-iphone-app
dsq_thread_id:
  - 607702445
categories:
  - Development
tags:
  - icon
  - ios
  - ipad
  - iphone
  - tip
---
You can display an iPad optimized icon for users who run your non-Universal iPhone app on their iPads.

While Xcode 4 may not give you the option of adding an iPad icon in the Summary tab, you can follow Apple&#8217;s <a href="https://developer.apple.com/library/ios/#documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/App-RelatedResources/App-RelatedResources.html#//apple_ref/doc/uid/TP40007072-CH6-SW5" target="_blank">documentation</a> to add an icon for iPad users even though the app is not made for iPad.

[<img class="alignleft  wp-image-1483" title="Icon-72.png" src="https://ansonliu.com/wp-content/uploads/2012/03/Screen-Shot-2012-03-11-at-5.22.48-PM.png" alt="" width="168" height="85" />][1]1. Get an icon that is 72 x 72 pixels.

2. Rename it to *Icon-72.png*.

3. Add it to your project.

You can also do the same for search results icons. This way, iPad users that want to use your iPhone binary app can have a crisp, sharp looking icon on their homescreens.

 [1]: https://ansonliu.com/wp-content/uploads/2012/03/Screen-Shot-2012-03-11-at-5.22.48-PM.png