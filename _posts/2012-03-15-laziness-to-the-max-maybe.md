---
title: Laziness to the max (maybe)
author: Anson L
layout: post
permalink: /2012/03/laziness-to-the-max-maybe
dsq_thread_id:
  - 612959765
categories:
  - Development
  - Thoughts
tags:
  - automation
  - illustrator actions
  - ipad retina
  - keyboard macro
  - laziness
  - mechanical keyboard
  - razer blackwidow
---
Article first published as <a target="_blank" href='http://blogcritics.org/scitech/article/laziness-to-the-max-maybe/'>Laziness To The Max (Maybe)</a> on Blogcritics.

As an iOS developer, I love to update my apps whenever Apple introduces a new device! Especially that new iPad with the Retina Display.

Apple&#8217;s Retina Display has 4X the pixel density of a normal, 72 DPI display. It is essentially squeezing 4 pixels where 1 pixel should be by the method of doubling the vertical and horizontal pixel lengths. The new iPad has 2048 x 1536 pixels, twice the vertical and horizontal resolutions for the original iPad&#8217;s 1024 x 768 pixels.

App developers need to create higher resolution versions of their existing image resources in order to take advantage of the sharp screens. This resizing, reimporting, and retesting is not the fastest process. So how can we make it faster and more painless?

One of my apps is <a href="http://itunes.apple.com/us/app/geometry-stash/id324651852?mt=8" target="_blank">Geometry Stash</a>, a geometry reference. Its terms and diagrams are in the Adobe Illustrator vector format. The vector format contains data for the curves and other functions in the graphic.

<p style="text-align: center;">
  <a href="https://ansonliu.com/wp-content/uploads/2012/03/graph.png"><img class="aligncenter  wp-image-1496" title="f(x)/3 transformation" src="https://ansonliu.com/wp-content/uploads/2012/03/graph.png" alt="" width="424" height="169" /></a>
</p>

Illustrator reads the data and can make transformations accordingly without quality loss. Above, a curve is simply stretched.

• Resize the Artboard through the Artboard Tool.  
• Select all items and resize as Illustrator smartly sees the outermost-to-edge items as the edges for resizing.  
• Export &#8220;using Artboards&#8221; to constrain the images to the right size.

This process took ~18 key and mouse clicks. A waste — we&#8217;re trying to conserve energy these days!  
<center>
  <!--more-->
</center>

  
So I looked to automating Illustrator using Actions. You can get to the Actions menu by checking *Windows > Actions*.

[<img class="aligncenter size-full wp-image-1457" title="Illustrator Actions Menu" src="https://ansonliu.com/wp-content/uploads/2012/03/illustrator-actions.png" alt="" width="342" height="331" />][1]  
Create a new set AKA a folder by clicking the folder button at the bottom of the window.  
Select the created set and click the new item button to the right of the folder button.  
This item is like a macro for Illustrator. Instead of simulating key presses, however, it will run the operations that you perform.  
Select your item and click the button with the circle on it to record operations.  
Above, I recorded the operation *Select All*.  
The next item would resize both the Width and Height through *Transform*.  
Lastly, Export to a folder.

The reason that I put these operations in separate items was that the *Transform* operation would not work if placed right after the *Select All*.

I didn&#8217;t cover resizing the Artboard? Well Illustrator Actions do not support resizing the Artboard. We can use macros to do this. A macro simulates a set of key presses.  
Last year, a friend of mine (yes, developers have friends) recommended that I get a <a href="http://en.wikipedia.org/wiki/Keyboard_technology#Mechanical-switch_keyboard" target="_blank">mechanical keyboard</a>. Mechanical keyboards have springs underneath each key and are more snappy. I procured a <a href="http://www.razerzone.com/minisite/blackwidow" target="_blank">Razer BlackWidow</a> mechanical keyboard mainly for a replacement and gaming needs.  
[<img class="aligncenter size-full wp-image-1465" title="Razer BlackWidow" src="https://ansonliu.com/wp-content/uploads/2012/03/razer-blackwidow.png" alt="" width="500" height="156" />][2]  
The BlackWidow has the handy feature of being made for macros. Go figure what I did.

<p style="text-align: center;">
  <a href="https://ansonliu.com/wp-content/uploads/2012/03/razer-macros.png"><img class="aligncenter  wp-image-1459" title="Macros" src="https://ansonliu.com/wp-content/uploads/2012/03/razer-macros.png" alt="" width="536" height="397" /></a>
</p>

I recorded the following:

• *Shift + O* Go into the Artboard tool  
• *Enter* Open up the Artboard edit window  
• *Tab* Go down to the Height field  
• *2 0 4 8* Enter in a wdith to 2048, make sure that the keep proportions option is selected  
• *Enter* To confirm changes  
• *V* Switch to pointer tool in preparation for other Actions and macros

So now with one keypress, I could select, resize, and leave the Artboard. But wait, we can do more! Sometimes transforming the items did not resize correctly as Illustrator automatically sees outer items as the edge, as mentioned before. So we need to zoom out and then manually correct the error(s). No problem, there&#8217;s a macro for that!

• *Command (Press)*  
• *- &#8211; &#8211; &#8211; (dash keys)*  
• *Command (Release)*

We just zoomed out by 50% in order to readjust our viewing window to see the now-2X size graphic.

Now resizing and closing a graphic took 10 key presses that were committed to memory and done without much thought.

Exporting with the *Use Artboards* option checked adds a &#8220;-01&#8243; to the filename because Illustrator is trying to include the Artboard # in the filename. You can use Adobe Bridge to batch rename files, by selecting your files and going to *Tools > Batch Rename *and replacing the text of &#8220;-01&#8243; with &#8220;*(nothing)*&#8221; of your newly created Retina Display images.

Resizing resources for the Retina Display can be a hassle, but users will greatly enjoy your app when loading it up on their new device. A customer made happy is a customer retained. They may even share your app with others. Now you know what to do when Apple releases a Retina Display TV.

 [1]: https://ansonliu.com/wp-content/uploads/2012/03/illustrator-actions.png
 [2]: https://ansonliu.com/wp-content/uploads/2012/03/razer-blackwidow.png