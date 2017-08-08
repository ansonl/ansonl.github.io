---
title: Disqus Discovery on an Ad Free blog does not compute
author: Anson L
layout: post
permalink: /2013/03/disqus-discovery-on-an-ad-free-blog-does-not-compute
dsq_thread_id:
  - 1156688107
categories:
  - Development
  - Thoughts
tags:
  - ad free blog
  - comments
  - DISQUS
  - turn off discovery
---
With the Disqus update a few months ago, some users pointed out the commenting service&#8217;s <a href="http://help.disqus.com/customer/portal/articles/666278-introducing-promoted-discovery-and-f-a-q-" target="_blank">Discovery</a> feature. The Discovery feature shows links to other sites&#8217; content at the bottom of your posts.  
[<img class="aligncenter size-medium wp-image-2466" alt="Disqus Discovery feature" src="https://ansonliu.com/wp-content/uploads/2013/03/discovery-300x49.png" width="300" height="49" />][1]  
When I checked to see if the feature was active on my site when the Discovery feature was released, it did not appear active so I left Disqus alone.

So cue surprise when I was reading comments on one of my posts and I saw an outbound link to another site placed below the comments section.  
<center>
  <!--more-->
</center>

  
<a href="http://www.adfreeblog.org/" target="_blank"> <img class="alignleft" alt="" src="https://i1.wp.com/www.adfreeblog.org/adfreebutton.jpg?w=625" data-recalc-dims="1" /></a>Profit from referrals is considered a form of advertising and is not compatible with the spirit of the Ad Free Blog.

Disqus should not be putting what is equivalent to advertising on our sites without first getting explicit consent from the owner.  
They should show a message to the admin the next time the admin logs into Disqus asking if the admin would like the Discovery feature enabled on their site.

So all default installations and updates of Disqus have Discovery settings set to *Increased Traffic* as shown below when managing Disqus in *Admin > Settings > Discovery*.

[<img class="aligncenter size-medium wp-image-2467" alt="Disqus Discovery Default Options" src="https://ansonliu.com/wp-content/uploads/2013/03/defaultoptions-300x135.png" width="300" height="135" />][2]

Get rid of Disqus Discovery recommendations by selecting the *Just Comments* radio button and save your changes.

[<img src="https://ansonliu.com/wp-content/uploads/2013/03/justcommentsoption-300x96.png" alt="Turn off Disqus Discovery" width="300" height="96" class="aligncenter size-medium wp-image-2474" />][3]

Disqus is still one of the best commenting platforms available due to its ease of installation and configuration and numerous features which make commenting on a website for users seamless.  
Besides Disqus freeloading activity off of sites whose admins haven&#8217;t configured Discovery yet (site owners may input a Paypal email for payment for referrals), this shows how Disqus can make radical changes their commenting platform without updating the <a href="http://wordpress.org/extend/plugins/disqus-comment-system/" target="_blank">Disqus WordPress plugin</a>.  
This ability make changes to what is displayed on blogger&#8217;s posts without site owner intervention raises security concerns as to the effect of Disqus&#8217; backend being compromised. In the unlikely event that something did happen, an attacker could exploit XSS and other wide range of attacks through attaching a malicious payload to the <a href="http://disqus.com/audience/" target="_blank">1.8 million websites</a> that Disqus is used on.

 [1]: https://ansonliu.com/wp-content/uploads/2013/03/discovery.png
 [2]: https://ansonliu.com/wp-content/uploads/2013/03/defaultoptions.png
 [3]: https://ansonliu.com/wp-content/uploads/2013/03/justcommentsoption.png