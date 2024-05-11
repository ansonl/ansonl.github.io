---
title: "Cartographic Specifications"
layout: page
permalink: /maps/specifications/
image: /assets/images/maps/3d-printable-maps-banner.webp
thumbnail: /assets/images/maps/map-browse-magnifier.webp
show_subscribe: false
excerpt: >
  Map projection, scale, resolution, and more. 
---

[Updated 3D Map Model Release Notes](https://ansonliu.com/maps/release-notes/)

[3D Print Settings](https://ansonliu.com/maps/print-settings/)

Unless otherwise specified for specific maps, I have designed the models for a 0.4 mm nozzle diameter and 0.1mm layer height. Recommended print settings are any multiples of these specs.

## Model Filename Chart

```
REGION-ESCALING-EXTRUDER-STYLE-REVISION-PIECE##.3mf
     │                       │
     └────────VARIANT────────┘
```

| Definition | Meaning |
| ---- | ---- |
| `REGION` | REGION Abbreviation |
| `ESCALING` | Linear or Square Root (sqrt) elevation scaling. |
| `EXTRUDER` | Dual or Single color (extrusion) model |
| `STYLE`* *(optional)* | Model special style or subregion. `STYLE` is only present when the model file is a special style or the model is exclusive to a special subregion. |
| `REVISION` | Revision number. See [release notes](https://ansonliu.com/maps/release-notes/) for the latest improvements. |
| `PIECE##`† *(optional)* | Interlocking pre-cut piece ## sized for 180 mm x 180 mm bed. |

**Default `STYLE` is water features model located over submerged low lying lands. This submerged land may be visible when water layers are printed with a transparent filament. Default style minimizes usage of secondary (water) filament color. `transparent` style has water model features that extend all the way through the land for maximum light transmission when used with glow and transparent filaments.*

†*If multi-part files are not present, I have not created interlocking models for this state yet. Follow me and comment with your request to get future additions and updates.*

## Lower 48 (Contiguous) USA Map with Borders

| Map Specification | Value | Notes |
| ------------- | ------------- | ------------- |
| Projection | USA Contiguous Lambert Conformal Conic | |
| Horizontal Scale | 1:20000000 (0.4mm:8000m) | Effective resolution is 2000m x 2000m. |
| Vertical Scale (Linear) | 1:500000 (0.1mm:50m) | Vertical exaggeration is 40x. |
| Vertical Scale (Logarithm) | 1:500000 (0.1mm:50m) | Vertical exaggeration ranges from 27000-45x. Scaling is greater at lower elevation and lower at higher elevation. 45x is at ~5000m elevation.|
| 3D Model Resolution | 0.1mm | |
| Highlights | State borders | |
| Model Base Thickness at Sea Level (Linear) | 5mm | |
| Model Base Thickness at Sea Level (Logarithm) | 2mm | |

---

## USA Individual Regions

Download on [Printables](https://www.printables.com/@ansonl/collections/714909)

| Map Specification | Value | Notes |
| ------------- | ------------- | ------------- |
| Projection | USA Contiguous Lambert Conformal Conic | |
| Projection (Alaska) | NA Lambert Conformal Conic | |
| Projection (Hawaii) | UTM zone 4N | |
| Horizontal Scale | 1:2500000 (0.4mm:1000m) | Effective resolution is 1000m x 1000m. |
| Horizontal Scale (Alaska) | 1:2500000 (0.4mm:1000m) | Effective resolution is 2000m x 2000m. |
| Vertical Scale (Linear) | 1:500000 (0.1mm:50m) | Vertical exaggeration is 5x. Elevations 0-40m are scaled between 0 and 0.8mm on a logarithmic scale for enhanced coastal detail. |
| Vertical Scale (Square Root) | 1:500000 (0.1mm:50m) | Vertical exaggeration ranges from 285-5x between sea level and ~4000m. Scaling is greater at lower elevation and lower at higher elevation, . Linear and Square Root elevation breakover at ~4000m. |
| 3D Model Resolution | 0.1mm | |
| 3D Model Resolution (Alaska) | 0.2mm | |
| Highlights | Streams, Lakes, Coastlines | |
| Maritime Boundary | Submerged Lands Act | Seaward boundary of coastal states generally 3 or 9 nm from the coastline. Maritime boundaries are included in the dual print models. |
| Model Base Thickness at Sea Level | ~0.9mm | Additional +0.9mm (dual) / +0.4mm (single) for locations not covered by water. |

---

## USA Hyper Local Regions

### Williamstown, MA, USA - Dual Color (NOV2023)

Download on [Printables](https://www.printables.com/model/638568-williamstown-ma-usa-framed-topo-map-with-roads-and)

| Map Specification | Value | Notes |
| ------------- | ------------- | ------------- |
| Projection | UTM 18N | |
| Horizontal Scale | 1:36000 (0.5mm:18m) | Effective resolution is 20m x 20m. |
| Vertical Scale (Linear) | 1:36000 | |
| 3D Model Resolution | 0.2mm | |
| Highlights | Water, Highways, Streets |  |
| Model Base Thickness at Sea Level | 0.0mm | Additional +0.27mm for unhighlighted locations. |

### Oahu, HI, USA - Dual Color (NOV2023)

[Download Regular](https://www.printables.com/model/548923-oahu-hi-topographic-map-with-coastal-outline-for-g)

[Download Low Poly](https://www.printables.com/model/550996-low-poly-oahu-hi-with-coastal-outline-for-glow-in-)

| Map Specification | Value | Notes |
| ------------- | ------------- | ------------- |
| Projection | UTM 4N | |
| Horizontal Scale | 1:500000 (0.4mm:200m) | Effective resolution is 200m x 200m. |
| Vertical Scale (Linear) | 1:100000 (0.1mm:10m) | Vertical exaggeration is 5x. Elevations 0-40m are scaled between 0 and 0.8mm on a logarithmic scale for enhanced coastal detail. |
| Highlights | Coastal Outline |  |
| Model Base Thickness at Sea Level | 1.2mm | Additional +0.27mm for unhighlighted locations. |

---

## China

*China model is at same scale as USA except for the following. Streams and base thickness are 4x thicker so that model can be more easily printed at 25% scale.*

Download on [Printables](https://www.printables.com/model/656330-china-mainlandhainantaiwan-3d-topo-relief-map-with)

| Map Specification | Value | Notes |
| ------------- | ------------- | ------------- |
| Projection | Asia North Lambert Conformal Conic |
| Horizontal Scale | 1:2500000 (0.4mm:1000m) | Effective resolution is 4000m x 4000m. |
| Vertical Scale (Linear) | 1:500000 (0.1mm:50m) | Vertical exaggeration is 5x. Elevations 0-40m are scaled between 0 and 0.8mm on a logarithmic scale for enhanced coastal detail. |
| Vertical Scale (Square Root) | 1:500000 (0.1mm:50m) | Vertical exaggeration is greater at lower elevation and lower at higher elevation, ranging from 285-5x between sea level and ~4000m. Linear and Square Root elevation breakover at ~4000m. |
| 3D Model Resolution | 0.2mm | |
| Highlights | Streams, Lakes | 4000m wide lines |
| Model Base Thickness at Sea Level | ~1.2mm | Additional +0.9mm (dual) / +0.4mm (single) for unhighlighted locations. |
