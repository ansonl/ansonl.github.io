---
title: "Cartographic Specifications"
layout: page
permalink: /maps/specifications/
image: 
  path: /assets/images/maps/3d-printable-maps-banner.webp
  thumbnail: /assets/images/maps/map-browse-magnifier.webp
show_subscribe: false
excerpt: >
  Map projection, scale, resolution, and more. 
---

## Model Filename Chart

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
| `STYLE`* *(optional)* | Model special style or subregion. `STYLE` is only present when the model file is a special style or the model is exclusive to a special subregion. |
| `REVISION` | Revision number. See [release notes](https://ansonliu.com/maps/release-notes/) for the latest improvements. |
| `PIECE##`† *(optional)* | Interlocking pre-cut piece ## sized for 180 mm x 180 mm bed. |

**Default `STYLE` is water features model located over submerged low lying lands. This submerged land may be visible when water layers are printed with a transparent filament. Default style minimizes usage of secondary (water) filament color. `transparent` style has water model features that extend all the way through the land for maximum light transmission when used with glow and transparent filaments.*

†*If multi-part files are not present, I have not created interlocking models for this state yet. Follow me and comment with your request to get future additions and updates.*

## USA Regions

| Map Specification | Value | Notes |
| ------------- | ------------- | ------------- |
| Projection | USA Contiguous Lambert Conformal Conic | |
| Projection (Alaska) | NA Lambert Conformal Conic | |
| Projection (Hawaii) | UTM zone 4N | |
| Horizonal Scale | 1:2500000 (0.4mm:1000m) | Effective resolution is 1000m x 1000m. |
| Horizontal Scale (Alaska) | 1:2500000 (0.4mm:1000m) | Effective resolution is 2000m x 2000m. |
| Vertical Scale (Linear) | 1:500000 (0.1mm:50m) | Vertical exaggeration is 5x. Elevations 0-40m are scaled between 0 and 0.8mm on a logarithmic scale for enhanced coastal detail. |
| Vertical Scale (Square Root) | 1:500000 (0.1mm:50m) | Vertical exaggeration is greater at lower elevation and lower at higher elevation, ranging from 285-5x between sea level and ~4000m. Linear and Square Root elevation breakover at ~4000m. |
| Maritime Boundary | Submerged Lands Act | Seaward boundary of coastal states generally 3 or 9 nm from the coastline. Maritime boundaries are included in the dual print models. |
| Model Base Thickness at Sea Level | ~0.9mm | Additional +0.9mm (dual) / +0.4mm (single) for locations not covered by water. |

## China

*China model is at same scale as USA. Base thickness is 4x thicker so that model can be more easily printed at 25% scale.*

| Map Specification | Value | Notes |
| ------------- | ------------- | ------------- |
| Projection | Asia North Lambert Conformal Conic |
| Horizontal Scale | 1:2500000 (0.4mm:1000m) | Effective resolution is 4000m x 4000m. |
| Vertical Scale (Linear) | 1:500000 (0.1mm:50m) | Vertical exaggeration is 5x. Elevations 0-40m are scaled between 0 and 0.8mm on a logarithmic scale for enhanced coastal detail. |
| Vertical Scale (Square Root) | 1:500000 (0.1mm:50m) | Vertical exaggeration is greater at lower elevation and lower at higher elevation, ranging from 285-5x between sea level and ~4000m. Linear and Square Root elevation breakover at ~4000m. |
| Maritime Boundary | __N/A__ |  |
| Model Base Thickness at Sea Level | ~3.6mm | Additional +0.9mm (dual) / +0.4mm (single) for locations not covered by water. |
