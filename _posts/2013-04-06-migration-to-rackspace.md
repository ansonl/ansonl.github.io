---
title: Migration to Rackspace
author: Anson Liu
layout: post
permalink: /2013/04/migration-to-rackspace
dsq_thread_id:
  - 1193496320
categories:
  - Development
  - Thoughts
tags:
  - hostmonster
  - Migration
  - nginx
  - rackspace
---
Apparent Etch has moved to Rackspace for hosting needs.

5 years ago, I was content with Hostmonster&#8217;s affordable (not so much in retrospect) shared hosting. I started a website to post pictures on and play with my fledgling HTML skills. Over time, I started this blog and have gotten a steady daily stream of readers. I rarely experience CPU Throttling a few years back. But the past year, it seemed as if my account was being throttled for the slightest amount of action.

<div id="attachment_2472" style="width: 563px" class="wp-caption aligncenter">
  <a href="https://ansonliu.com/wp-content/uploads/2013/04/hostmonster-cpu-throttling.png"><img class=" wp-image-2472  " alt="Hostmonster CPU throttling" src="https://ansonliu.com/wp-content/uploads/2013/04/hostmonster-cpu-throttling.png" width="553" height="319" /></a><p class="wp-caption-text">
    CPU throttling the day I migrated to Rackspace, 4/6/13
  </p>
</div>

<!--more-->

Comparison:  
**Hostmonster setup**  
&#8211; Hosting price is ~$60/yr  
&#8211; Comodo SSL certificate is ~$50/yr  
&#8211; Dedicated IP is ~$18/yr.  
&#8211; The Comodo SSL certificate <a href="https://my.hostmonster.com/cgi/help/426#purchase" target="_blank">requires</a> the dedicated IP plan.  
&#8211; Server wise, the Hostmonster server has an 8 core Intel Xeon CPU and 24-32GB of memory that is shared among thousands of sites. Server details gotten from SSH access.  
(You can also view which other people&#8217;s websites that are run on the same box through SSH, too. `netstat` helpfully lists the IP and resolved hostnames.)

**Rackspace setup**  
&#8211; <a href="http://www.rackspace.com/cloud/servers/pricing_a/" target="_blank">Cloud Server</a> 1 CPU, 512MB, 20GB disk space, and a capped network bandwidth of 20Mbps for ~$16/mo. which is $192/yr. The server also includes one IPv4 and one IPv6 address.  
&#8211; <a href="https://www.cheapssls.com/geotrust-ssl-certificates/rapidssl.html" target="_blank">RapidSSL certificate</a> for 4 years at ~$8 a year.

**Hostmonster:** $60 + $50 + $18 = **$138/yr**  
**Rackspace:** $192 + $8 = **$200/yr**  
<small><em>Amounts have been rounded for ease of calculations. </em></small>  
Is the extra $62/yr worth it? Instead of &#8220;unlimited&#8221; yet shared resources which are 8x of what Rackspace&#8217;s lowest Cloud Server offers, I get a set amount of resources which are guaranteed for that one Cloud Server.  
Consider how Hostmonster has been throttling performance and how its network speed slows to a crawl at times, the difference in price is worth it.  
So, goodbye Hostmonster hosting, it has been a good and bad five years with you.

I am still working on the migration and some things on this site will be inconsistent (theme, etc) through this week 4/8-4/14.  
Maybe I&#8217;ll change the blog&#8217;s theme since The Theme Foundry is no longer supporting the Titan theme.

Response to my inquiry into Titan development

> We will continue to make sure it is compatible with the most recent version of WordPress but will not be making any other upgrades or improvements to the theme.

The website&#8217;s current configuration is Nginx with a Unix socket to PHP5-FPM, MySQL, and WordPress running on top.  
<center>
  <img class="size-full wp-image-2492 alignnone" alt="Nginx" src="https://ansonliu.com/wp-content/uploads/2013/04/Nginx.gif" width="121" height="32" />  <img class=" wp-image-2493 alignnone" alt="PHP" src="https://ansonliu.com/wp-content/uploads/2013/04/PHP-logo.svg_.png" width="84" height="45" />  <img class=" wp-image-2494 alignnone" alt="MySQL" src="https://ansonliu.com/wp-content/uploads/2013/04/powered-by-mysql-125x64.png" width="100" height="51" />
</center>

  
**Helpful stuff in case you&#8217;re also looking into using Nginx, WordPress, and Rackspace:**

<a href="http://www.rackspace.com/knowledge_center/article/installing-nginx-and-php-fpm-preface" target="_blank">Rackspace Knowledgebase Nginx Install Guide</a>  
&#8211; A complete guide on installing Nginx

<a href="http://rtcamp.com/wordpress-nginx/tutorials/" target="_blank">WordPress on Nginx Install Guide</a>  
&#8211; I am currently using a Single Site WordPress configuration

<a href="http://www.php.net/manual/en/install.fpm.configuration.php" target="_blank">PHP5-FPM configuration info</a>  
&#8211; Try changing the php-fpm process manager to `ondemand`. The `ondemand` option decreased my memory usage from ~500MB to ~100MB.

&#8211; AT&T hasn&#8217;t updated its DNS records since Saturday. I&#8217;ve toggled the iPhone&#8217;s Airplane mode to reset the device&#8217;s DNS cache, but it is still loading Hostmonster&#8217;s IP address when using cellular connection. *AT&T DNS was updated 72 hours later on Monday. *

<a href="http://blog.netflowdevelopments.com/2012/03/13/prevent-your-log-files-from-getting-out-of-control-in-debian-squeeze/" target="_blank">Debian log file managment</a>  
&#8211; Reduce clutter and disk space of log files.

[Let us know][1] if you encounter any problems.

 [1]: mailto:support@apparentetch.com