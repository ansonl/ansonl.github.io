---
title: "Frequently Asked Questions"
layout: post
permalink: /maps/faq/
image: /assets/images/maps/3d-printable-maps-banner.webp
thumbnail: /assets/images/maps/faq-question-mark.svg
show_subscribe: false
excerpt: >
  Answers to 3D modeling, slicing, printing issues.
---

### 1. How to 3D print the topo maps?

- To start off, you need a 3D printer, a friend with a 3D printer, or online 3D printing service.

- Next, download a [slicer](https://en.wikipedia.org/wiki/Slicer_(3D_printing)) software that is compatible with your 3D printer.

- Open the downloaded 3MF 3D files in the slicer. See [print settings](../print-settings/) for how to set up the model in the slicer.

### 2. How do I find the 3D file on the map listing?

All 3D map models are available for free on [MakerWorld](https://makerworld.com/en/@ansonl) and [Printables](https://www.printables.com/@ansonl/). Each map is published in multiple styles which you can get more info about on [Specifications]({% link _maps/3-specifications.md %}).

#### MakerWorld

- If there is not a print profile uploaded the for map and style you want, you can download the 3D file for the maps on the model page under Print Profiles list > **Open in Bambu Studio** > **Download STL/CAD Files**.

[![makerworld download 3d files](/assets/images/maps/makerworld-download-files.webp)](https://makerworld.com/en/@ansonl)

#### Printables

- All 3D printable files for a map can be found on the model page under **Files**.

### 3. What is 3MF? Why are you using 3MF over STL?

The 3D Manufacturing Format (3MF) is a file format to distribute 3D models. The file format supports independent objects, material info, and printing settings. Multiple objects in a single 3MF file allows loading interlocking and dual color models into the right coordinates instead of manually aligning STL files.

3MF files utilize compression, unlike STL files which only support ASCII or binary format. This means that the same 3D model can be stored using much less space (typically 5x smaller) in 3MF vs STL. Unlike 3D models with many flat surfaces, 3D printable map models contain high amounts of landscape detail so a 1.5 GB -> 300 MB file size reduction is significant.

3MF files can be imported into all major slicers including Cura, PrusaSlicer, and Bambu Studio.

### 4. How can I edit the map model to fit my printer?

You can use features in your Slicer or 3D mesh software to cut the map and modify it for your needs.

A couple of my recommended mesh tools are below:

#### [Blender](https://www.blender.org/)

- 3MF files can be imported into Blender using the free [Blender 3MF Format addon](https://github.com/ansonl/Blender3mfFormat). I recommend using my linked branch of the addon that adds 3MF Color Group support for objects in a [pull request](https://github.com/Ghostkeeper/Blender3mfFormat/pull/58) waiting to be merged into the main repo.

#### [MeshLab](https://www.meshlab.net/)

#### [MeshMixer](https://apps.autodesk.com/FUSION/en/Detail/Index?id=4108920185261935100&appLang=en&os=Win64)

### 5. The Slicer softwares hang or fail when slicing the models

Some users have reported that loading the 3MF as a "Project" instead of importing as a model file into Slicers with "projects" has a higher success rate. Users have also found success importing the 3MF into a different slicer such as [Bambu Studio](https://github.com/bambulab/BambuStudio) or [OrcaSlicer](https://github.com/SoftFever/OrcaSlicer/).

Larger models such as Alaska exceed the vertex limit of the slicer. Cut the model into smaller sections to bring the model vertex count down. This can be done in mesh software such as [Meshmixer](https://meshmixer.com/) and [Blender](https://www.blender.org/). If the model is cut to the desired size and still does not slice, you can reduce the overall detail of the model by using the [Decimate modifier](https://docs.blender.org/manual/en/latest/modeling/modifiers/generate/decimate.html) in Blender.

Slicing may also fail if your computer runs out of memory (OOM). You can confirm OOM by monitoring total memory usage while slicing. 

You should download the individual map model 3MF directly instead of as a ZIP or other archive. There is a compression bug where larger 3MF files do not compress or extract correctly. If your slicer does not crash and the import is empty, the file could have been corrupted during upload and I can reupload it if you leave a comment.

### 6. Where do you get the data for your models?

See [Specifications]({% link _maps/3-specifications.md %}).