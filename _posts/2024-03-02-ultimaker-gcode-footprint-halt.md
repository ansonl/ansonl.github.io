---
published: true
title: >-
  Ultimaker S-line 3D Printer Firmware Bed Leveling Triggers a Soft Reset
author: Anson Liu
layout: post
image: /wp-content/uploads/2024/02/black_and_orange_printed_circuits_boards.webp
categories:
  - development
tags:
  - 3d printing
  - ultimaker
  - firmware
  - python3
excerpt: >
  The Ultimaker S-line printer has an optimized bed leveling procedure that speeds up the preparation process to get printing. 

  
  This bed leveling procedure can trigger a shutdown and require a soft-reset when a sufficiently complex model or G-code without Cura style layer indicators is printed.


  ![Ultimaker system error](/wp-content/uploads/2024/02/UM-ER998.jpg)


  Let's find out what is causing this error and possible solutions for both Ultimaker and users. 
---

The [Ultimaker](https://ultimaker.com/) S-line printer has an optimized bed level probing procedure where the printer can calculate the bottom footprint of G-code model and only probe the bed where necessary — only where the printed model will touch the bed. Klipper firmware's [adaptive bed meshing](https://www.klipper3d.org/Bed_Mesh.html#adaptive-meshes) speeds up bed mesh generation (leveling) in a similar way.

![adaptive bed mesh](/wp-content/uploads/2024/02/adaptive_bed_mesh_margin.svg)
: *Source: Klipper*

## The Issue

Recently, I found a bug where the Ultimaker S-line firmware will hang and fail to print 3D models with a complex bottom layer or no `;LAYER:` comments. When these conditions influenced by the 3D model and exported G-code worsen, the footprint discovery will not finish within a time limit and the Ultimaker printer requires a soft reset.

![Ultimaker system error](/wp-content/uploads/2024/02/UM-ER998.jpg)
: *Source: Ultimaker forum (A similarly cryptic, but not as print-ending error)*

What the user sees will be:

1. Ultimaker S-line printer homes the printhead and bed.

2. The bed and nozzles preheat.

3. The bed raises for bed probing using the nozzles.

4. The bed stops moving before touching the probing nozzle. The printer will wait.

5. After a few minutes, the bed Z-axis stepper motor is powered down due to inactivity and the bed may slide down.

6. Eventually the printer will show an [error](https://support.makerbot.com/s/article/1667412700787):

> An unspecified error has occurred in the motion controller. Restore to default settings.

The printer user interface will show one action available to **Reboot**. After rebooting and trying to run the print, it's clear that the same error will occur.

> **Note:** I added AI generated header images to break up the walls of text in this post and keep things interesting for non-technical readers.

## Ultimaker S-line Printer Architecture

Ultimaker S-line 3D printers run both a linux kernel and Marlin firmware. The touch screen user interface and networking is handled by the Linux "management" side and the printer motion controller code is based on Marlin. The last public documentation on Ultimaker's architecture is the helpful *[Inside the Ultimaker 3 - Day 4 - Electronics](https://community.ultimaker.com/topic/15649-inside-the-ultimaker-3-day-4-electronics/)* post in 2016 on the Ultimaker forum.

![UM3 system](/wp-content/uploads/2024/02/um3-system-diagram.png)
: Source: Ultimaker forum

This is in contrast to the Ultimaker Original+ and 2 that use an embedded Atmega2560 microcontroller running Marlin to control all aspects of the printer.

![UM2 system](/wp-content/uploads/2024/02/um2-system-diagram.png)
: Source: Ultimaker forum

## Finding the Cause

Fortunately, the Ultimaker S-line has [logging functionality](https://support.makerbot.com/s/article/1667337561393) built into Linux management side and a logdump is written to the plugged in USB drive before rebooting.

### Filtering the Logs

![filter code](/wp-content/uploads/2024/02/magnifying_glass_over_computer_code_lines.jpg)

After opening the compressed logdump, I found [dmesg](https://en.wikipedia.org/wiki/Dmesg) log in the `boot.log` series of files. The dmesg shows all saved logs up to the last error that triggered the logdump. I was able to located the relevant portions of log that pertained to the last failed print attempt by searching for the filename of the failed print file.

```log
INF - parseHeaderStep:70 - Handling file '/media/usb0/XXX'
```

Looking further up in the log, the USB flash drive detection event can be found.

The following lines of the log show the printer calibration and preheating status. There may be a couple of lines with "errors" due to lack of internet connectivity or Ultimaker subscription. I'm using an Ultimaker S7 and S5 at school. The first obvious sign of trouble is this line.

```log
WAR - transportLayer:232 - Got error line 1 from printer: Error:SERIAL_INPUT_TIMEOUT: No commands received over time. Safety shutdown
```

followed by the next lines in between the `AUTO_LEVEL_BED` abort messages

```log
ERR - controller:956 - Halting ALL procedures
ERR - applicationLayer:324 - Marlin error: SYSTEM HALT!
```

At this point, the printer asks you to reboot it.

There's not much to go off of besides `SERIAL_INPUT_TIMEOUT` which looks like a constant value.

### Surface level symptoms

I have [contributed](https://github.com/MarlinFirmware/Marlin/pulls?q=author%3Aansonl+) to the [Marlin](https://github.com/MarlinFirmware) 3D printer firmware project before and Ultimaker was a main contributor to Marlin firmware in the past.

![Marlin logo](/wp-content/uploads/2024/02/marlin-logo.png)

I'm not sure how actively Ultimaker contributes to the open source version of Marlin today but it's nice to see that Marlin lives on in their 3D printer line up.

Ultimaker has released the source code of their version of Marlin called *[UltimakerMarlin](https://github.com/Ultimaker/UltimakerMarlin)*. There is a branch in the *UltimakerMarlin* Github repo named `S-line` with the last update in February 2021. I [searched the code](https://github.com/search?q=repo%3AUltimaker%2FUltimakerMarlin%20SERIAL_INPUT_TIMEOUT&type=code) for `SERIAL_INPUT_TIMEOUT` and the resulting code shows that `check_serial_input_timeout()` checks if the time since the last serial data input has been over `MONITOR_SERIAL_INPUT_TIMEOUT` seconds, `stop()` is called with the reason `STOP_REASON_SERIAL_INPUT_TIMEOUT`. `stop()` then sends the serial message through `SERIAL_ECHOLNPGM` which the Marlin developers recognize.

`MONITOR_SERIAL_INPUT_TIMEOUT` is defined as 5 minutes in the most recent released code.

Ultimaker has added a message protocol in *UltimakerMarlin* to communicate with the Linux side of the printer with messages formatted a standard way.

Based on what we've found so far, it's highly likely *UltimakerMarlin* — which runs the motion controller side of the printer — stopped receiving data from the Linux "management/UI" side for at least 5 minutes.

### Comparison of Print Logs

![comparing logs](/wp-content/uploads/2024/02/green_computer_code_turning_into_red_horizontally.jpg)

I narrowed down which logged abnormalities were likely to have caused the Linux management side to stop sending messages to the motion controller by comparing the logs of a successful print with a failed print.

Remember that the printer dumps all recent saved logs?

Another user of the printer had successfully finished a print and I found the logs from a past print job further up in the `boot.log` file.

> **Note:** Ultimaker logs do not appear to show any private data. The model filename and optimized probing points are the only identifying info. The software states at the time of errors seem to be sent to [Sentry](https://sentry.io/welcome/), crash analytics service, if the printer is connected to the internet. Unlike other 3D printer companies, Ultimaker appears to be transparent about their logging and not obsfucating logs.

I viewed both logs from the failed and successful prints side by side and first scrolled to the chronological location where the `SERIAL_INPUT_TIMEOUT` was found. The error shows up 3 lines after the following unique `BedLevelProbingProcedure` step is logged in both the failed and successful prints.

```log
INF - procedure:489 - BedLevelProbingProcedure(key='AUTO_LEVEL_BED', outcome=None) transitioning from 'ProbeSingleNozzleOffsetStep(key='PROBE_Z_OFFSET_FOR_VALIDATION_0')' >  'GotoPositionStep(key='GO_TO_SAFE_TRAVEL_HEIGHT_STEP')'
INF - printerService:195 - Procedure next step: AUTO_LEVEL_BED: GO TO SAFE TRAVEL HEIGHT STEP
INF - gotoPositionStep:86 - Moving to: x:None y:None z:20 e:None speed:None, relative:False, immediate:True
```

The bed probing procedure matches what I observed in real life. The printer homes the printhead and bed, preheats the bed and nozzles, and raises the bed along the Z axis towards the nozzle which is at the `0` Z position.

> **Note:** For those unfamiliar with the Ultimaker cartesian printer design, the higher Z position is at the bottom of the printer because the bed lowers away from the printhead which is fixed at the top of the printer case as the object is printed and gains height.

After the error message is received by the Ultimaker Linux management system, the next queued bed level procedure is started before management system starts halting procedures.

### Successful and Failed Print file comparison

The only obvious difference between the successful and failed print files was the size. I had previously successfully printed models sliced in both Cura and PrusaSlicer so the slicer was unlikely to be the cause. Both slicers output standard G-code printing commands.

The failed print file was larger in size. Maybe the Ultimaker system could not handle a larger print file?

### Locating Other Clues

![comparing logs](/wp-content/uploads/2024/02/abstract_tech.jpg)

The logdump is the only user visible record of what events led up to the motion controller crash and forced printer reboot. We need to use intuition and find more patterns in the logs we have.

The filesize of the printing G-code file is the only factor that increases processing time of the Ultimaker. The maximum axes, number of extruders, materials, and, bed probe area have set upper bounds that do not increase with printing G-code size.

The file size shouldn't matter since G-code is newline delimited and the memory efficient way to process the G-code is to read and execute a single line at a time.

Was the Ultimaker preprocessing the file for a purpose and this could bog down the Linux management system?

```log
INF - gCodeFootprintFinder:69 - PARSED LAYER: ['LAYER', '0']
INF - gCodeFootprintFinder:69 - PARSED LAYER: ['LAYER', '1']
```

The above events are logged in the successful print.

Wait. The Ultimaker is parsing layer 0 and layer 1 as part of the bed probe optimization. By determining the minimum footprint of the printed object that touches the bed, bed probing could cover only the printed area which can save time.

A footprint completion event for the successful print:

```log
INF - footprintProbeGridComputer:51 - Parsed the GCode to find the footprint coordinates in 1.2092304229736328 seconds
```

A footprint completion event for the failed print:

```log
INF - footprintProbeGridComputer:51 - Parsed the GCode to find the footprint coordinates in 696.0990624427795 seconds
```

696 seconds is a long time. It's longer than the motion controller timeout `MONITOR_SERIAL_INPUT_TIMEOUT` which is 300 seconds (5 minutes).

While the footprint finder runs, a couple of synchronization warnings are logged.

```log
WAR - timer:257 - Timer(PrintProcedureMetadataHelper.onChanged.timer) ran more than a second out of sync! (-1.116920)
```

The footprint finder takes too long and blocks the Linux management controller from sending new messages to the Marlin motion controller.  

Eventually the footprint calculation will finish and the printer will move to the next queued step in the `AUTO_LEVEL_BED` procedure. After the printer has processed the next queued step, it will get around to processing the motion controller `SERIAL_INPUT_TIMEOUT` error that occurs because the footprint calculation blocks message sending for more than 5 minutes.

### Firmware Attempts to End Processing Early

![safety shutdown](/wp-content/uploads/2024/02/digital_data_binary_code_made_from_fire.jpg)

After `SERIAL_INPUT_TIMEOUT` is received, the Ultimaker management system logs an attempt to end the footprint calculation as `STOP_FOOTPRINT_COMPUTER` and probe the entire bed in lieu of probing a smaller area to fit the footprint.

```log
INF - procedure:489 - BedLevelProbingProcedure(key='AUTO_LEVEL_BED', outcome=OutcomeBase.Aborted) transitioning from 'SwitchActiveHotendStep(key='SWITCH_HOTEND_FOR_VALIDATION_0')' >  'CallbackStep(key='STOP_FOOTPRINT_COMPUTER')'
INF - printerService:195 - Procedure next step: AUTO_LEVEL_BED: STOP_FOOTPRINT_COMPUTER
INF - footprintProbeGridComputer:73 - Active thread was still running, setting all cells to probe
INF - gCodeFootprintFinder:31 - Received call to stop footprint computation
```

`STOP_FOOTPRINT_COMPUTER` is sent as soon as the Marlin motion controller error is received so the decision to abort the footprint calculation is sent upon a motion controller error and `STOP_FOOTPRINT_COMPUTER` is not premptively invoked before the 5 minute timeout window.

After a motion controller error, the only UI action available is to reboot which is a soft reset that does not require physically resetting the printer power switch.

I assume that the single threaded nature of Python locks execution during the footprint calcuation and blocks the message system also running in Python from talking to the motion controller.

## Going Deeper

![go deep](/wp-content/uploads/2024/02/ripples_in_water.jpg)

We could end here and call it a day but let's see if we can figure out where the bug resides in the Ultimaker system. Maybe we will find a workaround in the current firmware and possible patches! If you want to see the G-code workaround now, feel free to scroll to the end of this post.

![We desire to know more about this Ultimaker bug](/wp-content/uploads/2024/02/desire-to-know-more.webp)

Ultimaker has helpfully included line numbers in logged events. So all we need to initially do is follow the footprints.

Starting with the first footprint event

```log
INF - bedLevelProbingProcedure:306 - Using footprint probing
```

Line `306` of `bedLevelProbingProcedure.py` is in the abbreviated function `prepareFootprintProbing()` below.

```python
  def prepareFootprintProbing(self) -> None:
    try:
      print_procedure = cast(PrintProcedure, self.__controller.getProcedure("PRINT"))
      gcode_metadata = print_procedure.getGcodeMetaData()
    except ValueError:
      gcode_metadata = None

    if gcode_metadata is not None and gcode_metadata.getGroupCount() <= 1:
      log.info("Using footprint probing") # <--- Line 306
      self.__footprint_probe_grid_computer = FootprintProbeGridComputer(self.__controller)
      self.__footprint_probe_grid_computer.computeFootprintProbeGrid(probe_grid=self.__probe_grid)
```

`prepareFootprintProbing()` starts the footprint discovery by calling `computeFootprintProbeGrid(probe_grid: ProbeGrid)`.

`computeFootprintProbeGrid(probe_grid: ProbeGrid)` first calls `findFootprintCoordinates(stream: IO[bytes]) -> List[List[float]]` to get all movement command coordinates (`G0` and `G1` only, no `G2`/`G3` arc movements).

```python
def findFootprintCoordinates(self, stream: IO[bytes]) -> List[List[float]]:
  self.__reset()

  for line in stream:
    self.__process(line)
    if self.__should_stop:
      break

  return self.__coordinates
```

The file stream is read line by line until `;LAYER:N` is found with a number `N` greater than `0`. During this loop to read the stream, a variable `__should_stop` is checked to see if the footprint coordinate finding should stop. `__should_stop` is set to `True` when a layer marker with a layer number greater than 0 is found or when the `stop()` function is called from `finalizeComputation()` which in turn is called when `STOP_FOOTPRINT_COMPUTER` message is received or footprint grid is needed on demand.

```python
if self.__layer > 0:
  self.__should_stop = True
  return  # Not processing this layer
```

```python
def stop(self) -> None:
  log.info("Received call to stop footprint computation")
  self.__should_stop = True
```

After all the coordinates touched before layer > 0 are returned, `computeFootprintProbeGrid(probe_grid: ProbeGrid)` calls `ConvexHull.find(cls, points: List[List[float]]) -> List[Vector2]` to return a trimmed list of the convex hull coordinates (the outside coordinates ring of the all found coordinates) and `updateWithBoundedSubSet(boundary_vectors: List[Vector2])` (I'll call this the Grid Bounded SubSet) to figure out the actual grid cells to probe.

### Long Running Algorithms and Thread Execution

Unlike `findFootprintCoordinates(stream: IO[bytes])` which ends early when `STOP_FOOTPRINT_COMPUTER` message is received, the `ConvexHull` and `updateWithBoundedSubSet(boundary_vectors: List[Vector2])` algorithms do not check for early termination.

![quickhull](/wp-content/uploads/2024/02/quickhull_animation.gif)
: *Source: Wikipedia - Maonus*

The [Convex Hull algorithm](https://www.oreilly.com/content/an-elegant-solution-to-the-convex-hull-problem/) used is [Quickhull](https://en.wikipedia.org/wiki/Quickhull) and has a worst case run time of `O(N^2)` where `N` is the number of coordinates before layer 1. Although the most likely worst run time is `O(N)` if the printed model has a circular base.

I didn't look at Grid Bounded SubSet algorithm too closely but it seems to have a similar worst case runtime of `O(N^2)`.

Now that we are looking at the code, the log message we looked at previously that output the footprint coordinate G-code parsing time does not represent the total processing time to find a probing grid. The log entry with the parsing time is logged is after all coordinates in the file have been found in `findFootprintCoordinates(stream: IO[bytes])` and before the Convex Hull and probing grid cells are calculated.

Now it makes sense why the log event for `STOP_FOOTPRINT_COMPUTER` was found AFTER the log events for footprint coordinate G-code parsing time and motion and motion controller error.

```log
INF - printerService:195 - Procedure next step: AUTO_LEVEL_BED: STOP_FOOTPRINT_COMPUTER
INF - footprintProbeGridComputer:73 - Active thread was still running, setting all cells to probe
```

```python
def finalizeComputation(self) -> None:
  if self._thread is not None:
    if self._thread.is_alive():
      log.info("Active thread was still running, setting all cells to probe")
      self.__footprint_finder.stop()
      self._thread.join()
      self.__probe_grid.setCellsToProbe(1)
      self.__probe_grid.updateQuickGridIndices(dimension=self.__probing_config.dimension)
```

The Convex Hull or Grid Bounded SubSet algorithm is running from when the parsing time message is logged to whenever each algorithm fully completes.

The Python thread does not join in time and `updateQuickGridIndices(dimension: Dimension)` never runs (we know this because the new quick probe indices are not logged like they are in the successful print log).

After this attempt to early abort the footprint finder is unsuccessful the Ultimaker printer would normally wait for the footprint finder to end naturally.

```log
ERR - applicationLayer:324 - Marlin error: SYSTEM HALT!
ERR - controller:956 - Halting ALL procedures
```

Due to the Marlin motion controller error, it determines an unsafe condition may have occured (e.g. motion controller keeps the heater on) so some more error messages are logged indicating halting more parts of the system. Then Ultimaker requires a reboot.

### Possible Patches

The Linux management controller could keep track of the time elapsed since the last message to the motion controller. It can also send `STOP_FOOTPRINT_COMPUTER` and fall back to a full bed probe before the 5 minute timeout window expires if the communication system cannot be refactored around Python threading and blocking issues.

A reference to the `__should_stop` variable can be passed to the Convex Hull and Grid Bounded SubSet algorithms. Each loop of the algorithm then checks the referenced variable to see if it should end early.

## Workarounds

![workarounds](/wp-content/uploads/2024/02/computer_code_fix_blue_red.jpg)

If we need to print with the current Ultimaker S-line firmware and we have a condition where we cannot change the 3D model or add proper `;LAYER` indicators, we need to supply the footprint finder with a simplified set of coordinates before ending it with our own `;LAYER:1`.

Ultimaker footprint finder G-code matching

```python
# Only handle G0, G1 commands with X,Y movement
keys = gcode_line.getParameterDictionaryKeys()
if "G" in keys and gcode_line.getValue("G", return_type=str) in self.__allowed_commands:
  if "X" in keys or "Y" in keys:
    self.__coordinates.append(self.__currentPositionToCoordinates())
```

In general, the workaround requirements are:

1. Include `G0` travel commands to the 4 corners of the bed (extruder movement is not needed) in our start G-code. Although these G-code will be found ahead of time by the footprint finder's lookahead, these G-code should come AFTER any homing code to avoid possible collisions.

2. Include a `;LAYER:1` after these `G0` travel commands so that the footprint finder ends due to encountering a layer marker for a layer > 0.

Start G-code workaround example for PrusaSlicer:

```gcode
G280 S1 ; Ultimaker 3 and S-line home and bed probe without prime blob

; Stop bed probe area computation early and use the entire bed.
G0 X{print_bed_min[0]} Y{print_bed_max[1]}
G0 X{print_bed_min[0]} Y{print_bed_min[1]}
G0 X{print_bed_max[0]} Y{print_bed_min[1]}
G0 X{print_bed_max[0]} Y{print_bed_max[1]}
;LAYER:1

; Put the rest of your start G-code here
```

> **Note:** We still need to show a minimum of the actual print bottom footprint coordinates to the footprint finder before it stops or else the footprint finder will return a single prefilled point which is the default nozzle probe position in the back right of the bed and the printer will warn about an unbalanced model.

## Bonus Bug!

![matrix](/wp-content/uploads/2024/02/matrix_code_logo.jpg)

I found another bug in the Ultimaker G-code header parser in the process of creating a PrusaSlicer profile for the Ultimaker S-line printers. The Ultimaker Griffin G-code header must be replicated in order for the Ultimaker S-line printers to recognize G-code files as valid.

When the parser validates a `GENERATOR.VERSION` composed only of numbers and periods without a third version component (usually the patch or bugfix number), the UI shows a *[ER999 - An unspecified error has occurred](https://support.makerbot.com/s/article/1667411042133)* screen that forces a reboot. The G-code header values and results:

```gcode
GENERATOR.VERSION:2.7.1 <- good
GENERATOR.VERSION:2.7   <- bad
GENERATOR.VERSION:A.A   <- good
```

```log
ERR - procedureStep:113 - Exception caught from step: CHECK
Traceback (most recent call last):
  File "/usr/share/griffin/griffin/printer/procedures/procedureStep.py", line 89, in _run
    outcome = self.run()
  File "/usr/share/griffin/griffin/printer/procedures/pre_and_post_print/runChecksBeforePrint.py", line 77, in run
    results = gcode_metadata.getValidator(c).validate()  # type: List[GCodeMetaDataContainerValidator.ValidationResult]
  File "/usr/share/griffin/griffin/datatypes/gcodeMetaDataContainerValidator.py", line 44, in validate
    self.__validateCuraVersion()
  File "/usr/share/griffin/griffin/datatypes/gcodeMetaDataContainerValidator.py", line 93, in __validateCuraVersion
    version: str = self.__header_container.getGeneratorVersion()
  File "/usr/share/griffin/griffin/datatypes/gcodeMetaDataContainer.py", line 45, in getGeneratorVersion
    return self.__metadata[self.__metadata_prefix + "generator"].get("version", "0.0.0").lower()
AttributeError: 'float' object has no attribute 'lower'
CRI - marvinService:127 - Added Fault: <Fault: level=2 code=102 message='Unhandled exception from ProcedureStep CHECK' data='dbus.Dictionary({}, signature=dbus.Signature('sv'))'>
```

The G-code header validator attempts to get the lowercase version of the generator `version` string in the metadata dictionary. The validator expects all the header values be stored as `string` when the header is parsed and the `float` data type has no `lower()` function.

For some reason the `version` is stored as a `float` instead of a `string` in the failing case. I thought the `version` may be handled special but all I found was a general `insertKeyValuePair()` function that handles all the header data insertion.

The header parser inserts a key value pair into the metadata dictionary in a recursive manner that I simplified below. There is no explicit type conversion or casting.

```python
 metadata[key[0]] = value
 ```

When the original `value` consists of digits and at most 1 decimal, `value`'s type is implicitly converted to a `float`. When non-digits or multiple decimals are present in `value`, it is stored as a `string`.

When the `version` is later retrieved from the dictionary, it is expected to be a `string` and an error occurs otherwise due to the next validation steps expecting a `string` and not a `float`.

Another header parsing function for the `build_plate` type also calls the `lower()` method which has the same implicit type issue.

Each header parsing function for a specific field returns the expected type so it's clear that some of the header values are meant to be saved as numeric data types and not as strings.

A header parsing solution could be checking the type of the stored metadata value and doing an explicit type conversion before doing any processing of the value.

## Conclusion

We found at least 2 edge cases that force a soft reset on the Ultimaker S-line 3D printers. The root causes were identified and successful workarounds found.

**01MAR24** - I notified Ultimaker of the Bed Leveling Footprint Finder and Gcode header bugs.

## Musings While We're At It

![Ultimaker nozzle and bed](/wp-content/uploads/2024/02/UM-bed-nozzle.jpg)
: *Source: Ultimaker*

Ultimaker makes a streamlined 3D printer line of dual color 3D FDM printers and in recent years, they have pivoted away from the hobbyist audience to institutional customers. This seems to happen to many 3D printer companies when a "time is more valuable than money" customer base is found.

Ultimaker printers are well built (my UMO+ and UM2+ printers are still going strong!) and have above average reliability. This is partly due to overengineering as well as conservative performance estimates and limited features compared to new 3D printers from Prusa and Bambu. Without incorporating new hardware features that benefit the common user, a company can only float on support contracts for so long until other "newly established" competitors come for a piece of the pie (e.g. Bambu X1E).

I don't even want to think about the rebrand of Makerbot printers to appear as if the Method printer is an adjacent, nonoverlapping product line on par with or remotely related to the Ultimaker S-line printer. Currently, there is no Ultimaker S-line vs Method 3D printer specification comparison on the Ultimaker website post-merger with Makerbot. For 3D printer users who are familiar with the printing capabilities of Method and Ultimaker printers, it feels like there was an extra stock of Method printers to offload after the merger.

Ok, that's enough criticism. I may be a bit too harsh there but it had to be said from the perspective of a non-institutional 3D printer user, software developer, and Ultimaker fan.

Ultimaker is killing it in the slicing software aspect as the lead developer of the open source [Cura](https://github.com/Ultimaker/Cura) slicer software. Cura has consistently incorporated new slicer innovations at the front of the pack competing slicers. Notable examples that come to mind are Ironing, Tree Supports, and (more recently) Organic Tree Supports.

Cura may look the most refined out of all the slicers and that often gives the impression that it's a walled garden with no customizability. The opposite is actually the case here. Cura exposes more print settings than others which empowers the user to get a better print!

![Ultimaker Cura](/wp-content/uploads/2024/02/cura_usaofplastic_screenshot.webp)
: Psst, you can download and print my 3D topo maps [here](https://ansonliu.com/maps/)

Similar to iOS and Android, CuraEngine and [Slic3r](https://slic3r.org/) based slicers ([PrusaSlicer](https://github.com/prusa3d/PrusaSlicer) and [Bambu Studio](https://github.com/bambulab/BambuStudio)) have kept abreast with each other in feature parity over the years. The formerly formidable commercial competitor, Simplify3D, is basically dead at this point. The open source nature of both projects allows developers from both projects to freely borrow good ideas from the other project so the 3D printing community grows as a whole.

I look forward to seeing Ultimaker's innovations that improve the 3D printing industry and community in the future!
