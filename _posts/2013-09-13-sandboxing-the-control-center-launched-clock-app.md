---
title: Sandboxing the Control Center launched Clock app
author: Anson L
layout: post
permalink: /2013/09/sandboxing-the-control-center-launched-clock-app
dsq_thread_id:
  - 1755634289
categories:
  - Thoughts
tags:
  - alarm
  - clock app
  - control center
  - ios 7
---
The new Control Center in iOS 7 lets you quickly turn on the back LED or launch the Clock, Calculator, or Camera app without needing to unlock the device.

<div id="attachment_2726" style="width: 650px" class="wp-caption aligncenter">
  <a href="https://ansonliu.com/wp-content/uploads/2013/09/control-center-apps.png"><img class="size-full wp-image-2726" alt="Control Center Apps" src="https://ansonliu.com/wp-content/uploads/2013/09/control-center-apps.png" width="640" height="192" /></a><p class="wp-caption-text">
    iOS 7 Control Center Apps
  </p>
</div>

This ease of use is all nice and Apple has anticipated what users will use the apps for. The Clock app defaults to the Timer tab. The Calculator is a number crunching machine. The Camera &#8230; well, takes photos.

On further use, I quickly noticed that you had full access to everything in the Clock app including setting and removing alarms. The majority of users launching the Clock app from Control Center will be looking for the Stopwatch or Timer functions, not setting an alarm. Setting an alarm is more of a &#8220;long term&#8221; action which most of us wouldn&#8217;t mind launching the clock app directly to use.  
The Alarm tab of the clock app should be disabled for unlocked devices. This ensures that others cannot modify your alarms. You would never know about the tampering until the meeting passed or the alarm rung at 3 AM. <p style="text-align: center;">
  <!--more-->
</p>

I could disable Control Center on the lock screen, but then I would lose access to the entire Control Center.  
Disabling functionality can be as simple as graying out the Alarm tab when the device is in a locked state. The Camera app prevents access to view past photos when the device is locked.

<div id="attachment_2728" style="width: 394px" class="wp-caption aligncenter">
  <a href="https://ansonliu.com/wp-content/uploads/2013/09/camera-roll-locked.png"><img class=" wp-image-2728 " alt="Camera Roll on locked device" src="https://ansonliu.com/wp-content/uploads/2013/09/camera-roll-locked.png" width="384" height="413" /></a><p class="wp-caption-text">
    iOS 7 Camera Roll on locked device
  </p>
</div>

This method of denial is very unobtrusive and the user can still snap away and review his/her just taken photos. The Control Center would be much more tamper proof if the Clock app&#8217;s Alarm modifying powers are sandboxed when the device is locked.

&nbsp;