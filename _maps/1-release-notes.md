---
title: "Release Notes"
layout: post
image: 
  path: /assets/images/3dprint/usaofplastic-models-thumbnail.jpg
  thumbnail: /assets/images/3dprint/release-notes.jpg
show_subscribe: true
excerpt: >
  Check out the improvements and additions in the latest 3D model update.
---

I work on each map individually and release *revisions* to each map at different times. *Major Releases* `VX.X` correspond to an approximate sync up major improvements for a region.

## Model Filename Decoder

```
STATE-ESCALING-EXTRUDER-STYLE-REVISION-PIECE##.3mf
     │                       │
     └────────VARIANT────────┘
```

| Definition | Meaning |
| ---- | ---- |
| `STATE` | State Abbreviation |
| `ESCALING` | Linear or Square Root (sqrt) elevation scaling. |
| `EXTRUDER` | Dual or Single color (extrusion) model |
| `STYLE` *(optional)* | `STYLE` is only present when the model is a special style or the model is exclusive to a special subregion. Default style is water model printed over submerged low lying lands. This submerged land may be visible when water layers are printed with a transparent filament. Default style minimizes usage of secondary (water) filament color. `transparent` style is water model features go all the way through the land for max light transmission when used with glow and transparent filaments.|
| `REVISION` | Revision number. See changelog for improvements. |
| `PIECE##` *(optional)* | Interlocking piece # for 180 mm x 180 mm bed |

### USA Regions Variant Revision in Major Release Chart

[All USA state printable models download](https://www.printables.com/@ansonl/collections/714909)

| Subregion | Variant | V1 | V2 |
| --- | --- | --- | --- |
| Lower 48 | Linear Scale | 1 | 2 |
| Lower 48 | Square Root Scale | __N/A__ | 1 |
| Alaska | Linear Scale | __N/A__ | 1 |
| Alaska | Square Root Scale | __N/A__ | 1 |
| Hawaii | Linear Scale | 1 | __N/A__ |

**Lower 48 is equivalent to Contiguous states.*

V1 - June 2023
: Initial Release

V2 - Oct 2023
: Added Square Root elevation scale models.
: Improved alignment between state borders and dual color print objects.
: Fixed Death Valley to be accurate elevation instead of a hole.
: Fixed object scale in 3MF files to import in slicers at correct size.

### Asia Region Major Release to Variant Revision Chart

| Subregion | Variant | V1 |
| --- | --- | --- |
| China | Linear Scale | __N/A__ |
| China | Square Root Scale | __N/A__ |

### Europe Region Major Release to Variant Revision Chart

| Subregion | Variant | V1 |
| --- | --- | --- |
| [Czech Republic](https://www.printables.com/model/552399-low-poly-czech-republic-ceska-republika-cz) | Low Poly | 1 |
