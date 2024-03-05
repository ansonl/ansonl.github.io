---
title: "3D Printing Settings"
layout: post
permalink: /maps/print-settings/
image: 
  path: /assets/images/maps/3d-printable-maps-banner.webp
  thumbnail: /assets/images/maps/settings-gears.svg
show_subscribe: false
excerpt: >
  3D print profiles and settings recommendations.
---

[Download the optimized Cura 4 and Cura 5 print settings profile for topo maps](https://www.printables.com/model/529276-contiguous-usa-lower-48-topographic-map-with-hydro/files).

[Updated 3D Map Model Release Notes](https://ansonliu.com/maps/release-notes/)

[Model Filename Chart & Map Specifications](https://ansonliu.com/maps/specifications/)

## Model Placement/Orientation

Print the model flat. You can do a manual color change mid print to get interesting color transitions at higher elevations. Printers without multi-material capability should print the `*-single.3mf` models.

I have cut some larger models into smaller interlocking puzzle pieces for improved printability at 100% scale. These models end with `*pX.3mf`. The target puzzle piece size is 180mm x 180mm unless otherwise specified. Even if your printer may be able to print larger, map pieces with smaller footprints tend to print more reliably with better surface quality due to shorter movements and less retraction.

For models that have a flat side, you can try printing vertically with the flat side down if you are adventurous. Consider modifying the base to be thicker for stability.

## Filament

Assign your extruders/filaments to the individual objects in each model. Use glow-in-the-dark or translucent filament to show off rivers and lakes — or simply use a different color from the base land color! 

## Model Scaling

You can scale the model up or down as needed to fit your printer size, the final map's scale will just be scaled accordingly. *E.g. 200% scale on a previous scale of **0.4mm:1000m** results in **0.4mm:500m***

*If you rotate or scale models to fit your printer in Cura, grouping or merging objects `(Ctrl+G)/(Ctrl+Alt+G)` beforehand will help keep the dual color print objects aligned.*

## Slicer Settings

The below settings are optimized for printing at 100% model scale using Cura 5. Users have reported good results changing equivalent settings in Prusaslicer/Bambu Studio. Classic line generation is preferred to Arachne variable line width but the settings have been adjusted for compensate for Arachne. 

The [downloadable Cura 4/5 profiles](https://www.printables.com/model/741190-topographic-relief-map-calibrationstress-test-prin/files) contain additional optimized settings not listed below for brevity.

| Slicer Setting | Recommended Value for 0.4 mm nozzle |
| ------------- |-------------|
| Layer Height | 0.1 mm |
| Line Width | 0.4 mm |
| Minimum Thin Wall Line Width | 0.2 mm |
| Top Surface Skin Layers | 2 |
| Top Surface Skin Pattern | Lines |
| Skin Overlap | 20% |
| Top/Bottom Flow | 100% |
| Top Surface Skin Flow | 100% |
| Infill and Infill Percentage | Lightning 30% |
| Ironing Line Spacing | 0.2 mm |
| Ironing Flow | 20% |
| Ironing Inset | 0.34 mm |
| Ironing Speed | 60 mm/s |
| Brim Extruder | Extruder 1 or 2 |
| Ooze Shield | Yes |

## Feedback

If you found a certain setting works well for you, please leave a comment!
