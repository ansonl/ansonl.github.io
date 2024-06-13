---
published: true
title: >-
  Creality K1 series Cura Start G-code
layout: post
image: 
categories:
  - development
tags:
  - 3d printing
  - creality
  - cura
excerpt: >
  Automatically set the correct extruder and bed temperature for the printed material for the Creality K1 series in Cura with the start G-code below.


  `M140 S0`


  `M104 S0`
  

  `START_PRINT EXTRUDER_TEMP={material_print_temperature} BED_TEMP={material_bed_temperature}`
---

The default Creality start G-code for the K1 printer in Cura does not automatically set the correct extruder and bed temperature and you can change the start G-code to automatically set the right temperature for your material.

Creality Slicer is now based on Orcaslicer instead of Cura but you can still use the Cura to slice for the K1. 

Creality provides some [instructions](https://sainsmart.s3.us-east-1.amazonaws.com/Creality%20K1/Cura/Creality_3D_K1_docking_cura_slice_software_operation_manual.pdf) and base Cura print profile for the K1 series which uses Klipper instead of Marlin.

The official Creality guide has the following Cura start g-code for the K1 series:

```gcode
M140 S0
M104 S0
START_PRINT EXTRUDER_TEMP=220 BED_TEMP=55
```

If your print does not change the extruder or bed temperature during the print, it will default to 220C and 55C for the temperatures. 

Instead of manually changing the start G-code to reflect the correct temperatures for your material, use G-code variables in Cura to automatically set the extruder and bed temperatures. 

Better Cura start G-code for the K1 series is:

```gcode
M140 S0
M104 S0
START_PRINT EXTRUDER_TEMP={material_print_temperature} BED_TEMP={material_bed_temperature}
```

The start G-code can be set in the printer machine settings screen. 