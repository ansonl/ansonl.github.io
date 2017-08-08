---
title: Googlebot Crawler download rate increase with move to Rackspace
author: Anson L
layout: post
permalink: /2013/06/googlebot-crawler-download-rate-increase-with-move-to-rackspace
dsq_thread_id:
  - 1357452606
categories:
  - Thoughts
tags:
  - download time
  - google webmaster tools
  - hostmonster
  - mashable
  - rackspace
  - reddit
---
Google has been keeping data on sites which aren&#8217;t verified on Google Webmaster Tools all this time which isn&#8217;t such a bad thing as it sounds. I haven&#8217;t used Google Webmaster Tools in a while and decided to re-verify this site today.

<div id="attachment_2580" style="width: 310px" class="wp-caption aligncenter">
  <a href="https://ansonliu.com/wp-content/uploads/2013/06/download-time.png"><img class="size-medium wp-image-2580" alt="download time decreased" src="https://ansonliu.com/wp-content/uploads/2013/06/download-time-300x72.png" width="300" height="72" /></a><p class="wp-caption-text">
    80% decrease in download time on 4/7
  </p>
</div>

I began migrating the server and DNS from Hostmonster to Rackspace on 4/5 and got the majority of the website back up and running on 4/6. The 80% decrease in download time occurring on 4/8 was most likely Googlebot taking 48 hours to update its DNS records to point to the Rackspace server.

The pre-4/7/Hostmonster download time looks horrible in retrospect as the Rackspace server is much more responsive and isn&#8217;t a shared server. But two months ago, it seemed pretty dandy. I guess you really do get what you pay for. In my previous post on[ migrating from Hostmonster to Rackspace][1], my current plan on Rackspace is about 35% greater per year.

Was it worth it? I sure think so. I now have to freedom to configure the server with whatever I need. In the migration article, I also mentioned I am running Nginx on the Rackspace server to serve up pages. Hostmonster uses Apache.

<div id="attachment_2582" style="width: 244px" class="wp-caption aligncenter">
  <a href="https://ansonliu.com/wp-content/uploads/2013/06/33-More-Entertaining-404-Error-Pages.png"><img class="size-medium wp-image-2582   " alt="Mashable's 33 More Entertaining 404 Error Pages" src="https://ansonliu.com/wp-content/uploads/2013/06/33-More-Entertaining-404-Error-Pages-234x300.png" width="234" height="300" /></a><p class="wp-caption-text">
    Mashable &#8211; 33 More Entertaining 404 Error Pages
  </p>
</div>

In 2011, Apparent Etch&#8217;s <a href="http://ansonliu.com/404" target="_blank">404 page</a> was featured on <a href="http://mashable.com/2011/01/16/funny-404-error-pages/" target="_blank">Mashable&#8217;s 33 More Entertaining 404 Error Pages</a>. It was also hosted on Hostmonster at the time. I remember the site slowing down and grinding to a halt for a few hours from a few hundred visitors (not completely sure due to lack of statistics, I checked Hostmonster&#8217;s AWStats for info back then).

<div id="attachment_2584" style="width: 310px" class="wp-caption aligncenter">
  <a href="https://ansonliu.com/wp-content/uploads/2013/06/Reddit-starcraft.png"><img class="size-medium wp-image-2584  " alt="Reddit - We need some explaining Blizzard." src="https://ansonliu.com/wp-content/uploads/2013/06/Reddit-starcraft-300x172.png" width="300" height="172" /></a><p class="wp-caption-text">
    Reddit &#8211; We need some explaining Blizzard.
  </p>
</div>

Fast forward to this year, on 5/12 I posted a fun find in the SC2 Editor to <a href="http://www.reddit.com/r/starcraft/comments/1e7t4z/we_need_some_explaining_blizzard_bananas_in_my/" target="_blank">Reddit</a>, I got about 15,000 views in the following 24 hrs. The lowest cost Rackspace server (1 CPU, 512MB RAM) handled the traffic spike without a problem. &#8230;Although the bandwidth charges should be interesting.

 [1]: https://ansonliu.com/2013/04/migration-to-rackspace "Migration to Rackspace"