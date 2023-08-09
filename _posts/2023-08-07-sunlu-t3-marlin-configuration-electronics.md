---
published: true
title: >-
  SUNLU T3 Marlin Configuration and Controller Board Pictures
author: Anson Liu
layout: post
categories:
  - travel
tags:
  - 3d printing
  - sunlu t3
excerpt: >
  SUNLU T3 printer Marlin 2 configuration can be downloaded [here](https://github.com/MarlinFirmware/Configurations/tree/import-2.1.x/config/examples/Sunlu/T3). 


  This configuration fixes a bug where the extruder cooling fan would only turn on when the motors were active and not when the extruder was hot. This could lead to heat creep and a clogged hotend if the hotend heater was left on and the motors were off.


  ![sunlu t3 bottom](/wp-content/uploads/2023/08/sunlu-t3-motherboard.JPG)
---

I created a Marlin configuration for the SUNLU T3 3D printer using the latest Marlin 2 bugfix. The configuration is now included in the MarlinFirmware/Configurations repository on Github can be downloaded [here](https://github.com/MarlinFirmware/Configurations/tree/import-2.1.x/config/examples/Sunlu/T3).

The SUNLU T3 uses a modified version of the BTT SKR Mini E3 V2 board with TMC2209 stepper drivers in [standalone mode](https://www.trinamic.com/fileadmin/assets/Products/ICs_Documents/TMC2209_datasheet_rev1.08.pdf). This means that the stepper drivers are limited as a drop in replacement for the A4988 driver and there is no runtime UART or SPI configuration communication beween the controller board and the stepper drivers.

![sunlu t3 bottom](/wp-content/uploads/2023/08/sunlu-t3-motherboard.JPG)

While creating the configuration, I fixed the fan assignment for the extruder cooling fan. The extruder cooling fan pin which was previously mismapped as the controller board cooling fan. 
With stock SUNLU T3 firmware the extruder cooling fan would only turn on when the stepper motors were active and not necessarily when the extruder was hot. If you were heating the hotend for a filament change or cleaning without moving motors the extruder was not being cooled.

![sunlu t3 bottom](/wp-content/uploads/2023/08/sunlu-t3-fan.JPG)

The actual controller board cooling blower fan located underneath the printer is hardwired to the power input so it is always on.

![sunlu t3 bottom](/wp-content/uploads/2023/08/sunlu-t3-power.JPG)

I also enabled PID temperature support for the bed heating and it works fine with the autotuned values. Not sure why SUNLU did not enable it in their firmware.

A picture of the SUNLU T3 bottom with the cover removed is below.

![sunlu t3 bottom](/wp-content/uploads/2023/08/sunlu-t3-bottom.JPG)