---
title: What deleted my SDKs?
author: Anson Liu
layout: post
permalink: /2010/11/what-deleted-my-sdks
dsq_thread_id:
  - 864246992
categories:
  - Development
tags:
  - 4.2
  - SDK
---
When the iOS 4.2 Gold Master SDK was released yesterday, all devs eagerly swarmed around the Apple servers to download a copy. I let my copy download overnight and installed it today. I decided to open up on of my iPhone projects to ensure compatibility. I was poking around the build info when I noticed that the previous SDKs were AWOL.

<img class="alignleft size-full wp-image-197" title="only ios 4.2" src="https://i1.wp.com/apparentetch.com/wp-content/uploads/2010/11/only-ios-4.2.png?resize=477%2C104" alt="" data-recalc-dims="1" />My app had previously been set to 4.1 as the base  
SDK. Now it says &#8220;Base SDK not found&#8221; and I am forced to use the 4.2 OS.

I delved into the /Developer/ folder to search for my previous SDK folders. I found the missing folders under DeviceSupport. It&#8217;s probably just me, but those folders don&#8217;t seems like the real folders. I remember that they resided in the /Developer/SDKs/ folder instead.

<p style="text-align: center;">
  <!--more Read More → -->
</p>

<img class="alignleft size-full wp-image-198" title="only 4.2 sdk folder" src="https://i1.wp.com/apparentetch.com/wp-content/uploads/2010/11/only-4.2-sdk-folder.png?resize=513%2C169" alt="" data-recalc-dims="1" />

Apple may be telling us to develop under 4.2 in order to encourage users to update to the latest software. Building the apps in a higher SDK often causes a loss in users. When I released Geometry Stash under 3.0.1, many customers could not download it because they were still running 2.2.1. Is Apple trying to enforce updating through threat of not being able to download apps? Let us know what you think in the comments.