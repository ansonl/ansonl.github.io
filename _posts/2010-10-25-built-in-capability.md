---
title: '&quot;Built-in capability&quot;, eh?'
author: Anson Liu
layout: post
permalink: /2010/10/built-in-capability
dsq_thread_id:
  - 410372383
categories:
  - Thoughts
---
Last month, I received an email from the Apple review team regarding an update to Geometry Stash. Remember the post about fixing the video out bug? Well, that update is still being withheld by Apple. The review team&#8217;s email included:

> We’ve completed the review of your In App Purchase, Geometry Stash External Display, but because it charges users to access built-in iOS capabilities,  we cannot post this version to the App Store. For more information&#8230;

In short, the review team seems to have had a change of heart, they view the video out feature as an inherent, built-in iOS capability. I see differently, the definition of capability is the

> facility on a computer for performing a specified task &#8211; Oxford Dictionary

The iPhone&#8217;s iOS can perform a multitudes of tasks. One task would include manipulating the file system and the files within it. Almost all apps take advantage of this feature. Games, in particular, often save the users&#8217; progresses by flipping the value in an array from

`Levelpack3 - FALSE` to `Levelpack3 - TRUE`

This way, when the user relaunches the application, the user gets to use levelpack3 and keeps it forever. Many lucrative apps use this method, combined with in-app purchases to change the value, to enable bonus levels and features.

<p style="text-align: center;">
  <!--more Read More → -->
</p>

<div id="attachment_156" style="width: 170px" class="wp-caption alignleft">
  <img class="size-full wp-image-156" title="enigmo kid pack inapp purchase" src="https://i0.wp.com/apparentetch.com/wp-content/uploads/2010/10/enigmo-kid-pack-inapp-purchase.png?resize=160%2C240" alt="enigmo inapp purchase" data-recalc-dims="1" /><p class="wp-caption-text">
    Enigmo Inapp Purchase
  </p>
</div>

These games will allow users to buy an item and the games will then manipulate a file to save the changes. Certainly, these apps are charging users to access a **specific** &#8220;built-in iOS capability&#8221;. &#8220;But no, that&#8217;s something every app does!&#8221;, you may be thinking. Fear not, while every app may alter a filesystem, not all apps support or make use of push notifications. If you didn&#8217;t know already, push notifications are like alerts when the app isn&#8217;t running. The majority of apps on the App Store do not augment push notifications. Those that do, can charge &#8220;premium&#8221; fees for using these notifications. Take the ESPN 2010 FIFA World Cup app for example. This app charges $7.99 for what it describes as &#8220;live audio, video highlights, and alerts&#8221;. The mentioned alerts are push notifications that the user may set.

<div id="attachment_157" style="width: 170px" class="wp-caption alignleft">
  <img class="size-full wp-image-157 " title="FIFA soccer app inapp" src="https://i0.wp.com/apparentetch.com/wp-content/uploads/2010/10/FIFA-soccer-app-inapp.png?resize=160%2C240" alt="FIFA soccer app" data-recalc-dims="1" /><p class="wp-caption-text">
    ESPN app charging for push notifications and more
  </p>
</div>

A handful of todo apps also charge for this iOS only feature.

As you may have noticed, even fewer apps utilize video out support for an external display as reflected from Apple Store reviews for the <a rel="nofollow" href="http://store.apple.com/us/product/MC552ZM/A">Apple iPad VGA Adapter</a>. If this was a built-in iOS capability that was not worthy of being mentioned, most apps would support it. However, video out musters scarce support.

When the device receives a push notification, it has the choice of deciding what it wants to do with the data. This logic also applies to an external display. When an external display is detected, the application running can either choose to do nothing, or it can execute some code to display content through the adapter. When the user purchases external display support, Geometry Stash will manipulate the file system and instruct the firmware to transfer data through the adapter. For most apps, code is not fired and the adapter remains unused.

Video out support is a feature that is rare and worthy enough to be charged for,  the same goes for push notifications. These features, can properly implemented have the power to change a poor user experience into a useful app that the user will come back to. Video out does not come standard on any app, it is up to us, developers, to code this in and apply it towards great usage.

I&#8217;m still looking forward to that ardent debate with Apple later this week. Let us know what you think in the comments,