---
title: All in on iOS 7
author: Anson L
layout: post
permalink: /2013/06/all-in-on-ios-7
dsq_thread_id:
  - 1402227164
categories:
  - Development
  - Thoughts
tags:
  - DeviceSupport
  - iOS 6
  - ios 7
  - SDK
---
Looks like Tim Cook is going all in on iOS 7.

From my testing, in order to get the new iOS 7 UIKit elements in an Xcode project, `IPHONEOS_DEPLOYMENT_TARGET` must be set to *iOS 7.0*. Just building with the iOS 7.0 SDK with an iOS 6 deployment target will show a pre-iOS 7 UI.

<div id="attachment_2672" style="width: 397px" class="wp-caption aligncenter">
  <a href="https://ansonliu.com/wp-content/uploads/2013/06/architectures-build-settings.png"><img class="wp-image-2672 " alt="Current development setup" src="https://ansonliu.com/wp-content/uploads/2013/06/architectures-build-settings.png" width="387" height="96" /></a><p class="wp-caption-text">
    Current development setup
  </p>
</div>

Then again, this behavior might be because I extracted the iOS 7 *SDK* and *DeviceSupport* files out of the Xcode 5 beta and dropped them into an Xcode 4.5 which is setup to build triple binaries for ARMv6, ARMv7, and ARMv7s.

<div id="attachment_2676" style="width: 210px" class="wp-caption aligncenter">
  <a href="https://ansonliu.com/wp-content/uploads/2013/06/ios-install-base.png"><img class="size-full wp-image-2676 " alt="iOS install base pie chart from Apple WWDC 2013 Keynote" src="https://ansonliu.com/wp-content/uploads/2013/06/ios-install-base.png" width="200" height="192" /></a><p class="wp-caption-text">
    Okay Apple, I get it. You really want to kill off iOS 5. I know you think the brethren iOS 3 & 4 are deep sixed, too.
  </p>
</div>

This lack of support is problematic as I&#8217;m currently aiming for iOS 3.1.3 and ARMv6 support in Geometry Stash&#8217;s next update. Users with older devices are left out in the dark by the majority of apps in the App Store due to Apple&#8217;s aggressive Xcode updates which silently, but effectively phase out ARMv6 and older iOS devices. Yes, usage charts show only a few percent of users running older iOS versions, but considering how many iOS devices have been sold and how many devices only support up to iOS 3 or iOS 4, this is a large enough amount of users to try to support.

&#8220;**Try**&#8221; is the keyword here, I currently don&#8217;t have a definite answer on older device support. The pre-release documents are not providing definite answers. There&#8217;re some mentions of getting existing apps to support correct layout in both iOS 6 and 7, but that is also public knowledge from the WWDC videos in case you&#8217;re wondering about NDA.

<span style="line-height: 1.714285714; font-size: 1rem;">Even </span><a style="line-height: 1.714285714; font-size: 1rem;" href="http://www.helpshift.com/" target="_blank">HelpShift</a><span style="line-height: 1.714285714; font-size: 1rem;">, an in-app support framework which I am working to integrate into the update, does not have an ARMv6 library. Support at HelpShift mentioned how they would include a blank ARMv6 slice to the HelpShift library in the next update but I haven&#8217;t tested this yet to verify.</span>

Maybe this matter be resolved in future iOS 7 seeds.