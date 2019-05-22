---
title: Messenger Expose Unfriends Bug/Feature
excerpt: >
  The Facebook Messenger **Hide Story From** setting exposes people who have
  unfriended a profile with no advance preparation needed.


  ![Facebook Messenger Expose Unfriends
  Bug](/wp-content/uploads/2019/05/messenger_hide_friends_blur.png)
author: Anson Liu
layout: post
categories:
  - Development
tags:
  - facebook
  - messenger
  - stories
  - unfriend
  - bug
published: true
---
## Facebook Messenger Expose Unfriends Bug/Feature is Intended Functionality

**In short:** The Facebook Messenger **Hide Story From** setting exposes people who have unfriended a profile. You don't need to remember all your friends' names and look up every profile and friendship status because people who have unfriended you will show up as checked for **Hide Story From**. All the silently unfriended people will show up in a convenient list. 

This unexpected behavior can be viewed in the iOS Messenger app on at least v213.0. I have not tested on Android but expect it to work on the Android Messenger app as well. 

1. Open Messenger settings and select the Story row.

![Messenger settings]({{ '/wp-content/uploads/2019/05/messenger_settings.png' | prepend:site.baseurl }})

2. Inside the Story settings select the **Hide Story From** setting.

![Messenger Hide Story From setting]({{ '/wp-content/uploads/2019/05/messenger_hide_story.png' | prepend:site.baseurl }})

3. Note that any checked people (aka people who you thought were still Facebook friends) you haven't explicitly choosen to your hide story from have silently unfriended you in the past.

![Messenger Hide Story From expose unfriends]({{ '/wp-content/uploads/2019/05/messenger_hide_friends_blur.png' | prepend:site.baseurl }})

The expectation for **Hide Story From** is that you choose to hide a story from someone by checking their name. If someone unfriends you it doesn't make logical sense for Facebook to automatically check them to have your story hidden from them on your end for a few reasons:

1. You didn't choose to hide your story from them.

2. The person unfriended you. The exfriend choosing not to see your stories should affect the story settings on the exfriend side, not your story settings.

3. Unfriending should automatically unfollow a Facebook profile so the exfriend shouldn't see your stories.

Unlike users keeping a copy of a past friend list and looking up the current friendship status of everyone, this bug requires no advance preparation or mass lookup of profiles either manually or through Graph API.

I reported this bug to Facebook's Bug Bounty because it is possibly a identification/deanonymization issue depending on various situations that may lead to unfriending (social/emotional/etc) and the effects (bullying?/etc) of a previously assumed "silent" unfriend now being confirmed. 
While there is no technical "hacking" involved, the bug is more than just a user interface bug. I assume it is a implementation error in Facebook Stories when people unfriend/block each other, but am not sure how far back it goes. 

19APR19 - Reported bug to Facebook Whitehat Report #10157074538798744.
21APR19 - Facebook Security informs me that the expose unfriend bug "is actually just intended functionality".

If this is apparently intended functionality and I may have misinterpreted it, I figure people should know more about the functionality of the **Hide Story From** feature through this post.
