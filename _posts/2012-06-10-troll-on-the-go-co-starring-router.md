---
title: Troll on the Go co-starring router
author: Anson Liu
layout: post
permalink: /2012/06/troll-on-the-go-co-starring-router
dsq_thread_id:
  - 719724868
categories:
  - Development
  - Thoughts
tags:
  - dd-wrt
  - DNS poisoning
  - DNSMasq
  - ios
  - wifi spoofing
  - wrt54g
---
As my high school career comes to a close, I&#8217;ve thought of what to do as a customary prank.

<div id="boxselection" style="float: left;">
  <a href="https://ansonliu.com/2012/06/the-end-maybe/">I&#8217;ll try to go out with a <strong>bang</strong>, both for high school and this blog.</a>
</div>

<audio id="bang" width="300" height="32" src="https://ansonliu.com/wp-content/uploads/2012/06/usatbomb.mp3" preload="auto"></audio>  
  
Sure, I could put a desk on the roof or toilet paper the campus like previous years. But nothing strikes **fear** into this generation that is glued to their devices than the prospect of no internet.

Time to troll-on-the-go. Let&#8217;s snag some wifi and poison the DNS.  
<center>
  </p> <p>
    <!--more-->
  </p>
  
  <p>
    </center>
  </p>
  
  <p>
    <strong>Pick a random track from the Spotify widget on the right</strong> — then read this.
  </p>
  
  <p>
    My high school has a campus wide wireless network, we&#8217;ll call it <em>wireless</em>, that students use to access the web on their iPod Touches and Android phones.
  </p>
  
  <p style="text-align: center;">
    <a href="https://ansonliu.com/wp-content/uploads/2012/04/sysprefs.png"><img class="size-full wp-image-1588 aligncenter" title="Wifi Network" src="https://ansonliu.com/wp-content/uploads/2012/04/sysprefs.png" alt="Wifi Network" width="320" height="61" /></a>
  </p>
  
  <p>
    The wireless network is unencrypted, so it makes our job easier. We can fool secured networks too, if the passphrase is known (<a href="http://www.aircrack-ng.org/" target="_blank">which isn&#8217;t too hard these days</a>).
  </p>
  
  <p>
    In order to make users go to our page, we need to pull them into our zone of control, our own wireless network. I purchased a <a href="http://en.wikipedia.org/wiki/Linksys_WRT54G_series" target="_blank">Linksys WRT54G</a> router off of the internet to create our own network. A WRT54G was used because it supports a wide array of custom firmwares. Try to get an older version of the router because those models have more RAM and do not use Linksys&#8217;s proprietary firmware as the newer versions do. I had to try out a few solutions before getting to the one below.
  </p>
  
  <p>
    <strong>DISCLAIMER: I, Anson Liu, and Apparent Etch, are NOT responsible for any damage, injury, liability, or ANYTHING resulting from the following of the below. Proceed at your OWN risk. Use common sense. </strong>
  </p>
  
  <p>
    <a href="https://ansonliu.com/wp-content/uploads/2012/06/3inacolumn.jpg"><img src="https://ansonliu.com/wp-content/uploads/2012/06/3inacolumn-300x278.jpg" alt="Stack of three, guess which one works?" title="Stack of three, guess which one works?" width="100" height="92" class="alignleft size-medium wp-image-1786" /></a>Install <a title="DD-WRT Firmware" href="http://www.dd-wrt.com/" target="_blank">DD-WRT</a>, an open source firmware for the router. DD-WRT allows us to change many settings not available with the stock firmware, including but not limited to Tx power (antenna power) and Virtual Access Points (VAP). Make sure to use an ethernet cable and static DHCP configuration when &#8220;updating&#8221; firmware. <strong>Typical DHCP configuration for flashing:</strong><br /> Device IP of <em>192.168.1.101</em><br /> DNS mask of <em>255.255.255.0</em><br /> Router IP of <em>192.168.1.1</em><br /> If the connection is broken when flashing the firmware, you may end up with a bricked router — two for me, unfortunately.
  </p>
  
  <p>
    Login to the web GUI with the username: <em>root</em> and password: <em>admin</em>.
  </p>
  
  <p>
    <a href="https://ansonliu.com/wp-content/uploads/2012/04/boot-wait.png"><img class="aligncenter size-medium wp-image-1592" title="Boot Wait" src="https://ansonliu.com/wp-content/uploads/2012/04/boot-wait-300x28.png" alt="Boot Wait" width="300" height="28" /></a>
  </p>
  
  <p>
    Enable Boot Wait under Administration > Management so that you can restore the firmware over TFTP if something goes wrong. You will be thankful for it when you Google for revival strategies.
  </p>
  
  <p>
    <a href="https://ansonliu.com/wp-content/uploads/2012/04/ssid.png"><img class="aligncenter size-medium wp-image-1591" title="SSID and VAP" src="https://ansonliu.com/wp-content/uploads/2012/04/ssid-300x226.png" alt="SSID and VAP" width="300" height="226" /></a>
  </p>
  
  <p>
    Under Wireless > Basic Settings change the SSID of the router&#8217;s wireless network to the target network&#8217;s name. In this case, it will be &#8220;wireless&#8221;. If you want to spoof multiple wireless networks, you can click &#8220;add&#8221; under Virtual Interfaces and create another VAP and rename the SSID, ex: <em>wireless1</em>. Now students will connect to our network if our router is closer to them and gets-to-them first.<br /> <strong>Note:</strong><em> The router may still only broadcast one BSSID, the MAC address of the router. On iOS devices only one of the SSID&#8217;s will be shown under the Wifi option due to the single BSSID while the device still &#8220;sees&#8221; both SSIDs. </em>
  </p>
  
  <p>
    Sure they&#8217;ve connected, but how do we send them to our custom page? At first, I attempted to use existing captive portal software. For some reason, the all the existing solutions require internet to function which is a no-no because our Troll-on-the-go rig won&#8217;t be having — or needing an active internet connection as you will see.
  </p>
  
  <p>
    Time to use DNSMasq, a DNS forwarder included in DD-WRT.
  </p>
  
  <p>
    <a href="https://ansonliu.com/wp-content/uploads/2012/04/dnsmasq.png"><img class="aligncenter size-medium wp-image-1593" title="DNSMasq" src="https://ansonliu.com/wp-content/uploads/2012/04/dnsmasq-300x79.png" alt="DNSMasq" width="300" height="79" /></a>
  </p>
  
  <p>
    DNSMasq settings are found under Services > Services. Enable DNSMasq and enter <code>address=/#/192.168.1.101</code> for Additional DNSMasq Options.
  </p>
  
  <p>
    When visitors request a domain, the # specifies a wildcard and returns the IP address of the domain name. If a user requests <em>google.com</em>, it will tell the device that <em>google.com</em> has the IP address of <em>192.168.1.101</em>. Naturally, the device trusts the router and assumes that <em>google.com</em> is at <em>192.168.1.101</em>.
  </p>
  
  <p>
    I was going to install a webserver on the router and have it listen on port 80 at the DNSMasq IP, but I could not get it to work. due in part to me not being able to configure the router correctly. Instead I used my 1st generation iPod Touch as a web server.
  </p>
  
  <p>
    1. Install <a href="http://www.lighttpd.net/" target="_blank">lighttpd</a> using Cydia and SSH using Axis&#8217; tutorial <a title="Install lighttpd on iOS" href="http://www.ifans.com/forums/threads/run-a-lightweight-webserver-on-your-idevice.326838/" target="_blank">here</a>.<br /> Add <code>server.error-handler-404 = “/error-handler.html”</code> to the <em>lighttpd.conf</em> file to redirect requests to domains&#8217; directories.
  </p>
  
  <p>
    <a href="https://ansonliu.com/wp-content/uploads/2012/06/static.png"><img class=" wp-image-1596 alignleft" title="Static settings" src="https://ansonliu.com/wp-content/uploads/2012/06/static-230x300.png" alt="Static settings" width="77" height="100" /></a>2. Set Static IP Address on the device while connected to router.
  </p>
  
  <p>
    3. Create the folders <em>/library/test/</em> and an HTML file within <em>test</em> named <em>success.html</em> under your lighttpd&#8217;s document root (default: <em>/</em>). You can edit the document root in the <em>lighttpd.conf</em> file located in <em>/usr/local/</em>.
  </p>
  
  <p>
    A link to a working success.html file: <a href="https://ansonliu.com/wp-content/uploads/2012/06/success.html">HERE</a>. You can view the page&#8217;s source and copy it over.
  </p>
  
  <p>
    The reason for this file is that your router may not have an actual internet connection. As a result, iOS shows a web view upon connecting to the network. The web view tries to access <em>http://apple.com/library/test/success.html</em>. You must get to the page from that web view or iOS 3.1.3 will not let you do anything else on the network. So here, the both the iOS lighttpd server and victims&#8217; devices will actually navigate to <em>http://192.168.1.101/library/test/success.html </em>due to the router&#8217;s DNSMasq options.
  </p>
  
  <p>
    4. Create your custom page in lighttpd&#8217;s document root.
  </p>
  
  <p>
    5. Install <a title="Insomnia" href="http://code.google.com/p/iphone-insomnia/" target="_blank">Insomnia</a> from Cydia to keep the wifi connection between the router and lighttpd server active when the device is locked.
  </p>
  
  <p>
    6. Start lighttpd with<br /> <code>/usr/bin/lighttpd-start &gt;/dev/null &amp;</code><br /> and connect the device server to the router network.
  </p>
  
  <p>
    <a href="https://ansonliu.com/wp-content/uploads/2012/06/ice-cream-booth.png"><img class="aligncenter size-medium wp-image-1610" title="Waffles, anyone?" src="https://ansonliu.com/wp-content/uploads/2012/06/ice-cream-booth-300x198.png" alt="Waffles, anyone?" width="300" height="198" /></a>
  </p>
  
  <p>
    If all settings were configured correctly, users will now to redirected to your custom page. The above page was used to advertise foods during a club event.
  </p>
  
  <p>
    Physical section:<br /> <a href="https://ansonliu.com/wp-content/uploads/2012/06/front.png"><img class="wp-image-1618 alignleft" title="Proof of Concept Rig (front)" src="https://ansonliu.com/wp-content/uploads/2012/06/front-300x198.png" alt="Rig (front)" width="210" height="138" /></a><a href="https://ansonliu.com/wp-content/uploads/2012/06/back.png"><img class="wp-image-1619 alignnone" title="Proof of Concept Rig (back)" src="https://ansonliu.com/wp-content/uploads/2012/06/back-300x198.png" alt="Rig (back)" width="210" height="138" /></a>
  </p>
  
  <p>
    I have a <a href="http://www.amazon.com/gp/product/B0063EYY5Y/ref=oh_details_o01_s00_i00">12V li-ion battery</a> powering the router. The battery and iPod Touch are held in place by velcro. The battery has a lot of capacity so I would recommend it for other power needs. The last thing to do is get a better pair of antenna to reach devices further and more quickly.
  </p>
  
  <p>
    Remember, exercise common sense and discretion. Only use the router when the owner and users of the premises have agreed to the use of this setup.
  </p>
  
  <p>
    Third party firmwares such as DD-WRT, allow SSH access to the router and overclocking capability. I increased by router&#8217;s clock speed to 216Mhz. To combat overheating, I installed a computer fan into the router as shown below. I cut a square in the casing to fit the fan and used the same li-ion battery to power the fan. That battery has both an N-type <a href="http://en.wikipedia.org/wiki/Coaxial_power_connector">power connector</a> (for the router) and USB port; it is one of the most versatile and longest lasting batteries I have used.
  </p>
  
  <p>
    <a href="https://ansonliu.com/wp-content/uploads/2012/06/fan-in-router.jpg"><img src="https://ansonliu.com/wp-content/uploads/2012/06/fan-in-router-300x207.jpg" alt="Fan in router" title="Fan in router" width="300" height="207" class="aligncenter size-medium wp-image-1946" /></a>
  </p>
  
  <p>
    My second try at cooling. This time I powered the fan through the router&#8217;s DC input <a href="http://www.dd-wrt.com/phpBB2/viewtopic.php?p=546256" target="_blank">pin and ring</a>. I also put in a switch for the fan so the router can be used independently from the fan. The fan used in the below picture was an actual fan from a computer case whereas the first fan was a laptop cooling stand&#8217;s.
  </p>
  
  <p>
    <a href="https://ansonliu.com/wp-content/uploads/2012/06/fan-2.jpg"><img src="https://ansonliu.com/wp-content/uploads/2012/06/fan-2-300x219.jpg" alt="Another try at cooling" title="Another try at cooling" width="300" height="219" class="aligncenter size-medium wp-image-1956" /></a>
  </p>
  
  <p>
    Hopefully this article will help you avoid using unencrypted wifi and make you more aware of SSID spoofing and DNS poisoning. &#8220;Spoof&#8221; sounds like such a harmless word but someone can be monitoring others&#8217; connections and activities with the simple setup above and malicious intent.<br /> No doubt the <a title="IEEE 802.11" href="http://en.wikipedia.org/wiki/IEEE_802.11" target="_blank">IEEE 802.11</a> standard will remain widely used for the next decade or so. This article will remain relevant for a while.
  </p>
  
  <p>
    I just noticed, this is post 102 on <a title="The Blog" href="http://ansonliu.com">the development blog</a>.<br /> Our <a title="Just a webclip" href="https://ansonliu.com/2010/08/just-a-webclip/">first post</a>, on iOS Safari webclips, was written back in August 2010. Check it out, it still applies to iOS now!
  </p>