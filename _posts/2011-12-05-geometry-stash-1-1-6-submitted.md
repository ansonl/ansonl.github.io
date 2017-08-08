---
title: 'Geometry Stash 1.1.6 submitted [Updated]'
author: Anson Liu
layout: post
permalink: /2011/12/geometry-stash-1-1-6-submitted
dsq_thread_id:
  - 494793586
categories:
  - Development
  - Thoughts
tags:
  - "@2x"
  - automator
  - geometry stash
  - retina display
---
<p style="text-align: center;">
  <img class="size-full wp-image-1154 aligncenter" title="Retina Display graphics" src="https://i2.wp.com/apparentetch.com/wp-content/uploads/2011/12/retina-terms.png?resize=333%2C477" alt="Retina Display graphics" data-recalc-dims="1" /><br /> With hi-res diagrams for the iPhone 4/4S and 4th generation iPod Touch!
</p>

<img class="alignleft size-full wp-image-1170" title="Input & Output folders" src="https://i0.wp.com/apparentetch.com/wp-content/uploads/2011/12/nice.png?resize=98%2C78" alt="Input & Output folders" data-recalc-dims="1" />Automator was used to quickly convert the files enmasse. We created the iPad&#8217;s term diagram images at the same aspect ratio as the iPhone version&#8217;s. This way, it was a simple matter of resizing the image&#8217;s widths as 640px (in this case).

&#8211; The image files were pointed to the script by using Automator&#8217;s built in Folder Actions. The input was any file dropping into the &#8216;input&#8217; folder.  
&#8211; Image was resized to 640px using **Scale Images**  
&#8211; Appended &#8216;@2x&#8217; to the filename usind **Add Text**  
<small>Note: Appending &#8216;@2x&#8217; is just an easy way of pointing retina display devices to the hi-res image.</small>  
&#8211; The final step was to move the &#8220;finished&#8221; file into the &#8216;output&#8217; folder in order to avoid confusion. Used **Move Finder Items**

&#8211; You can import the files into Xcode afterwards. *Drag n drop*

<p style="text-align: center;">
  No delays expected for Geometry Stash&#8217;s approval — well not like<br /> <a title="Geometry Stash: Back in Action [UPDATE]" href="http://ansonliu.com/2011/05/geometry-stash-back-in-action/">what happened before</a>&#8230;
</p>

**Update:** Geometry Stash 1.1.6 has been released.