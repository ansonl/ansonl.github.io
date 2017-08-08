---
title: Google Plus causes grief for Titan theme users
author: Anson L
layout: post
permalink: /2012/01/google-plus-causes-grief-for-titan-theme-users
dsq_thread_id:
  - 538215143
categories:
  - Development
tags:
  - google plus
  - plusone
  - titan theme
  - white space
  - width
  - wordpress
---
[<img class="alignleft  wp-image-1319" title="Google Plus' White Space of Grief" src="https://ansonliu.com/wp-content/uploads/2012/01/whitebar.png" alt="Google Plus' White Space of Grief" width="156" height="734" />][1]You may noticed that this site has had an annoying white space on the far right side of the page.

**How:**  
If browser window was smaller than ~1300px or you resized it to smaller, the white space would appear and get bigger the more you resized it. 

**When:**  
At load time, the blog loaded fine and took up the whole screen. However, after the &#8220;main items&#8221; had loaded, and it was time for plugins and sidebar embeds to finish loading, the white space appeared. Google Plus button was in the sidebar under the <a href="https://developers.facebook.com/docs/plugins/" target="_blank">Facebook Social Plugin</a>.  
This problem must affect users of other WordPress themes using the Plus button in the sidebar besides just the Titan theme.

**Culprit:**  
The Google Plus button&#8217;s standard embed contained no width contraints.  
`<g:plusone annotation="inline"></g:plusone>`  
This way the Plus button wanted to keep a constant width — or something similar — when you resized the window. Its behavior wasn&#8217;t quite like that, but you can see from the screenshot. It got worse the smaller your browser window was.

The white space was especially bad on the iPhone and iPad because viewers had to zoom in to view the text, when before they could easily view the text without enlargement.

Fix:  
Add `width="300"` to the `` tag. the width can be anything to fit your needs although Google says that it must be from 120-450px.

Google had an option for setting the width on their <a href="http://www.google.com/intl/en/webmasters/+1/button/index.html" target="_blank">embed page</a>, but the width was preset at 450px. Even with the width preset, Google&#8217;s example code **did not** include `width="450px"` within the tags.

Fixed code:  
`<g:plusone annotation="inline" href="http://ansonliu.com" width="300"></g:plusone>`

Displays normally like so  
<g:plusone annotation="inline" width="300"></g:plusone>

 [1]: https://ansonliu.com/wp-content/uploads/2012/01/whitebar.png