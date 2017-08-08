---
title: Geometry Stash video out fix
author: Anson Liu
layout: post
permalink: /2010/09/geometry-stash-bug-fix-submitted
dsq_thread_id:
  - 529421210
categories:
  - Development
---
I finally decided to make the long overdue purchase. An iPad Dock Connector to VGA Adapter.

Back in July, I had implemented external display support into Geometry Stash with the help of Matt Gemmel&#8217;s iPad VGA Output <a rel="nofollow" href="http://mattgemmell.com/2010/06/01/ipad-vga-output">source code</a>. In July, I did not have a VGA adapter and tested Geometry Stash on the iPhone Simulator. The results looked respectable; Geometry Stash would project an enlarged version of the terms&#8217; diagrams onto the virtual display. The update even got past the Apple review team. It seemed as though everything had gone well.

<img class="alignleft size-full wp-image-75" title="geo_external_alert" src="https://i0.wp.com/apparentetch.com/wp-content/uploads/2010/09/geo_external_alert.png?resize=250%2C375" alt="" data-recalc-dims="1" />

<p style="text-align: center;">
  Matt Gemmel&#8217;s example displayed an alert to the user, allowing the user to select a desired resolution. The alert&#8217;s buttons&#8217; values were obtained the <code>screenModes</code> array. The array was structured from the lowest resolution to the highest.
</p>

<p style="text-align: center;">
  0 being 640&#215;480,
</p>

<p style="text-align: center;">
  1 being 600&#215;800,
</p>

<p style="text-align: center;">
  2 being 1024&#215;768.
</p>

<p style="text-align: center;">
  When I had first implemented the vga output, I had forgone the alert with buttons and had the app automatically pick the 0 value in the array to be set as the <code>currentMode</code>.<br /> <!--more Read More → -->The iPhone simulator screen returned a 1024&#215;768 screen size as the first value in the array (0). The external screen appeared to work as expected.
</p>

<p style="text-align: center;">
  <p style="text-align: center;">
    <p style="text-align: center;">
      <p style="text-align: center;">
        <p style="text-align: center;">
          <p style="text-align: center;">
            <p>
              I eagerly tested out the adapter connected to an iPhone 4 with a 15&#8243; Acer display. The external display support in Geometry Stash had been meant for a 1024px by 768px or greater display. The projected image was a saddening sight. The display had set itself to a 640&#215;480 resolution.The projected images leaked off the screen so that only a third of the image was actually shown. I went back to Matt&#8217;s VGA example and checked the code. Instead of choosing the 0 value, I decided that Matt&#8217;s alert worked the best and set it to appear when an external display was detected. The projection worked great after making the change as can be observed below.
            </p>
            
            <p>
              The fix has been submitted as an update that will be available in a few days. To anyone who has tried using Geometry Stash with an external screen: Sorry about the inconvenience.
            </p>
            
            <p>
              On the other note, having to pay for my own in app purchase was an injustice.
            </p>
            
            <div id="attachment_77" style="width: 210px" class="wp-caption alignleft">
              <img class="size-full wp-image-77 " title="geo_external_before" src="https://i1.wp.com/apparentetch.com/wp-content/uploads/2010/09/geo_external_before.jpg?resize=200%2C249" alt="Before the fix" data-recalc-dims="1" /><p class="wp-caption-text">
                Before
              </p>
            </div>
            
            <div style="width: 210px" class="wp-caption alignright">
              <img title="geo_external_after" src="https://i2.wp.com/apparentetch.com/wp-content/uploads/2010/09/geo_external_after.jpg?resize=200%2C249" alt="After the fix" data-recalc-dims="1" /><p class="wp-caption-text">
                After
              </p>
            </div>