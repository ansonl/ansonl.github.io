---
title: 'Reviving an &#039;old&#039; app with leader boards'
author: Anson L
layout: post
permalink: /2010/12/reviving-an-old-app-with-leader-boards
dsq_thread_id:
  - 383193738
categories:
  - Development
tags:
  - game center
  - leader board
  - reflex rush
  - update
---
<a rel="nofollow" href="http://itunes.com/apps/reflexrush">Reflex Rush</a> was created over a year ago. I&#8217;ve incrementally been adding small updates since then. The most recent — and probably the last — update released today added Game Center leader boards.

When the game was first released, players would just tilt and set a personal high score. There wasn&#8217;t much of a connected vibe to it. After adding Game Center achievements to BART Fares, I decided to experiment with leader boards in Reflex Rush. It was a good combination: fastest time and global rank. The code was very simple. Add the GameKit framework and put in a few lines of code to send the score. I created a separate leader board for each threshold (number of tilts in a certain amount of time).

<img class="aligncenter size-full wp-image-319" title="reflex rush leaderboards" src="https://i1.wp.com/apparentetch.com/wp-content/uploads/2010/12/reflex-rush-leaderboards.png?resize=500%2C333" alt="reflex rush leaderboards" data-recalc-dims="1" />

<p style="text-align: center;">
  <!--more Read More → -->
</p>

As you can see, there&#8217;s only one person on the leader board right now. Hopefully more people will give Reflex Rush a try, it&#8217;s a free game.

I don&#8217;t foresee writing any more functionality updates for Reflex Rush in the near future. Have any ideas? Tell me below.