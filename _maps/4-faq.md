---
title: "Frequently Asked Questions"
layout: post
permalink: /maps/faq/
image: 
  path: /assets/images/maps/3d-printable-maps-banner.webp
  thumbnail: /assets/images/maps/faq-question-mark.svg
show_subscribe: false
excerpt: >
  Answers to 3D modeling, slicing, printing issues.
---

### 1. What is 3MF? Why are you using 3MF over STL?

The 3D Manufacturing Format (3MF) is a file format to distribute 3D models. The file format supports independent objects, material info, and printing settings. Multiple objects in a single 3MF file allows loading interlocking and dual color models into the right coordinates instead of manually aligning STL files.

3MF files utilize compression, unlike STL files which only support ASCII or binary format. This means that the same 3D model can be stored using much less space (typically 5x smaller) in 3MF vs STL. Unlike 3D models with many flat surfaces, 3D printable map models contain high amounts of landscape detail so a 1.5 GB -> 300 MB file size reduction is significant.

3MF files can be imported into all major slicers including Cura, PrusaSlicer, and Bambu Studio.

### 2. How can I import 3MF into Blender?

3MF files can be imported into Blender using the free [Blender 3MF Format addon](https://github.com/ansonl/Blender3mfFormat). I recommend using my branch of the addon that adds some additional features in a [pull request](https://github.com/Ghostkeeper/Blender3mfFormat/pull/58) waiting to be merged into the main repo.

### 3. Cura/Prusaslicer slicer softwares hang or fail when slicing the models

Some models such as Alaska exceed the vertex limit of the slicer. Cut the model into smaller sections to bring the model vertex count down. This can be done in mesh software such as [Meshmixer](https://meshmixer.com/) and [Blender](https://www.blender.org/). If the model is cut to the desired size and still does not slice, you can reduce the overall detail of the model by using the [Decimate modifier](https://docs.blender.org/manual/en/latest/modeling/modifiers/generate/decimate.html) in Blender.

Slicing may also fail if your computer runs out of memory (OOM). You can confirm OOM by monitoring total memory usage while slicing. If your slicer does not crash and the import is empty, the file may have corrupted during upload and I can reupload it.

### 4. Where do you get the data for your models?

Data is freely available from NASA, USGS, USCB, HydroLAKES, Marine Cadastre, and state NR/GIS departments. Please remember to support national and local natural resource protection and research — this data would not be available otherwise.
