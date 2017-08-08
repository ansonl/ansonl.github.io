---
title: Install iOS 7 GM by update
author: Anson L
layout: post
permalink: /2013/09/install-ios-7-gm-by-update
dsq_thread_id:
  - 1746792087
categories:
  - Development
tags:
  - iOS 7 GM
  - iTunes
  - no restore
  - update
---
By now you&#8217;re probably downloading or have downloaded the iOS 7 GM seed after Apple&#8217;s iOS 7 announcement today.

When installing the iOS 7 beta, a restore of the device was required. Alt-clicking the Update button in iTunes did not suffice. Attempts to do so were met with an error alert and device stuck on the &#8220;Connect to iTunes&#8221; screen. If one wanted to keep one&#8217;s old device contents, an iCloud or iTunes backup was required. Backups could take some time to restore contents onto the wiped but updated device and not all app content is covered by backups.

However, with the iOS 7 GM, alt-clicking the Update button in iTunes works without a hitch. No restore required.

[<img class="alignnone size-full wp-image-2714" alt="Update Button in iTunes" src="https://ansonliu.com/wp-content/uploads/2013/09/update-button-in-itunes.png" width="763" height="143" />][1]

If you don&#8217;t know how, you just need to hold down the &#8220;Alt&#8221; button on your keyboard while clicking the Update button next to your device in iTunes. A file selection dialog will appear which you point in the direction of the iOS 7 GM IPSW file. It still is a good idea to make a backup for your device just in case.  
iTunes will then update your device to iOS 7 and retain original settings.

I haven&#8217;t checked out the Xcode 5 GM and tried to get [iOS 3 & armv6 compatibility][2] yet, but will post when I do.

**Bugs with iOS 7 update (seen so far):**  
&#8211; The &#8220;Require Passcode&#8221; option under *Settings > General > Passcode Lock* is reset to *Immediately* regardless of its previous iOS 6 value.  
&#8211; Clicking &#8220;Advertising&#8221; under* Settings > Privacy* with slow internet hangs the Settings app and restarts the device.

<div>
  <div id="attachment_2746" style="width: 240px" class="wp-caption alignleft">
    <a href="https://ansonliu.com/wp-content/uploads/2013/09/opening-updating-apps1.png"><img class=" wp-image-2746  " alt="iOS 7 app switching" src="https://ansonliu.com/wp-content/uploads/2013/09/opening-updating-apps1.png" width="230" height="304" /></a><p class="wp-caption-text">
      iOS 7 app switching
    </p>
  </div>
  
  <p>
    &#8211; When updating an app, you can still open and run that app while it is downloading the updated binary through the app switcher. When the app has entered the installing stage, you cannot open it anymore.
  </p>
</div>

**Quirks:**  
&#8211; When you are on a second page of a folder, go back to the home screen. If you quickly re-select the folder, the icons will have a pixelated effect for a second before returning to normal. The device is probably still rendering the image to be shown at that point in time.

 [1]: https://ansonliu.com/wp-content/uploads/2013/09/update-button-in-itunes.png
 [2]: https://ansonliu.com/2013/06/all-in-on-ios-7 "All in on iOS 7"