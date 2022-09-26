---
published: false
excerpt: >
  NAVADMIN Viewer has provided quick access to messages for over 4 years. See our feature chart and roadmap within. 

  ![NAVADMIN Viewer icon](/wp-content/uploads/2022/09/navadmin-viewer-Icon128.png)

  NAVADMIN Viewer for iOS now has Extended Access as an in-app purchase to support development and offset operating costs. Existing users can continue viewing the 3 latest messages. Extended Access ($4.99/year) unlocks all messages.

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
title: NAVADMIN Viewer Extended Access and 2022 Infrastructure Migration
---

NAVADMIN Viewer has migrated to newer infrastructure to continue operations and remain available to the user.

![NAVADMIN Viewer icon](/wp-content/uploads/2022/09/navadmin-viewer-Icon128.png)

Support from users offsets operating costs and encourages me to spend time developing. I hope the backstory of the app provides information on NAVADMIN Viewer for iOS having Extended Access for $4.99/year.

I initially developed NAVADMIN Viewer as side project in 2018. As you might expect, I didn't think that most people would be interested in an accessible message viewer and this side project for reading NAVADMINs would end up only being used by me. **Look, it's literally named "NAVADMIN Viewer".** But, contrary to what I thought in 2018, app usage took to the air and I continued to develop and maintain NAVADMIN Viewer in my free time.

Over 4.5 years later NAVADMIN Viewer does a lot more than list NAVADMINs. In 2022, the feature roadmap is below:

| Feature      | [iOS](https://apps.apple.com/us/app/navadmin-viewer/id1345135985) | [Android](https://play.google.com/store/apps/details?id=com.ansonliu.navadmin) | [Web](https://navadmin-viewer.github.io/) |
| ----------- | ----------- | ----------- | ----------- |
| Native app | ✅ | ✅ | ✅ (JS) |
| Near real-time message updates | ✅ | ✅ | ✅ |
| All NAVADMIN/ALNAVs (~2010 and later) | ✅ | ✅ | ✅ |
| All MARADMIN/ALMARs (~2015 and later) | ✅ | ✅ | ✅ |
| Full message search   | ✅ | ✅ | 🟡 (Titles only) |
| Offline messages | ✅ | ✅ | 🟡 |
| Notifications on new message release | ✅ | 🚧 | 🚧 |
| Message popularity ranking | ✅ |  | ✅ |
| Auto-detection of referenced publications | ✅ | 🚧 | 🚧 |
| Customizable message font | ✅ |  |  |
| Bookmark messages | ✅ |  |  |
| iCloud bookmark sync | ✅ | __N/A__ | __N/A__ |
| Handoff, Spotlight Search, Siri Shortcuts | ✅ | __N/A__ | __N/A__ |
| Runs on MacOS (the computer) | ✅ | __N/A__ | __N/A__ |
| Runs on Internet Explorer 11 | __N/A__ | __N/A__ | ✅ |

| Legend Symbol | Meaning |
| ----------- | ----------- |
| ✅ | Implemented |
| 🟡 | Partial support |
| 🚧 | On roadmap |
| __N/A__ | Not Applicable |

### 📱 Platform Feature Support

As seen in the chart above, not every platform has support for all features. I use an iPhone SE as my personal phone so more of my development is focused on iOS. Each app is written in its platform's native language. I don't use a cross-platform framework 🤢 for NAVADMIN Viewer because I believe that native applications for NAVADMIN Viewer provide the best experience to users. Native applications can more fully utilize platform APIs and access these APIs sooner without relying on a cross-platform middle layer to be updated or bug fixed.


### 🛠 Behind the scenes

Some of these features are made possible by a server infrastructure that aggregates message data. The iOS, Android, and Web apps fetch message data from the server application for load balancing and uniformity. The early version of NAVADMIN Viewer got its message directly from the official source. Any irregularities at the source required an app update to fix so I ended up creating a server that provided messages to the app; meaning any changes at the message source were handled at the server for uninterrupted app message delivery. Reducing 3 parsing logic in 3 languages into 1 language saved countless hours 😉

```
┌───────────┐    ┌───────────┐
│ REST API  ├────┤Redis      │
│           │    └───────────┘
│     +     │
│           │    ┌───────────┐
│Data Parser├────┤PostgreSQL │
└───────────┘    └───────────┘
```

The server consists of a front facing REST API and data processor written in Golang. This forward application caches a limited amount of messages in RAM and a Redis cache. The server utilizes a PostgreSQL database for storing everything else which is persistent message data.

### 💵 Costs + ⏳ Time

Alright here we are. **Compute time and data transfer costs money.**

NAVADMIN Viewer is a side project. I spend my time developing NAVADMIN Viewer because it's fun and it makes an impact helping sailors and others who read administrative messages.

**Operating NAVADMIN Viewer has real costs and my time is valuable.** NAVADMIN Viewer is able to avoid major costs by automation and running it on a hybrid of free and low cost cloud hosting. NAVADMIN Viewer's main server was running on a free server instance on Heroku for the past 4 years. Many PaaS cloud hosts have eliminated their free/low cost offerings lately. Heroku is [discontinuing free products](https://help.heroku.com/RSBRUH58/removal-of-heroku-free-product-plans-faq) at the end of 2022. Heroku's pricing scales exponentially 📈 – I would like to avoid that so I migrated NAVADMIN Viewer to new infrastructure to continue running. In addition to the main server, Redis and PostgreSQL hosting has some additional money and time cost to maintain.

### 🧨 NAVADMIN Viewer Extended Access

**The iOS version of NAVADMIN Viewer still lets ALL users access the 3 latest messages.** I added Extended Access as an in-app purchase to unlock access to all remaining messages. All users can continue searching through all messages and see which messages contain their search term but Extended Access is needed to view the full message.

*Android and Web versions of NAVADMIN Viewer continue to be free to use as this time but NAVADMIN Viewer on iOS is the flagship version that gets new features first.*

**If you find NAVADMIN Viewer helpful and that it saves you time and frustration *(AKA it accelerates your life)*, please consider supporting development and operations by getting Extended Access for $4.99/year.**

💸 *Not convinced? **Think $4.99/year is too much?*** How much is your and my time worth? ⏳ Here's a couple things which Extended Access costs less than:

- Meal at the NEX
- Pumpkin Spice Latte
- Chipotle
- Call of Duty battle pass
- Big Mac meal
- Skins in World of Warcraft
- Anything Supply is ordering on GSA right now
- 1 lb of beef
- 2 meals underway
- Tank of fuel for a Smart Car
- 100 DOGE coin
- Your time

#### NAVADMIN Viewer is available on the below platforms

- 📱 iOS App Store - [https://apps.apple.com/us/app/navadmin-viewer/id1345135985](https://apps.apple.com/us/app/navadmin-viewer/id1345135985) 
- 📱 Google Play - [https://play.google.com/store/apps/details?id=com.ansonliu.navadmin](https://play.google.com/store/apps/details?id=com.ansonliu.navadmin)

- 🖥 Web NAVADMIN Viewer - [https://navadmin-viewer.github.io/](https://navadmin-viewer.github.io/)