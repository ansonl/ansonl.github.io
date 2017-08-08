---
title: iOS 6 Weather app broken?
author: Anson L
layout: post
permalink: /2012/12/ios-5-weather-app-broken
dsq_thread_id:
  - 973503150
categories:
  - Thoughts
tags:
  - iOS 6
  - weather
---
Try out the Weather app in iOS 6. On the iPhone 5, Weather will not be able to get the forecast for added locations. You can&#8217;t even add locations right now.

Weirdly enough, it will still fetch the forecast for your current location, leading to the guess that the API that the Weather app uses to get info from The Weather Channel is broken right now.

Update 12/17/12 : Weather works intermittently. Looking at the Diagnostics and Usage Data in the Settings app, there is a consolidated log of crash reports from Weather.app. The bundleid of many of the reports is: */System/Library/PrivateFrameworks/Weather.framework*. With each report is some statistics of the device at the time of the logging. I am not sure how to interpret the logs, so I can&#8217;t make any conclusions right now.