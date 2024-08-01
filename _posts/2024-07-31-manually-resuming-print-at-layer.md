---
published: true
title: >-
  Manually Resuming a Failed Print at a Specific Layer
layout: post
image: 
categories:
  - development
tags:
  - 3d printing
  - cura
excerpt: >
  Easily resume a failed print at a specific layer by trimming the start of your G-code file and adding the below resume start G-code.


  `M140 Sxx ; Start heating bed`


  `G28`


  `M109 T0 Sxxx ; Heating to PLA temp`


  `G92 Exxx ; Set extruder position`


  `G0 Zxx.xx ; Set Z position`


  `G1 F1500 Exxx`


  More detailed instructions are in the full post.
---

If your print fails due to an extruder error you can usually resume printing from the last successful layer if your print has not detached from the bed. Manually creating the resume G-code may be needed if your printer does not have a built in recovery function. The exact steps need some G-code modification that is hard to get right the first time by trial and error.

1. Pause or Stop the print.

    > **Pause** is preferred instead of **Stop** to keep the stepper motors energized and from losing position for printers that home Z by determining 0 for Z (moving the printhead towards the bed). If your printer homes the Z axis by moving to the maximum Z value (moving the printhead away from bed), you can safely use **Stop** instead of **Pause**. If the Z axis motor turns off, you will permanently lose the Z position for this print if your printer homes towards the bed (Z0).

2. Set the bed temperature to the original printing bed temperature. This will keep the printed object attached to the bed while you prepare the modified G-code.

3. Measure the partially printed object's height with calipers or a ruler.

4. Open the print job G-code file in your slicer or G-code viewer. This is the same file that you originally placed on your printer SD card or Octoprint. Browse the layers of the preview until your find the last successful layer.

5. Open the same G-code file in a text editor such as Visual Studio Code.

6. Use the Find feature in the text editor to locate layer change lines starting with `;LAYER:` or `; LAYER`.  
Find the layer change line that has the layer number for the last successful layer in the G-code preview.  
*OR*  
Find the first layer change line that comes after a movement line that looks like `G0 .... ZXX.XX` or `G1 .... ZXX` where `XX` is the partially printed object's layer height you physically measured.  
**In both cases, remember the last Z position found before the layer change line. It will look like `Zxx.xx` where `xx.xx` are numbers.**


7. Remove all lines from the start of the file up to the layer change line. A quick way to do this in VS Code:
    - Click the start of the layer change line.
    - Move up to the first line of the file using the scroll bar.
    - Hold **Shift** and click the start of the first line to select all text up to the previously clicked location.
    - Backspace or Delete to remove all the selected text

8. Copy one of the below resume start G-codes at the first line.  
    - **Only for slicers and printers set to Absolute Extruder Position.** Replace both `Exxx` with the first `E` + following digits found after the layer change line. This will set the extruder position to the expected last extruder position in the G-code.
    - Replace `Zxx.xx` with the last Z position you previously found before the layer change line.
    - Replace bed and nozzle temperature if you have custom values.
    - Remove `G28` if your printer homes towards the 0 Z direction (towards the bed) and you **Paused** the print.

9. Save the G-code file with a new name. Move the G-code file to your printer. Print the modified G-code file (you may need to **Stop** the print to start the new file).

**PLA**

```gcode
M140 S60 ; Start heating bed
G28
M109 T0 S210.0 ; Heating to PLA temp
G92 Exxx
G0 Zxx.xx
G1 F1500 Exxx
```

**PETG**

```gcode
M140 S90 ; Start heating bed
G28
M109 T0 S245.0 ; Heating to PETG temp
G92 Exxx
G0 Zxx
G1 F1500 Exxx
```
