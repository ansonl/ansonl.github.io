---
published: true
title: >-
  3D Map Feature Modifier (MFM) Post Processor
layout: post
image: /wp-content/uploads/2025/03/ca-topo-map-banner.webp
categories:
  - development
tags:
  - 3d printing
  - maps
  - prusaslicer
  - bambu
  - orcaslicer
excerpt: >
  Add elevation contour lines and color changes to your 3D printed maps with the free [Map Feature Modifier](https://github.com/ansonl/mfm) app!

  <video style="max-width:100%; height:auto;" width="768" height="432" autoplay loop muted playsinline>
  <source src="/wp-content/uploads/2025/03/MFM-preview-720p-10fps.webm" type="video/webm">
  </video>

  I have posted a [tutorial video](https://www.youtube.com/watch?v=3BnW-QVdqKM) that you can watch to see what is possible with the Map Feature Modifier!

---

You can add elevation contour lines and color changes to your 3D printed maps with a new script that I created.

![MFM logo](/wp-content/uploads/2025/03/MFM-header-short.webp)

The [Map Feature Modifier](https://github.com/ansonl/mfm) (MFM) script is compatible with Prusaslicer, OrcaSlicer, and Bambu Studio. It is also open source and free to use! Download it [here](https://github.com/ansonl/mfm).

<video style="max-width:100%; height:auto;" width="768" height="432" autoplay loop muted playsinline>
  <source src="/wp-content/uploads/2025/03/MFM-preview-720p-10fps.webm" type="video/webm">
</video>

## Elevation Contour Lines

Elevations contour lines (also known as isolines) show a path of constant elevation on a height map.

![map contour lines](/wp-content/uploads/2025/03/map-contour-lines.webp)

## Symbology Elevation Scale

Usually height on a map is colored along a scale as seen below.

![map color scale](/wp-content/uploads/2025/03/map-color-scale.webp)
: *ESRI*

## Bringing Cartographic Map Features to 3D Printing

Now you can add both of these features into a 3D printed map with the free Map Feature Modifier!

It is optimized for use with my free [3D printable maps](/maps). It even works on models that are not maps so you can add layered color changes in creative ways to other objects.

I made a [tutorial video](https://www.youtube.com/watch?v=3BnW-QVdqKM) showing how to use the Map Feature Modifier. All of the steps are also written to follow at your own pace on the GitHub [repo](https://github.com/ansonl/mfm).

<iframe width="560" height="315" src="https://www.youtube.com/embed/3BnW-QVdqKM?si=B7kV8L-rIug6GStB" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

Normally I would write the content of the video in a post but I just started a new job and don't have a lot of time lately so the video and Github repo documentation will need to suffice for now.

### How it works

I go into more depth on how the script works in the [internals](https://youtu.be/3BnW-QVdqKM?si=69PDapS5IXn_NaQ3&t=753
) portion at the end of the MFM tutorial youtube video. I've written a short quick explanation below.

Initially I tried simply replacing the `T` tool indices on spaced out layers to create the isolines but that leads to an oil slick effect when the top surface coincides with an isoline layer.

Instead of being layer aware, I needed to increase of the granularity of the script to be feature aware. Each printing feature is tracked so that only the outer walls (or other user selected feature type) is recolored to create isolines. The order of the printing features must also be altered to print all the outer walls at once before switching to print the inner walls or other features so that toolchanges and color swaps are kept to a minimum.

The existing toolchange and prime tower movements are also reused on demand so that new toolchanges will use the prime tower and toolchange to avoid wasted material and time from flushing.

Map Feature Modifier ended up becoming a framework that can extract and reorder G-code into relocatable and modifiable G-code segments akin to assembly [gadgets](https://www.youtube.com/watch?v=ajGX7odA87k&t=1868s).

It can run either within a slicer as a post processing script, a command line program, or a GUI app. I also added the feature for the GUI app to handle Plate Sliced 3MF which is sliced G-code that is compressed into a 3MF which is more friendly for normal users to import and preview the processed 3MF in the slicer.

## Thanks

A big thank you the below individuals as well as the 3D printing community.

- Chris Harding for his work on [TouchTerrain](https://github.com/ChHarding/TouchTerrain_for_CAGEO) and letting me contribute to the project.

- Brian Kelley from Colorado for kickstarting my initial work on Map Feature Modifier.

- Joseph Sanzo and Khor Hon Wei for trusting me with their 3D printers as guinea pigs.

- [Toybox Labs](https://toybox.com/) for filament to test.
