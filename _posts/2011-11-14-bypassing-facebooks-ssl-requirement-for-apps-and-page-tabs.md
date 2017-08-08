---
title: 'Bypassing Facebook&#039;s SSL Requirement for Apps and Page Tabs'
author: Anson L
layout: post
permalink: /2011/11/bypassing-facebooks-ssl-requirement-for-apps-and-page-tabs
dsq_thread_id:
  - 471502887
categories:
  - Development
tags:
  - .htaccess
  - facebook app
  - facebook page
  - http
  - https
  - port 443
  - port 80
  - ssl
---
On Oct 10, 2011, Facebook required all apps to supply <a href="https://developers.facebook.com/roadmap/" target="_blank">a url beginning with HTTPS</a> in order to provide users with SSL protection.

<p style="text-align: left;">
  - Not all developers have their own web hosting and an even fewer portion own SSL certificates.<br /> &#8211; You can try inputting a HTTP starting address into the Secure Canvas URL, but nothing will happen if you do.<br /> <img class="aligncenter size-full wp-image-1051" title="Denied!" src="https://i2.wp.com/apparentetch.com/wp-content/uploads/2011/12/fb-ssl-required.png?resize=525%2C50" alt="Denied!" data-recalc-dims="1" />
</p>

<center>
  <small><em>It&#8217;s not like that would work.</em></small>
</center>

<p style="text-align: left;">
  - Or you can try inputting a HTTP starting address into the Secure Page Tab URL. Facebook will accept it, but when users with &#8220;force HTTPS&#8221; on try to view the tab, Facebook wil automatically replace HTTP with HTTPS.
</p>

<!--more-->

<img class="aligncenter size-full wp-image-1053" title="HTTPS Added" src="https://i1.wp.com/apparentetch.com/wp-content/uploads/2011/12/https-added.png?resize=525%2C310" alt="HTTPS Added" data-recalc-dims="1" />

<center>
  <small><em>That sure turned out great.</em></small>
</center>

<center>
  So we have to input a HTTPS url for the app.
</center>

  
**Option A:** You can purchase or snag a SSL certificate for ~ $50.

***Lowdown:** Often needs extra money, needs to be paid every year.*

**Option B:** Get a <a href="http://www.cacert.org/" target="_blank">CAcert</a> certificate. May throw scary errors for visitors. <img class="aligncenter size-full wp-image-1065" title="Chrome warning" src="https://i2.wp.com/apparentetch.com/wp-content/uploads/2011/12/cacert-warning.png?resize=525%2C151" alt="Chrome warning" data-recalc-dims="1" />It is not trusted by browsers, but does encrypt the data. <img class="alignnone size-full wp-image-1066" title="Still encrypted" src="https://i0.wp.com/apparentetch.com/wp-content/uploads/2011/12/cacert-encrypt.png?resize=365%2C46" alt="Still encrypted" data-recalc-dims="1" />

***Lowdown:** Does the job, but some users may have reservations. *

> When users with HTTPS enabled visit your app, we will load the iFrame using the secure URL you specify. <small><a href="https://developers.facebook.com/blog/post/452" target="_blank">Facebook Developer Blog</a></small>

<center>
  Facebook may require a HTTPS url, but it doesn&#8217;t mean that we can&#8217;t load unencrypted resources or redirect to whole different page afterwords.
</center>

  
**Option C:** For those whose hosts provide some shared SSL support, it&#8217;s easy.  
<img class="size-full wp-image-1058 alignleft" title="spotty ssl" src="https://i1.wp.com/apparentetch.com/wp-content/uploads/2011/12/Screen-Shot-2011-11-12-at-11.25.47-AM.png?resize=248%2C362" alt="spotty ssl" data-recalc-dims="1" />Utilize the shared SSL url or whatever steps needed for it. In this example, we&#8217;ll use <a href="https://my.hostmonster.com/cgi/help/126" target="_blank">Hostmonster</a>.  
We will be attempting to use the page [here][1], on another account, in a facebook app.  
Using the spotty shared SSL service, the <a href="https://secure.hostmonster.com/~msjasbor/" target="_blank">page may not look good</a>. This is especially the case when the page&#8217;s resources are not setup for use with SSL.

So we will need to link every resource using the format that the webhost (Hostmonster) has specified  
`https://secure.hostmonster.com/~<em>msjasbor</em>/<em>resources</em>/...`  
The page runs on WordPress and has a theme installed, which makes you hunt down every resource used. Maybe you have something better to do.  
In the end, who&#8217;s going to want to spy on your activity when you are viewing an ASB website?  
Rather than relink everything, we can utilize a .htaccess redirect.

Port 443 is the default port for <a href="http://en.wikipedia.org/wiki/HTTP_Secure" target="_blank">HTTPS connections</a>. Whenever a server requests info from port 443, we will redirect them to port 80, the default <a href="http://en.wikipedia.org/wiki/HTTP" target="_blank">HTTP</a> port.  
<img class="aligncenter size-full wp-image-1061" title="Redirects" src="https://i1.wp.com/apparentetch.com/wp-content/uploads/2011/12/diagram-redirect.png?resize=424%2C155" alt="Redirects" data-recalc-dims="1" />

Here is the text for the .htaccess file that resides IN the directory that the secure url goes to.

`Options +FollowSymlinks<br />
Options +SymLinksIfOwnerMatch<br />
RewriteEngine on<br />
RewriteCond %{SERVER_PORT} ^443$<br />
RewriteRule ^(.*)$ <em>http://msjasb.org/clubportal</em>$1 [R=301,L]`

In this case the secure url given to Facebook is  
`https://secure.hostmonster.com/~msjasbor/clubportal/`  
and we redirect it to `http://msjasb.org/clubportal`

<img class="aligncenter size-full wp-image-1064" title="pseudo ssl" src="https://i0.wp.com/apparentetch.com/wp-content/uploads/2011/12/pseudo-ssl.png?resize=525%2C309" alt="pseudo ssl" data-recalc-dims="1" />

Some browsers will alert that the connection is only partially encrypted.

***Lowdown:** NO ENCRYPTION, but saves hassle and is a quick fix for data that is not sensitive. Apparently the Facebook PHP SDK uses port 443, so redirecting port 443 may impact integration. You may want to let only Facebook traffic through port 443 and let other traffic through port 80. *

Oct 1st, 2011 has long passed and Facebook publicizes the benefits of forcing SSL (when available) for its users. Thinking

> Oh, most users probably won&#8217;t use SSL.

will not suffice.  
Those who have enough computing knowledge to use Facebook apps will have the commonsense to switch over to SSL. Not giving Facebook anything for a secure URL will

> display a confirmation page to let HTTPS users switch to HTTP and continue to your app. <small><a href="https://developers.facebook.com/blog/post/452" target="_blank">Facebook Developer Blog</a></small>

Remember that you use Option C at your own risk, especially when handling data that you would not want strangers to have. Option C is viable if you&#8217;re comfortable with the world seeing everything, such as announcements and promotions.

 [1]: http://msjasb.org/clubportal