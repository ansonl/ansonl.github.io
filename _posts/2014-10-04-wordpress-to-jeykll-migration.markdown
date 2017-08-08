---
layout: post
title:  "Jekyll Migration Underway"
date:   2014-10-04 03:09:37
categories: jekyll update
---
Migrated to Jekyll from Wordpress

Handy find and substitute for replacing links:

```find . -type f -exec sed -i "s/http\(s\)*:\/\/apparentetch.com/http\1:\/\/ansonliu.com/g" {} \;```

Observations: Google Chrome keeps its own DNS cache apart from the OS so in order to view updated DNS records' effects you must either use incognito mode or clear the cache in settings.  