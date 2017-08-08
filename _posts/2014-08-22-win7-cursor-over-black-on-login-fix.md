---
title: Win7 cursor over black on login WLAN AutoConfig fix
author: Anson L
layout: post
permalink: /2014/08/win7-cursor-over-black-on-login-fix
dsq_thread_id:
  - 2951369162
categories:
  - Development
tags:
  - delayedautostart
  - regedit
  - t430
  - WLAN AutoConfig
---
Did you log into Windows to find a cursor over black with no keyboard response. Maybe the login process will finish and desktop will load after a long time. For laptops this may be a WLAN AutoConfig issue.

<div id="attachment_3106" style="width: 629px" class="wp-caption aligncenter">
  <a href="https://ansonliu.com/wp-content/uploads/2014/08/msconfig-services.png"><img class="size-full wp-image-3106" src="https://ansonliu.com/wp-content/uploads/2014/08/msconfig-services.png" alt="msconfig.exe services" width="619" height="265" /></a><p class="wp-caption-text">
    msconfig.exe services
  </p>
</div>

I encountered the same problem and was able to access the desktop through booting into safe mode (F8). The offending program was a service that could be disabled in msconfig. After disabling and enabling services like a perverse version of the [Memory card game][1], it was the WLAN AutoConfig service that was delaying the login process. A limited [mention][2] on the internet indicated that at some point, WLAN AutoConfig would have wrong dependencies.

Disabling WLAN AutoConfig allows you to login quickly like before, but Windows will no longer be able to connect to wireless network through the Windows interface because the WLAN AutoConfig service is not running. These dependencies are configured through the registry. The registry not being my area of expertise, I just turned off the wireless card on my issued [academy][3] Lenovo T430 (has a physical switch on the side, but you could also disable the wireless card through Windows Device Manager) before logging in and turned the card back on afterwards to start the autoconfig server after login.

I figured out how to fix this in the registry the next day.

<div id="attachment_3112" style="width: 510px" class="wp-caption aligncenter">
  <a href="https://ansonliu.com/wp-content/uploads/2014/08/wlansvc.png"><img class="wp-image-3112" src="https://ansonliu.com/wp-content/uploads/2014/08/wlansvc.png" alt="Regedit.exe wlansvc" width="500" height="222" /></a><p class="wp-caption-text">
    Regedit.exe wlansvc
  </p>
</div>

Following instructions [here][4], you may set WLAN AutoConfig&#8217;s startup from *Automatic* to *Automatic (Delayed Start)*.  
WLAN AutoConfig should be set to *Automatic* by default so we must use Registry Editor add the DWORD key *DelayedAutostart* with value of ** under *HKEY\_LOCAL\_MACHINE\SYSTEM\CurrentControlSet\services\WlansvcI*. The *DelayedAutostart* key sets the startup of the service to *Automatic (Delayed Start)*.  
Now WLAN AutoConfig will start after you have logged into the desktop and not delay the rest of the login.

 [1]: http://en.wikipedia.org/wiki/Concentration_(game)
 [2]: http://www.techsupportforum.com/forums/f135/solved-wlan-autoconfig-wlansvc-not-working-580466.html
 [3]: https://ansonliu.com/2012/06/the-end-maybe "The End? (maybe)"
 [4]: http://computerstepbystep.com/wlan_autoconfig_service.html#Regedit