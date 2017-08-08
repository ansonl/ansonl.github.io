---
title: How to create split decision landing page
author: Anson L
layout: post
permalink: /2011/02/how-to-create-a-split-decision-landing-page
dsq_thread_id:
  - 364207910
categories:
  - Development
tags:
  - landing page
  - promotion
  - SWITCH
---
Pre-req Checklist:

1. Bought domain from [SWITCH][1]. It has great pricing, by the way.

2. Connected the domain to Hostmonster.

3. Got to work.

Because I assumed that the viewer would reach this page through a promotion, I gave them a choice of either reading this development blog or browsing our created apps.

<img class="size-full wp-image-473 alignleft" title="blog snapshot" src="https://i0.wp.com/apparentetch.com/wp-content/uploads/2011/02/blog.png?resize=210%2C207" alt="blog snapshot" data-recalc-dims="1" />I took a snapshot of the [Alernalytics][2] article, as it contained UI snapshots and had a representative length, and sized it down to around 300&#215;300 pixels. This blog snapshot served as an icon to visually represent the development blog. On the offhand note, the blog also &#8220;sort of kind of&#8221; conforms to the Golden ratio&#8217;s [Fibonacci Spiral][3]

For a visual representing our created apps, nothing appeared more signifying than the iPhone Simulator icon. It&#8217;s sleek looking and conveys all there is to know. Heck, I pay $100 a year to put my apps on the App Store, I think borrowing an icon is a fair trade. If Apple ever has a problem with that, I&#8217;ll gladly change the icon. Both icons were positioned through CSS and had title text underneath them in case the choice wasn&#8217;t obvious enough.

I also added some animations and effects when the icons were moused over. I used `-webkit-transform: translate(0px,-5px);` to move the icons upwards, and `-webkit-transition: opacity 0.5s linear;` to change the opacities.

<p style="text-align: center;">
  <!--more Read More → -->
</p>

Redirecting the user to the main site seemed unwieldy and rough, so I fished around for a lightbox effect that I encountered a long time ago. Found out that it was called [GreyBox][4]. Implemented the popup window and it worked fine.

Nothing&#8217;s finished without a good background. At first, I used the Apparent Etch texture. On certain displays, the image produced visible white lines because of the brushed metal effect. In Illustrator, I drew up an overhead lamp to produce a darkroom effect.

<img class="alignleft size-medium wp-image-476" title="logo texture" src="https://i0.wp.com/apparentetch.com/wp-content/uploads/2011/02/blogtexture-300x225.png?resize=108%2C81" alt="logo texture" data-recalc-dims="1" /> <img class="alignleft size-medium wp-image-478" title="spotlight" src="https://i0.wp.com/apparentetch.com/wp-content/uploads/2011/02/spotlights-235x300.png?resize=141%2C180" alt="spotlight" data-recalc-dims="1" />

The spotlights emphasized the icons perfectly and shone through the opacity effects. There&#8217;re some tips for creating a landing page! My landing page is at [ApparentEt.ch][5]. Catchy, I know, eh?

If you want analytics for your website, I recommend [SeeVolution][6]. It provides viewer source, creates heat maps, and more!  
<img class="aligncenter size-full wp-image-485" title="site screenshot" src="https://i1.wp.com/apparentetch.com/wp-content/uploads/2011/02/site-screenshot.png?resize=400%2C289" alt="site screenshot" data-recalc-dims="1" />

If you have questions or want us to write about a particular topic (preferably iPhone development related), just tell us in the comments.

 [1]: http://www.switch.ch/
 [2]: http://ansonliu.com/2011/01/easy-analytics-with-alernalytics/ "Easy analytics in-app w/ Alernalytics on GitHub"
 [3]: http://en.wikipedia.org/wiki/File:Fibonacci_spiral_34.svg
 [4]: http://orangoo.com/labs/GreyBox/
 [5]: http://ApparentEt.ch
 [6]: http://seevolution.com/