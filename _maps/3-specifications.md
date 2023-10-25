---
title: "Cartographic Specfications"
layout: post
permalink: /maps/specifications/
image: 
  path: /assets/images/maps/3d-printable-maps-banner.webp
  thumbnail: /assets/images/maps/map-browse-magnifier.webp
show_subscribe: false
excerpt: >
  Map projection, scale, resolution, and more. 
---

### USA Regions

| Map Specification | Value | Notes |
| ------------- | ------------- | ------------- |
| Projection | USA Contiguous Lambert Conformal Conic |
| Horizonal Scale | 1:2500000 (0.4mm:1000m) | Effective resolution is 1000m x 1000m. |
| Horizonal Scale (Alaska) | 1:2500000 (0.4mm:1000m) | Effective resolution is 2000m x 2000m. |
| Vertical Scale (Linear) | 1:500000 (0.1mm:50m) | Vertical exaggeration is 5x. Elevations 0-40m are scaled between 0 and 0.8mm on a logarithmic scale for enhanced coastal detail. |
| Vertical Scale (Square Root) | 1:500000 (0.1mm:50m) | Vertical exaggeration is greater at lower elevation and lower at higher elevation, ranging from 285-5x between sea level and ~4000m. Linear and Square Root elevation breakover at ~4000m. |
| Maritime Boundary | Submerged Lands Act | Seaward boundary of coastal states generally 3 or 9 nm from the coastline. Maritime boundaries are included in the dual print models. |
| Model Base Thickness | ~0.9mm |  |

### China

*Model is at same scale as USA. Base thickness is 4x thicker so that model can be more easily printed at 25% scale.*

| Map Specification | Value | Notes |
| ------------- | ------------- | ------------- |
| Projection | Asia North Lambert Conformal Conic |
| Horizonal Scale | 1:2500000 (0.4mm:1000m) | Effective resolution is 4000m x 4000m. |
| Vertical Scale (Linear) | 1:500000 (0.1mm:50m) | Vertical exaggeration is 5x. Elevations 0-40m are scaled between 0 and 0.8mm on a logarithmic scale for enhanced coastal detail. |
| Vertical Scale (Square Root) | 1:500000 (0.1mm:50m) | Vertical exaggeration is greater at lower elevation and lower at higher elevation, ranging from 285-5x between sea level and ~4000m. Linear and Square Root elevation breakover at ~4000m. |
| Maritime Boundary | __N/A__ |  |
| Model Base Thickness | ~3.6mm |  |
