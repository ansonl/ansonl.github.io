---
title: Location aware BART Fares
author: Anson Liu
layout: post
permalink: /2010/11/location-aware-bart-fares
dsq_thread_id:
  - 667089961
categories:
  - Development
---
BART Fares didn&#8217;t have much functionality before yesterday. It would just retrieve the current fare using the BART API. I was thinking about features that bay area travelers would find useful. One feature that BART Fares was missing was the ability to locate a nearby station.

I quickly implemented this location function into the app by retrieving the latitude and longitude of the areas around the stations. After that, I simply retrieved the current location using `CLLocationManager`.

<p style="text-align: center;">
  <!--more Read More → -->
</p>

<img class="alignleft size-full wp-image-205" title="bart fares nearest station" src="https://i0.wp.com/apparentetch.com/wp-content/uploads/2010/11/bart-fares-nearest-station.png?resize=200%2C300" alt="nearest station alert" data-recalc-dims="1" />The app would store the latitude and longitude values in `double` variable types and check the user&#8217;s latitude and longitude with the stations&#8217; components. If the user was near a station (about 1 mile), the app would alert him/her and provide the locations&#8217; addresses.

I submitted the update to Apple today. If v1.3 clears Apple&#8217;s hurdles, the update will be out by next week.