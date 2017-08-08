---
title: Geometry Stash 2 - It's about time.
author: Anson L
layout: post
categories:
  - Development
tags:
  - geometry stash
  - update
---

<a href="http://geometrystash.com"><img src="{{ site.baseurl }}/wp-content/uploads/2015/08/geometry-stash-2-logo.png" width="256" style="border-radius: 45px;display:block;margin-left:auto;margin-right:auto;"></a>

<!---
<iframe id="videoClip" width="420" height="200" src="https://www.youtube.com/embed/_J6-3l3hCm0?autoplay=1&showinfo=0&rel=0&controls=0&color=white" frameborder="0" style="display:block;margin-left:auto;margin-right:auto;" allowfullscreen></iframe>
-->
<div style="display:block;margin-left:auto;margin-right:auto;border-style:groove;
    border-top-width: 15px;border-bottom-width: 15px;border-right-width: 20px;border-left-width: 20px;border-color: gray;" id="player"></div>
<script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="http://www.youtube.com/player_api"></script>
<script type="text/javascript">
  // create youtube player
    var player;
    function onYouTubePlayerAPIReady() {
        player = new YT.Player('player', {
          height: '200',
          width: '420',
          videoId: '_J6-3l3hCm0',
          playerVars: { 'autoplay': 1, 'controls': 0, 'showinfo': 0, 'rel': 0},
          events: {
            'onReady': onPlayerReady,
            'onStateChange': onPlayerStateChange
          }
        });
    }

    // autoplay video
    function onPlayerReady(event) {
        //event.target.playVideo();
    }

    // when video ends hide video clip
    function onPlayerStateChange(event) {        
        if(event.data === 0) {   
        /*         
            var child = document.getElementById("player");
            var parent = child.parentElement;
            parent.removeChild(child);
        */
          $('#player').slideUp("fast", function() { $(this).remove(); } );
        }
    }
</script>

<h3 style="text-align: center;">It's here.</h3><h4 style="text-align: center;">Reviewing geometry on the go has never been easier with Geometry Stash 2.</h4>
<!---<h5 style="text-align: center;"><strong>FREE</strong> for a limited time for back to school.</h5>--->

<img src="{{ "/wp-content/uploads/2015/08/iPad-air-2-iPhone-6-screenshot-landscape.png" | prepend: site.baseurl }}" width="550" style="display:block;margin-left:auto;margin-right:auto;margin-bottom:0">

Refresh your knowledge of the most commonly used theorems, postulates, and corollaries. Just swipe a term to view its diagram and description!

Make your own slides using a built in editor. Share slides in a snap using Airdrop, iCloud, Message, Mail, and more! Your creations will be rendered as vector graphics that retain their crisp and sharp edges no matter what device others and you use!

<a href="https://itunes.apple.com/us/app/geometry-stash/id324651852?mt=8"><img src="{{ site.baseurl }}/wp-content/uploads/2015/08/appstore-badge.svg" style="display:block;margin-left:auto;margin-right:auto;"></a>

• Custom slide creation: Write your own slides through drawing commands in JSON, a lightweight data-interchange format. Edit on your device, computer, anywhere.

• iCloud Drive: Access created slides on all your devices. Write on the computer and view on the go.

• Portability: Export slides as JSON, Image file, or Text.

• Guided Access: Limit editing slide functionality to keep learners on track.

• Bulk Import: Distribute multiple custom slides using a single bulk import file. Ideal for educators and administrators!

• Documentation and help available at [GeometryStash.com](http://geometrystash.com).