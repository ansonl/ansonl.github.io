---
title: 'Image Out is&#8230;out!'
author: Anson Liu
layout: post
permalink: /2011/04/image-out-is-out
dsq_thread_id:
  - 359218288
categories:
  - Thoughts
tags:
  - image out
---
That&#8217;s right, Image Out is now available on the App Store! Get it [here][1].

<p style="text-align: center;">
  <img class="aligncenter size-full wp-image-618" title="image out icon" src="https://i2.wp.com/apparentetch.com/wp-content/uploads/2011/04/Icon.png?resize=358%2C358" alt="image out icon" data-recalc-dims="1" />
</p>

I revised the app icon again and changed the display&#8217;s bezel from black to grey. The reviewer didn&#8217;t see any conflict with Apple&#8217;s current line of displays. Ironically, the grey bezel appears to resemble Apple&#8217;s previous offering of silver Cinema displays than do the black bezels represent the current &#8220;iMac like&#8221; display models.

During the review process, I was experimenting with the iPhone&#8217;s proximity sensor and implemented it in Image Out.

<p style="text-align: center;">
  <!--more-->
</p>

Now, when you activate the proximity sensor, like tapping it, while showing an image through Image Out, the external display is blacked out and the audience will see nothing.

It&#8217;s a unique emergency feature that could come in handy at times. Either that, or you can just use it to test your device&#8217;s proximity sensor. I&#8217;ll be posting code for harnessing the proximity sensor sometime. In case you want to figure it out right now, the proximity sensor can be accessed through the [`UIDevice` class][2]. Oh, and the proximity sensor is near the top of the devices. I&#8217;ve posted the diagrams from the Apple&#8217;s *Case Design Guidelines for Apple Devices*.  
<img class="alignnone size-full wp-image-615" title="iphone diagram" src="https://i0.wp.com/apparentetch.com/wp-content/uploads/2011/04/iphone-diagram.png?resize=200%2C208" alt="iphone diagram" data-recalc-dims="1" /> <img class="alignnone size-full wp-image-616" title="ipad diagram" src="https://i0.wp.com/apparentetch.com/wp-content/uploads/2011/04/ipad-diagram.png?resize=200%2C159" alt="ipad diagram" data-recalc-dims="1" />

 [1]: http://itunes.apple.com/us/app/image-out/id425323898?mt=8&ls=1
 [2]: http://developer.apple.com/library/ios/#documentation/UIKit/Reference/UIDevice_Class/Reference/UIDevice.html