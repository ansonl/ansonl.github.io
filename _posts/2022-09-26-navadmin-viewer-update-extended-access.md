---
published: true
excerpt: >
  NAVADMIN Viewer has provided 200k+ sailors/yr with quick, reliable access to messages since 2018. 


  ![NAVADMIN Viewer
  icon](/wp-content/uploads/2022/09/navadmin-viewer-Icon128.png)


  NAVADMIN Viewer for iOS now has the Extended Access in-app purchase to support
  development and maintenance. Existing users can continue viewing
  the 3 latest messages. Extended Access ($14.99/year) unlocks all messages.


  Why is there Extended Access? Please read the backstory in the post. 
author: Anson Liu
layout: post
categories:
  - development
tags:
  - navy
  - navadmin
  - update
  - in-app purchase
  - extended access
title: NAVADMIN Viewer Extended Access and 2022 Infrastructure Migration (Updated July 2025)
---

NAVADMIN Viewer has migrated to newer infrastructure to continue operations and remain available to the user.

![NAVADMIN Viewer icon](/wp-content/uploads/2022/09/navadmin-viewer-Icon128.png)

Support from users offsets operating costs and encourages me to spend time developing. I hope this NAVADMIN Viewer backstory provides information having Extended Access for $14.99/year within the iOS app.

> **July 2025 Update:** Existing users will retain any lower pricing for as long as they stay on Extended Access.

### ⚡ The Start

I initially developed NAVADMIN Viewer as a side project in 2018. As you might expect, I didn't think that most people would be interested in an accessible message viewer and this side project for reading NAVADMINs would end up only being used by me. **Look, it's literally named "NAVADMIN Viewer".** But, contrary to what I thought in 2018, app usage took off and I continued to develop and maintain NAVADMIN Viewer in my free time.

Over 7 years later NAVADMIN Viewer does a lot more than list only NAVADMINs for 200k+ yearly users. [Jump down to continue reading about the app.](#-the-start-continued)

### 🙏 Here is Where I Ask For Your Money :(

The data may be free. My time is not.

Your contribution goes a long way towards compensating/motivating me to continue improving and maintaining NAVADMIN Viewer.

I spend my time developing NAVADMIN Viewer because it's fun and makes an impact helping sailors and others who read administrative messages. I've never put ads in NAVADMIN Viewer and strive to keep it that way. If you're wondering if ads make "a lot of money" — they do not. I don't sell your data.

### ⭐ NAVADMIN Viewer Extended Access

**The iOS version of NAVADMIN Viewer lets ALL users access the 3 latest messages.** I added Extended Access as an in-app purchase to unlock access to all remaining messages. All users can continue searching through all messages and see which messages contain their search term but Extended Access is needed to view the full message.

💯*Users who previously supported me via flat rate in-app purchase get Extended Access for free. All versions of NAVADMIN Viewer continue to be free to use. NAVADMIN Viewer on iOS remains the flagship version that gets new features first.*

**If you find NAVADMIN Viewer helpful and the app gives you time back to do what you enjoy, please consider supporting my development and costs by getting Extended Access for $14.99/year.**

### ⚡ The Start (continued)

[View the current feature roadmap](https://github.com/navadmin-viewer/.github/blob/main/profile/README.md)

### 📱 Platform Feature Support

As seen in the linked feature roadmap chart above, not every platform has support for all features. I use an iPhone SE as my personal phone so naturally my development time is more focused on iOS. Each app is written in its platform's native language. I don't use a cross-platform framework 🤢 for NAVADMIN Viewer because I believe that native applications provide the best experience to users in this use case. Native applications can more fully utilize platform APIs and access these APIs sooner without relying on a cross-platform middle layer to be updated or bug fixed.

### 🛠 Behind the scenes

Some of these features are made possible by the NAVADMIN Viewer server infrastructure that aggregates and delivers message data. The iOS, Android, and Web apps fetch message data from the server application for load balancing and uniformity. The earliest version of NAVADMIN Viewer got its message directly from the official source. Any irregularities at the source (ex: site transition/deleted messages) required a full app update to fix so I ended up creating a server that provided messages to the app; now any changes at the message source were handled at the server for uninterrupted app message delivery. Reducing 3 parsing logic in 3 languages into 1 language saved hours and keeps me sane 😉

```                                                                                                        
+---------------+  +--------------+  +--------------+     
|  iOS Client   |  |Android Client|  |    Web app   |     
|               |  |              |  |              |     
|  Objective C  |  |    Kotlin    |  |  Javascript  |     
+-----------|---+  +------|-------+  +---|----------+     
            |             |              |                
            +---------+   |   +----------+                
                      |   |   |                           
                    +-|---|---|-+       +-------------+   
                    | REST API  |------ | Redis cache |   
 +-----------+      |    +      |       +-------------+   
 |Data source|------|Data Parser|       +----------+      
 +-----------+      |           |-------|PostgreSQL|      
                    |  Golang   |       |database  |      
                    +-----------+       +----------+        
```

The server consists of a front facing REST API and concurrent data processor written in Golang. This forward application caches a limited amount of messages in RAM and a Redis cache. The server utilizes a PostgreSQL database for storing everything else which is mostly persistent message data.

### ✉ Questions? Inquiries?

You can reach me at [support@ansonliu.com](mailto:support@ansonliu.com).

If you know the right people at DoN/OPNAV to make this app official, please connect us because I would love to spend more time adding features to the app and make it accessible to sailors and civilians for free.

---

#### 📱 NAVADMIN Viewer is available on the below platforms

- iOS App Store - [https://apps.apple.com/us/app/navadmin-viewer/id1345135985](https://apps.apple.com/us/app/navadmin-viewer/id1345135985) 
- Google Play - [https://play.google.com/store/apps/details?id=com.ansonliu.navadmin](https://play.google.com/store/apps/details?id=com.ansonliu.navadmin)

- Web NAVADMIN Viewer - [https://navadmin-viewer.github.io/](https://navadmin-viewer.github.io/)
