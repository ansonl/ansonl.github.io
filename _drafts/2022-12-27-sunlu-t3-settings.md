---
published: false
excerpt: >
  NAVADMIN Viewer has provided 80k+ sailors with quick access to messages for
  over 4 years. See the feature chart and roadmap within. 


  ![NAVADMIN Viewer
  icon](/wp-content/uploads/2022/09/navadmin-viewer-Icon128.png)


  NAVADMIN Viewer for iOS now has the Extended Access in-app purchase to support
  development and offset operating costs. Existing users can continue viewing
  the 3 latest messages. Extended Access ($4.99/year) unlocks all messages.


  Why is there Extended Access? Please read the backstory in the post. 
author: Anson Liu
layout: post
categories:
  - 3dprinting
tags:
  - sunlu t3
title: SUNLU T3 3D Printer Settings
---

The SUNLU Terminator 3 printer needs the below modifications before it is ready for use. These steps aren't clearly explained for new users or have been experimentally determined.

## Update the printer firmware to the latest version

Download the latest firmware (v3.40 24OCT22 at time of writing) from [http://3dsunlu.com/Content/2169603.html](http://3dsunlu.com/Content/2169603.html).

Open the Readme file in Notepad and follow the directions listed. If there is just one firmware file for your language, follow the Readme steps for the first firmware file.

## Manually level the bed

Set the Z-offset from the printhead BLTouch autoleveling sensor to the bed under Motion > Level > Z-Offset. When selecting the Z-Offset menu item, the printer will home/zero X,Y,Z directions and then position the printhead at the center of the bed. 