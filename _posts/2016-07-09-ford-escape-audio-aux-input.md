---
title: 2007 Ford Escape Audio AUX Input
author: Anson Liu
layout: post
categories:
  - Vehicle
tags:
  - ford escape
  - aux
---

I recently bought a used 2007 Ford Escape Hybrid and it had the Ford Navigation CD Player installed. 

![Ford Navigation CD Player](https://web.archive.org/web/20160710001031/http://i.ebayimg.com/images/g/-FgAAOSw1ZBUtq~H/s-l1600.jpg "Ford Navigation CD Player")

This head unit has AM/FM, hybrid status, and fuel consumption views. The navigation unit gets its data from a $199 [12-CD map pack](http://ford.navigation.com/product/Catalog/Catalog_Ford_EscapeHybrid_2007/Ford-North-America-Map-12-CD-Set-Version-4V/sku/U0016-0030-707/en_US/FordNA/USD). Each CD contains a geographic region of North America. The last version of the CD map pack was 4V in 2007. My 2007 Escape came with the 2005 CD map pack which is better than nothing in this year of 2016.

The navigation CD is loaded into the top CD drive and the audio 6 CD changer is located underneath the passenger seat. 

#### There is no audio AUX input. 

The only AUX input accessory I found that had a good chance of compatibility was the [AUX-FRDW Auxiliary Input Jack](http://www.discountcarstereo.com/AUX-FRDW.html) for $60. This accessory went inbetween the head unit and the CD changer. It appears to wire the 3.5mm audio input to the right pins of the CD changer connector. 

Can we figure out the correct CD changer pinout? Yes, for cheap price of a spare audio cable, we can add in our own AUX input to the 2007 and earlier year Ford Escapes. 

![WPT164 connector](https://web.archive.org/web/20160710010327/http://www.discountcarstereo.com/images/D/_ford12.jpg "WPT164 connector")

The 6 CD changer is connected to the head unit through a 12 pin pigtail connector. This is a [WPT164 connector](http://www.fordparts.com/fileuploads/cmsfiles/pigtailidentificationkit.pdf). 

After some [searching](https://www.google.com/search?q=ford+cd+changer+pinout&espv=2&biw=1440&bih=799&source=lnms&tbm=isch&sa=X&ved=0ahUKEwjrq6fo2efNAhXGlR4KHfSMADgQ_AUIBigB#), I found the similar [CD changer pinout](https://web.archive.org/web/20151102133458/http://www.taurusclub.com/forum/attachments/electronics-security-audio-visual/34387d1106003765-cd-changer-interface-cdchanger_pinout.jpg) of the Ford Taurus. 

![CD changer pinout](https://web.archive.org/web/20151102133458/http://www.taurusclub.com/forum/attachments/electronics-security-audio-visual/34387d1106003765-cd-changer-interface-cdchanger_pinout.jpg "CD changer pinout")

### The pins we will be using are 1/2 and 7/8. 

![3.5mm audio pinout](https://web.archive.org/web/20160710011317/http://cdn.head-fi.org/8/85/857c0c0a_stereo-adapter-1-4-to-rca.png "3.5mm audio pinout")

After you strip an audio cable which you will use as the AUX input wire, there will be three wires. The white wire is the left audio channel and red wire is the right audio channel. The remaining wire is the ground that completes the circuit for the audio channels. The above audio pinout diagram shows what we will be doing. Right and left channels will be connected to the WPT164 pins 7 and 8 respectivelyand we will be splitting the single ground to pins 1 and 2 to complete the left and right audio circuit.

My CD changer's 12 pin connector was located on the right side of the unit. You must depress the top plastic lever of the connector to detach it from the unit. 

![WPT164 pin removal]({{ site.baseurl }}/wp-content/uploads/2016/07/wpt164-repin.png)

#### Remember to keep track of the correct pin color to pin slot when you remove them.

To remove pins 1, 2, 7, and 8 from the connector you need to flip back the black tabs (red) above. The tabs running along the back of the connector hold the pins in place. Next you must insert a thin flathead (blue) into the bigger top opening for the correct pin (pin 1 is indicated in the picture). There is a lever (purple) inside each pin slot that stays down to prevent the pins from being removed. Use the flathead to lift the lever and pull the correct wire for the pin from the back at the same time. The pin will slide out.

Attach the red audio wire to the pin from slot 7. Attach the white audio wire to the pin from slot 8. Split the ground wire and connect one side to pin 1 and the other side to pin 2. 

![WPT164 pin removal]({{ site.baseurl }}/wp-content/uploads/2016/07/wpt164-female.jpg) ![WPT164 pin removal]({{ site.baseurl }}/wp-content/uploads/2016/07/wpt164-aux-connected.jpg)

I twisted each wire and inserted it into the free space that remained in each pin. You may find another method that works better with your resources at hand such as soldering. 

Reinsert the pins into their original connector slots. 

Create or [download](http://duramecho.com/Misc/SilentCd/) a long (30 minutes or more) silent mp3 file and burn it to a CD. The CD changer will signal to the head unit that there is a CD that can be played. Put the CD in to the CD changer and switch your head unit to play from the CD changer. The head unit will play the silent mp3 file. 

Plug your audio source into the audio cable connected to the 12 pin connector. Now you can play audio from your added audio aux input.