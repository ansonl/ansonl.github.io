---
title: Invalid code entitlements fix
author: Anson Liu
layout: post
permalink: /2014/01/invalid-code-entitlements-fix
dsq_thread_id:
  - 2101585888
categories:
  - Development
tags:
  - application loader
  - aps-environment
  - build
  - itunes connect
  - Xcode
---
I came across an error warning about an invalid &#8216;development&#8217; key for &#8216;aps-environment&#8217; when submitting a binary with the <a href="https://itunesconnect.apple.com/docs/UsingApplicationLoader.pdf" target="_blank">Application Loader</a>. 

This hadn&#8217;t happened before nor had I changed anything about my configuration. APS-Environment sounds familiar to Apple Push Service Environment and the &#8216;development&#8217; key meant that something had altered to normal value of &#8216;aps-environment&#8217; to &#8216;development&#8217; sometime in the build process.  
Turns out that I still had the app debugging on my device when I created an archive of the app in Xcode.  
Stopping debugging and cleaning the project before archiving again led to no validation issues.