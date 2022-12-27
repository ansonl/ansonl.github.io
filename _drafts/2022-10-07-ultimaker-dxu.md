---
published: false
excerpt: >
  NAVADMIN Viewer has provided 80k+ sailors with quick access to messages for
  over 4 years. See the feature chart and roadmap within. 


  ![NAVADMIN Viewer
  icon](/wp-content/uploads/2022/09/navadmin-viewer-Icon128.png)


  NAVADMIN Viewer for iOS now has the Extended Access in-app purchase to support
  development and offset operating costs. Existing users can continue viewing
  the 3 latest messages. Extended Access ($4.99/year) unlocks all messages.


  Why is there Extended Access? Please read the backstory in the post. 
author: Anson Liu
layout: post
categories:
  - development
tags:
  - ultimaker
title: Ultimaker DXU for UMO+
---

I wanted to upgrade my Ultimaker Original+ to dual extrusion but the official Ultimaker Original dual extrusion upgrade kit is no longer sold and the Ultimaker 2+ has no official support for dual extrusion.  I found the Ultimaker DXU modification in a [post on the Ultimaker community forum](https://community.ultimaker.com/topic/24553-dxu-efficient-dual-extrusion-upgrade-for-um2/) that upgrades the Ultimaker 2 to dual extrusion using a new printhead with dual switching nozzles.

I previously [upgraded my Ultimaker Original+](https://youtu.be/7RS4vpQ70ag) with cloned components of the [Ultimaker 2+ Extrusion Upgrade Kit](https://support.ultimaker.com/hc/en-us/articles/360011988380-The-Extrusion-Upgrade-Kit-for-the-Ultimaker-2) sourced from AliExpress (under $150 on AliExpress vs $500 for the official kit) using [Neotko's instructions](https://www.youmagine.com/designs/um2-upgrade-on-umo-assembly-manual).

### What usually happens when switching between two materials

When a print needs to switch between the 2 materials loaded in each nozzle, the active nozzle that was printing performs a retraction on the material and decreases the hotend temperature to a lower standby temperature (ex: 175C for PLA). Retraction releases the pressure on the filament and pulls it back into the nozzle. Lowering the hotend temperature quickly enough makes the filament solidify and not ooze through the nozzle opening. In reality retraction has a short lag time due to the long bowden (indirect drive) setup of the Ultimaker and the hotend does not cooldown very fast. Filament ends up oozing for a few seconds and catches onto the print. 3D slicing software can generate prime towers and ooze shields to catch dribbling filament and minimize most of the oozing effects.

<figure>

![Cura prime tower](/wp-content/uploads/2022/10/cura_prime_tower.png)
<figcaption><b>Cura Prime Tower</b></figcaption>

</figure>

The green and white colors represent two different materials such as green and white PLA. When an inactive nozzle is used for the first time on a layer, the filament in it may not come out of the nozzle at the correct pressure or volume needed to adhere to the print. The pushing pressure created by the feeder hasn't caught up in the hotend and the nozzle may not heat up quickly enough. The printer needs to extrude a minimum length of filament to ensure a consistent flow of material from the nozzle. This minimum length is set by the user in the slicing settings. The printer also wipes the inactive nozzle ooze by moving it back and forth the across edge of the prime tower.

An ooze shield is usually a single layer shell generated at an offset from the outside of a 3D model. The height of this shell grows during printing equal to the current layer height and is meant to catch any oozing from the nozzles as the printhead travels between the prime tower and object.

### Multiple Extrusion Implmentations

- Fixed Dual Nozzles
- Y-splitter Hotend
- Switching Hotend/Extruder
- Switching Nozzle
- Filament Loader Switcher/Multi-Material Unit

### Fixed Dual Nozzles

Fixed dual nozzles are two nozzles that do not move independently of each other AND do not change their Z offset.

![um2 dual nozzle printhead](/wp-content/uploads/2022/10/um2-dual-nozzle-printhead.jpg)
![um2 dual nozzle assembled](/wp-content/uploads/2022/10/um2-dual-nozzle-assembled.jpg)

The official and clone UM2+ printheads are capable of dual extrusion with the installation of a second feeder and nozzle. Depending on where you source the printhead it may come predrilled with a second hole for the second nozzle. Both nozzles are fixed in place and the offset between them does not change once installed. This **fixed dual nozzle** printhead prints dual extrusion prints fine but quality issues occur when the 2 nozzles have any height difference and filament oozes from the inactive nozzle. A nozzle that is over a tenth of a millimeter lower than the other nozzle will touch the printed object when it is not meant to be used and dislodge the print from the bed.

![e3d chimera](/wp-content/uploads/2022/10/e3d-chimera.jpg)
![ultimaker chimera](/wp-content/uploads/2022/10/ultimaker-chimera.jpg)

Third party fixed dual nozzles are sometimes sold under names such as Chimera.

### Y-splitter Hotend

Y-splitter hotends have two or more seperate feeders that feed multiple strands of filament into a single hotend. Only the active feeder feeds filament at a given time so that correct material is extruded from the nozzle. Different filaments can be extruded together to intentionally create a mixed material with a custom shade of color. Because only one nozzle is used, Y-splitters as space efficient and there is no loss of build space.

Material changes must be anticipated beforehand by the slicer as the previous material needs to be flushed out of the distance between the splitter and the nozzle. Unwanted mixing of material may occur if the previous material is still in the hotend. The splitter must be kept hot so that filament from multiple paths are kept soft enough to be fed into the hotend. Retraction is tricky because filament may not be completely retracted into the correct side of the splitter. I did not try a Y-splitter hotend due to above drawbacks and lack of slicer support.

![Prusa MMU1](/wp-content/uploads/2022/10/prusa-mmu1.jpg)

[Prusa Multi Material Upgrade 1 (MMU1)](https://help.prusa3d.com/tag/mmu1) is a 4-in-1-out splitter setup. 4 extruder motors, one for each of the 4 materials fed filament into the printhead.

![seemecnc 2 into 1](/wp-content/uploads/2022/10/seemecnc-2-into-1.jpg)
![e3d cyclops](/wp-content/uploads/2022/10/e3d-cyclops.jpg)
![diamond hotend reprap](/wp-content/uploads/2022/10/diamond-hotend-reprap.jpg)

Y-splitter hotends are also referred to as 2-in-1-out, Cyclops, MMU1, or [Diamond Hotend](https://reprap.org/wiki/Diamond_Hotend) depending on the maker.

### Switching Hotend/Extruder or IDEX

Switching hotend setups have multiple separate printheads. Each printhead has its own feeder and nozzle. One printhead is active at a time and the printer switches between them. The inactive printhead is usually docked on one of the sides of the printer.

<figure>

![cura mark2 reduced print space](/wp-content/uploads/2022/10/cura-mark2-print-space.jpg)
<figcaption><b>Reduced print space using Ultimaker Mark2</b></figcaption>

</figure>

When printing dual materials with a switching hotend, print space is reduced by the offset distance of the nozzles on each side of the offset axis. Each nozzle is unable to print at the start/end limit of the other nozzle due to 2 hotends sharing the same movement space. Lost print space can be reduced by giving the hotends a farther range of movement than the print bed which shifts the print space limitation to the print bed size.

![Ultimaker Mark2](/wp-content/uploads/2022/10/mark2.jpg)
![Ultimaker Mark2 attached](/wp-content/uploads/2022/10/mark2-attached.jpg)
![Ultimaker Mark2 docked](/wp-content/uploads/2022/10/mark2-docked.jpg)

The [Ultimaker Mark2](https://magnetic-tool-changer.com/) uses a switching hotend. The second hotend is docked in the corner of printer frame. When the second material needs to be used, the primary hotend magnetically grabs onto the second hotend and prints with it. The Mark2 loses a relatively large amount of printable space due to the large offset between the nozzles and docking area.

![Craftbot IDEX](/wp-content/uploads/2022/10/craftbot-idex.jpg)

Independent extruder (IDEX) printers are a subset of switching hotend setups in which each extruder has the capability to dynamically adjust offset in an axis.

![Dondolo switching extruder](/wp-content/uploads/2022/10/dondolo-switching-extruder.jpg)

In the direct drive Dondolo switching setup above, both the extruder and nozzle are "switched" by a rotating printhead. For consistency, we refer to the earliest part of the filament path that has its offsets switched, this is a **switching extruder** because the extruder motor is mounted on the printhead with the hotend in a direct drive setup and gets offset. The term "switching extruder" is not accurate for indirect drive/bowden printers because the extruder/feeder is not located on the printhead. The majority of dual/multi-material printing methods utilize a distinct extruder for each material so they are all technically "switching extruders".

### Switching Nozzles

Switching nozzles have a mechanism to physically raise the inactive nozzle higher than the inactive nozzle. The Z (height) offset between the nozzles of a few millimeters is usually sufficient to accomodate sub-millimeter nozzle height variations. The raised inactive nozzle will not touch the printed object and can compensate for slight oozing because the ooze may not hang low enough to touch the print. Switching nozzles are not as practical if more than two nozzles are desired due to increasing printhead weight and lack of firmware support. I haven't seen a switching nozzle setup with more than 2 nozzles yet.

![cura dxu reduced print space](/wp-content/uploads/2022/10/cura-dxu-print-space.jpg)

Just like switching extruders, switching nozzles lose print space equal to the offset distance of the nozzles in the offset axis. Due to not having two separate printheads, soace lost is usually less than that of a switching hotend.

![dxu top](/wp-content/uploads/2022/10/dxu-top.jpg)
![dxu nozzle switched](/wp-content/uploads/2022/10/dxu-nozzle-switched.jpg)


The **Ultimaker DXU is a dual switching nozzle** hotend that uses a mechanical lever to raise and lower one nozzle on the right side of the printhead. The DXU lever mechanism has enough vertical range of motion for first nozzle that it will be in either one of two heights:

1. Raised above the second nozzle when inactive
2. Lowered below the second nozzle when active

### Filament Loader Switcher / Multi-Material Unit

Filament loader switchers swap the filament before filament enters the extruder/feeder. New higher end printers use this method for several huge advanges:

- No loss of print area
- Theoretically unlimited material switching
- Material switching is decoupled from the printhead and extruder/feeder. Less complex printhead means less to go wrong.

The number of possible materials that can be used in a single print is theoretically unlimited and independent of the core printer extruder train that consists of the extruder, printhead, and everything in between. Rather than alter and work around a printer's extruder train, a new filament loader switcher is added before the extruder. The number of materials that can be fed into the extruder is now limited by this filament loader switcher.

The [Prusa Multi Material Upgrade 2S (MMU2S)](https://blog.prusa3d.com/multi-material-upgrade-2-0-is-here_8700/) and [Ultimaker Material Station](https://support.ultimaker.com/hc/en-us/articles/360011547780-Printing-with-the-Material-Station) are two commercial filament loader switchers available to consumers.

![Prusa MMU2S front](/wp-content/uploads/2022/10/mmu2s-loader-front.jpg)
![Prusa MMU2S back](/wp-content/uploads/2022/10/mmu2s-loader-back.jpg)

The Prusa MMU2S mounts the input end of the filament guide tube on a horizontal gantry with 4 filaments spaced out along the gantry. The beginning of the guide tube is slid along the gantry to match the active filament fed through it to the extruder. Prusa's own video describes the switching mechanism best.

![Ultimaker Material Station](/wp-content/uploads/2022/10/ultimaker-material-station.jpg)

The Ultimaker Material Station does not actually ship with the capability to dynamically switch unloaded filaments mid-print due to reliability concerns by Ultimaker but the Material Station is technically a filament loader switcher that unloads and loads 6 different filaments to a single printhead.
