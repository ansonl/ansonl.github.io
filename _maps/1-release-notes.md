---
title: "Release Notes"
layout: post
image: 
  path: /assets/images/maps/3d-printable-maps-banner.webp
  thumbnail: /assets/images/maps/release-notes.jpg
show_subscribe: false
excerpt: >
  Check out the improvements and additions in the latest 3D model update.
---

**Major Releases** represent a batch improvements for a region. Individual maps are updated in **revisions** on a rolling schedule. Thus release notes for a **Major Release** cover all subregion map variants with specified **revision** numbers underneath the Variant Chart.

### Model Filename Decoder

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

## USA Regions Variant Chart

[All USA state printable models download](https://www.printables.com/@ansonl/collections/714909)

| Subregion | Variant | V1 | V2 |
| --- | --- | --- | --- |
| Lower 48 | Linear Scale | 1 | 2 |
| Lower 48 | Square Root Scale | __N/A__ | 1 |
| Alaska | Linear Scale | __N/A__ | 1 |
| Alaska | Square Root Scale | __N/A__ | 1 |
| Hawaii | Linear Scale | 1 | __N/A__ |
| Lower 48 Combined | Low Poly | 1 | __N/A__ |

**Lower 48 is equivalent to Contiguous states.*

USA V1 - June 2023
: Initial Release

USA V2 - Oct 2023
: Added Square Root elevation scale models.
: Improved alignment between state borders and dual color print objects.
: Death Valley, CA and other inland below sea level locations are now at the correct elevations instead holes.
: Maps now import into slicers at the correct size.

## Asia Region Major Release to Variant Revision Chart

| Subregion | Variant | V1 |
| --- | --- | --- |
| China | Linear Scale | 🚧 |
| China | Square Root Scale | 🚧 |

## Europe Region Major Release to Variant Revision Chart

| Subregion | Variant | V1 |
| --- | --- | --- |
| [Czech Republic](https://www.printables.com/model/552399-low-poly-czech-republic-ceska-republika-cz) | Low Poly | 1 |
