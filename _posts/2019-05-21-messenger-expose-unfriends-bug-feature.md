---
published: true
title: Facebook Messenger 'Expose Unfriends' Bug
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
  - bug bounty
  - the internet of bugs
---
## Facebook Messenger "Expose Unfriends" Bug

**In short:** The Facebook Messenger **Hide Story From** setting exposes people who have unfriended a profile. You don't need to remember all your friends' names and look up every profile and friendship status because people who have unfriended you will show up as checked for **Hide Story From**. All the silently unfriended people will show up in a convenient list. 

This unexpected behavior can be viewed in the iOS Messenger app on at least v213.0. I have not tested on Android but expect it be shown on the Android Messenger app as well. 

1. Open Messenger settings and select the Story row.

![Messenger settings]({{ '/wp-content/uploads/2019/05/messenger_settings.png' | prepend:site.baseurl }})

2. Inside the Story settings select the **Hide Story From** setting.

![Messenger Hide Story From setting]({{ '/wp-content/uploads/2019/05/messenger_hide_story.png' | prepend:site.baseurl }})

3. Any checked profile rows you haven't _explicitly choosen to your hide story from_ have silently unfriended you in the past (aka people who you thought were still Facebook friends unless you manually checked their profile). _**Note:** People who have blocked you do not appear to show up in my testing but Facebook had already fixed their Stories implementation by then._

![Messenger Hide Story From expose unfriends]({{ '/wp-content/uploads/2019/05/messenger_hide_friends_blur.png' | prepend:site.baseurl }})

The expectation for **Hide Story From** is that you choose to hide a story from a profile by checking their name. If a profile unfriends you it doesn't make logical sense for Facebook to automatically check that profile to have your story hidden from the profile on your end for a few reasons:

1. You didn't choose to hide your story from the profile.

2. The person unfriended you. The exfriend choosing not to see your stories should affect the story settings on the exfriend side, not your story settings.

3. Unfriending should automatically unfollow a Facebook profile so the exfriend shouldn't see your stories.

Unlike users keeping a copy of a past friend list and looking up the current friendship status of everyone, this bug requires no advance preparation or mass lookup of profiles either manually or through Graph API.

The bug seems to be an implementation error in Facebook Stories **Hide Story From** database that occurs when people unfriend each other. Below is a matrix of the correct and incorrect behavior:

 Primary profile setting at time of unfriend | Correct **Hide Story From** selection | Bug behavior **Hide Story From** selection
 --- | --- | ---
 User explicitly chose to hide story | ☑ | ☑
 User did not choose to hide story | ☐ | ☑
 
The bug appears to affect unfriends between 2015-2018 until the Facebook Stories implementation was fixed. The actual implementation patch date is not public so the actual affected user count is unknown.

I reported this bug to Facebook's Bug Bounty because it is possibly a identification/deanonymization issue depending on various situations that may lead to unfriending (social/emotional/etc) and the effects (bullying?/etc) of a previously assumed "silent" unfriend now being confirmed. While there is no technical action involved, the bug is more than just a user interface bug. 

~~If this is apparently intended functionality and I may have misinterpreted it, I figure people should know more about the functionality of the **Hide Story From** feature through this post.~~

Facebook Security initially replied to my report as not valid. They wrote that this behavior "is actually just intended functionality". I wrote an initial version of this post a month later and Facebook requested that the post be removed while they investigate the bug behavior further. Four months afterwards, Facebook Security emailed me that:

> We had already fixed the bug when you reported the issue to us and started a mitigation job. However, your report highlighted our timeframe as an issue in the mitigation process, and now we're working on improving and expediting that work.
> While we had already fixed the bug when you reported the issue to us and started a cleanup process, your report led us to improve the process for a quicker full remediation.

~~Facebook gave a $1000 bounty for the report but the bounty claim URL came out as `%BUGCROWD_CLAIM_URL_DO_NOT_EDIT%`. I let them know but haven't gotten reply yet. :(~~

Facebook paid a $1000 bounty for the report that was transferred via Bugcrowd. 

19APR19 - Reported bug to Facebook Whitehat Report #10157074538798744.

21APR19 - Facebook Security informs me that the expose unfriend behavior "is actually just intended functionality".

21MAY19 - *Facebook Messenger Expose Unfriends Bug/Feature is Intended Functionality* initial post published. 

21MAY19 - Facebook requests the post be removed while they investigate bug behavior further.

30SEP19 - Facebook Security replies with bug bounty and explanation on mitigation. 
