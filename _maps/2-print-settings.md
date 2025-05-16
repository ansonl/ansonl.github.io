---
title: "3D Printing Settings"
layout: post
permalink: /maps/print-settings/
image: /assets/images/maps/3d-printable-maps-banner.webp
thumbnail: /assets/images/maps/settings-gears.svg
show_subscribe: false
excerpt: >
  3D print profiles and settings recommendations.
---

[Download the optimized Cura 4 and Cura 5 print settings profile for topo maps](https://www.printables.com/model/529276-contiguous-usa-lower-48-topographic-map-with-hydro/files).

[Updated 3D Map Model Release Notes](https://ansonliu.com/maps/release-notes/)

[Model Filename Chart & Map Specifications](https://ansonliu.com/maps/specifications/)

## Slicer Settings

> You will get best results with filament that has been [Linear Advance and Flow Rate calibrated](https://github.com/SoftFever/OrcaSlicer/wiki/Calibration).

### PrusaSlicer / Bambu Studio / Orca Slicer

Bambu Studio/ Orca Slicer default settings are already close to perfect. I recommend using below settings for better quality and lower filament usage.

| Slicer Print Setting | Recommended Value for 0.4 mm nozzle |
| ------------- |-------------|
| Layer Height | 0.12 mm |
| Default Line Width | 0.42mm |
| Top Surface Pattern | Monotonic Line |
| Infill and Infill Percentage | Lightning 30% |
| Ironing | All Top Surfaces |
| Ironing Line Spacing | 0.2 mm |
| Ironing Flow | 20-25% |
| Ironing Inset | 0.21 mm |
| Ironing Speed | 65 mm/s |
| Initial Layer Speed | ≤40 mm/s |
| Initial Layer Infill Speed | ≤80 mm/s |
| Outer Wall Speed | ≤125 mm/s |
| Inner Wall Speed | ≤200 mm/s |
| Top Surface Speed | ≤150 mm/s |
| Maximum Printing Speed for any layer | ≤200 mm/s |
| Support | None (or Tree default style for interlocking map pieces) |

If you can't find good filament settings for the Bambu X1/P1 feel free to use my settings that will print most filaments of the same material great. Spend more time printing what you want and less time "calibrating".

| Slice Filament Setting | Recommended Value for 0.4mm nozzle |
| --- | --- |
| PLA flow ratio | 0.965 |
| PLA linear advance | 0.02 |
| PLA fan speed | 90% |
| PLA bed temp | 55-60 C |


### Cura

The below settings are optimized for printing at 100% model scale using Cura 5. Classic line generation is preferred to Arachne variable line width but these Cura 5 settings have been adjusted for compensate for Arachne.

The [downloadable Cura 4/5 profiles](https://www.printables.com/model/741190-topographic-relief-map-calibrationstress-test-prin/files) contain additional optimized settings not listed below for brevity.

| Slicer Setting | Recommended Value for 0.4 mm nozzle |
| ------------- |-------------|
| Layer Height | 0.12 mm |
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
| Gradual Flow Enabled | True (for bowden/indirect printers) |
| Brim Extruder | Extruder 1 or 2 |
| Ooze Shield | Yes |

## Model Placement/Orientation

Drag (or Open) the 3MF model file into the slicer.

> In Cura 5.7+, imported objects are rearranged to be centered and not overlapping. This will misalign land and water objects in dual color models. The [workaround](https://github.com/Ultimaker/Cura/issues/18966#issuecomment-2092844603) is to run **Undo** `(Ctrl+Z)` after import to move all objects back to their original positions.

*If using Cura, **Group** objects `(Ctrl+G)` beforehand to keep multiple objects aligned.*

Print the model flat. Printers without multi-material capability should print the `*-single.3mf` models.

I have cut some larger models into smaller interlocking puzzle pieces for improved printability at 100% scale. These models end with `*pX.3mf`. The target puzzle piece size is 180mm x 180mm unless otherwise specified. Even if your printer may be able to print larger, map pieces with smaller footprints tend to print more reliably with better surface quality due to shorter movements and less retraction.

For models that have a flat side, you can try printing vertically with the flat side down if you are adventurous. Consider modifying the base in a 3D modeling software to be thicker for stability.

## Dual Color Filament

Assign your extruders/filaments to the individual objects in each model. Use glow-in-the-dark or translucent filament to show off rivers and lakes — or simply use a different color from the base land color!

### Elevation Based Color Change

You can do a manual color change mid print to get interesting color transitions at higher elevations.

If you want to swap out a color on a specific layer for a dual color print, you can add the [`M600`](https://marlinfw.org/docs/gcode/M600.html) command to generated G-code at the color change layer. I recommend only doing the filament swap on the active extruder. If the switch filament extruder is not active when starting the color change layer, you should only add `M600 T0` (if the swapped filament is in the first extruder) after the first [`T0`](https://marlinfw.org/docs/gcode/T.html) (first extruder made active) following the change layer G-code (usually indicated with a comment like `;LAYER:XX` where `XX` is the change color layer).

## Model Scaling

You can scale the model up or down as needed to fit your printer size, the final map's scale will just be scaled accordingly. *E.g. 200% scale on a previous scale of **0.4mm:1000m** results in **0.4mm:500m***

## Contribute

If you found other settings (in any slicer) to work well for you, please leave a comment to help others.
