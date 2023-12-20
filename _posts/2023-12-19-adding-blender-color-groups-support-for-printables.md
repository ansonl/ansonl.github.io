---
published: true
title: >-
  Adding Blender Color Groups Support for Printables 3D Model Previews
author: Anson Liu
layout: post
image: /wp-content/uploads/2023/12/MD-before-after.webp
categories:
  - development
tags:
  - 3d printing
  - prusa
  - printables
  - blender
excerpt: >
  [Printables](https://www.printables.com/) is a 3D model sharing site with a unique 3D model previewer. This preview can utilize color data embedded in the 3D file — but only if you assign colors in specific software.

  Let's figure out how the Printables 3D previewer gets color info from 3MF files and get Blender to export models with the needed color info!

  ![Maryland MD before color and after color](/wp-content/uploads/2023/12/MD-before-after.webp)
---

[Printables](https://www.printables.com/) is a 3D model sharing site where you can upload your creations and download other user's models.

![printables banner](/assets/images/maps/usaofplastic-printables-scroll.webp)

One of the unique features of Printables is support for colors in each listing's 3D model preview. At first glance, the preview is similar to other 3D model sites where it shows a 3D object on the screen that you can rotate and show a wireframe mode. The color support is not apparent until you upload a 3D model in a format that has colors embedded.

![fluffcorn ninja pot preview](/wp-content/uploads/2023/12/fluffcorn-ninja-pot-preview.webp)

The [Fluffcorn](https://www.printables.com/model/578880-fluffcorn-from-fluffcorn-stickers) model with no color data appears as a single color while multicolor [Ninja Pot](https://www.printables.com/model/228038-ninja-pot-01) model shows in multiple colors specified by the creator.

If you try to export a model to a 3MF file that has multiple objects, all the objects will show up in the same color in Printables 3D model preview by default. This is because the model preview supports colors through the [Color Group](https://github.com/3MFConsortium/spec_materials/blob/master/3MF%20Materials%20Extension.md#chapter-2-color-groups) element of the 3MF specification.

Initially, it was not clear that the 3D model preview supported colors at all. If you do not embed colors in a supported method, the preview will just show a single object in a single color even though the shown object is made up of multiple objects. I asked the question about multicolors on the [Printables Prusa group](https://www.printables.com/group/prusa-research-official-g7RVLQP/comments/1012167) and Ondrej linked me to an existing Ninja Pot model with colors embedded. Upon further discussion, it was revealed that colors could be assigned within Prusaslicer and Microsoft 3D Builder and multiple objects exported in a single 3MF file.

It's all well and good that colors can be assigned in the 3D slicer software and editor but I want to know what part of the 3MF file is used in the Printables 3D model preview for color info.

I automate the export of larger 3MF files in Blender using Python using the excellent [Blender 3MF Format addon](https://github.com/Ghostkeeper/Blender3mfFormat) created by GhostKeeper. 3MF only supports zip as the compression method at the moment so compression and extraction is single threaded and slow, often taking minutes to hours — hence the automation. Some of my 3D topo map models are so large (looking at you, Alaska) that I found the Blender vertex limit which is a [known bug](https://projects.blender.org/blender/blender/issues/113380).

Anyways, my multicolor 3MF files were not showing up with any assigned colors in the online model preview which meant that an image that I rendered in Blender was rendered as a solid orange block on Printables. Users who used the Printables preview tool were not able to distinguish between different objects in the model.

![fluffcorn ninja pot preview](/wp-content/uploads/2023/12/RI-blender-to-printables-nocolor.webp)

## Figuring out how Printables supports color

To find out how Printables supports colors, I downloaded the Ninja Pot model that has multiple objects with each objects assigned a different color. I also assigned colors to my 3D model of the District of Columbia (DC) in Blender as "materials" and exported it as a 3MF.

The 3MF file is a zip archive of multiple other files that contain the 3D model and metadata. The 3D model is stored in XML format in the `3dmodel.model` file under the `3D/` directory. I compared the `3dmodel.model` for the Ninja Pot (exported from Prusaslicer) and DC (exported from Blender).

The Blender 3MF Format addon assigns an object's Blender "material" as the [Base Material](https://github.com/3MFConsortium/spec_core/blob/master/3MF%20Core%20Specification.md#51-base-material) attribute under the 3MF Core Spec.

![fluffcorn ninja pot preview](/wp-content/uploads/2023/12/blender-materials.webp)

### Blender using Blender 3MF Addon (Base Material)

A sample of `3dmodel.model` file for DC exported from Blender:

```xml
<?xml version='1.0' encoding='UTF-8'?>
<model xmlns="http://schemas.microsoft.com/3dmanufacturing/core/2015/02">
  <metadata name="Title" preserve="1" type="xs:string">Scene</metadata>
  <resources>
    <basematerials id="1">
      <base name="Material.001" displaycolor="#02CC00" />
      <base name="Material.002" displaycolor="#0002CC" />
    </basematerials>
    <object id="2" name="DC-dual-land-elevation" pid="1" pindex="0">
      ...
    </object>
  </resources>
  ...
</model>
```

The XML namespace for the [3MF Core Specification](https://github.com/3MFConsortium/spec_core/blob/master/3MF%20Core%20Specification.md#51-base-material) is specified. This is required. Without the namespace, 3MF file will seen as invalid by 3MF programs. The actual namespace URL to `http://schemas.microsoft.com/3dmanufacturing/core/2015/02` is no longer valid, so this seems to just be a hardcoded value that 3MF programs will look for now.

Under resources, we have a `basematerials` element that contains two child `base` elements. Each `base` element has attributes of `name` and `displaycolor` that describe our 2 defined colors with human readable and sRGB values. The meanings should be obvious once you see them.

Next are the individual objects as `object` elements. Each object's mesh data (vertices) are contained in a separate `object` element.

Each [`object` element has attributes](https://github.com/3MFConsortium/spec_core/blob/master/3MF%20Core%20Specification.md#chapter-4-object-resources) that are defined in the 3MF spec. An abbreviated version of the object attribute spec is below:

| Name | Type | Annotation |
| --- | --- | --- |
| id | **ST\_ResourceID** | Defines the unique identifier for this object. |
| name | **xs:string** | Name of object to improve readability. |
| pid | **ST\_ResourceID** | Reference to the property group element with the matching id attribute value (e.g. \<basematerials>). It is REQUIRED if pindex is specified. |
| pindex | **ST\_ResourceIndex** | References a zero-based index into the properties group specified by pid. This property is used to build the object. |

`id` is the `object`'s unique identifier that it can be referenced with. `name` is a human readable label.

`pid` is a reference to the `basematerials` element with an `id` of `1`

`pindex` references an index within the element referenced by `pid` attribute of the same `object`.

The `object` of `id="2"` gets its properties from the sibling element with an `id` equal to the `object`'s `pid`. This references the `basematerials` element with `id="1"`. Within the referenced element through `pid`, the `pindex` child is used for the `object` properties.

The 3MF Core Specification states

> The *displaycolor* property is meant to be used for rendering purposes only, and not for defining the actual material color of an object.

The statement suggests that `basematerials/base` elements are meant to describe the digital render color and fits the digital 3D model preview use case.

However, Printables 3D model preview does not seem to use the `basematerials` color to determine the render color.

### Prusaslicer (Color Group)

I viewed the `3dmodel.model` file for the Ninja Pot model and have included an modified sample below that is in the context of the DC model for easier comparison.

```xml
<?xml version='1.0' encoding='UTF-8'?>
<model xmlns="http://schemas.microsoft.com/3dmanufacturing/core/2015/02" xmlns:m="http://schemas.microsoft.com/3dmanufacturing/material/2015/02">
  <metadata name="Title" preserve="1" type="xs:string">Scene</metadata>
  <resources>
    <m:colorgroup id="1">
      <m:color name="Material.001" color="#02CC00" />
      <m:color name="Material.002" color="#0002CC" />
    </m:colorgroup>
    <object id="2" name="DC-dual-land-elevation" pid="1" pindex="0">
      ...
    </object>
  </resources>
  ...
</model>
```

At the top, the `model` element has an additional namespace prefixed with `m`. This namespace is the 3MF Materials Extension Specification. Note that the core spec namespace remains.

`m:colorgroup` and `m:color` have replaced `basematerial` and `base`. The `displaycolor` property is now the similar `color` property under the `m:color` element.

The 3MF Materials Extension Spec states

> A `<colorgroup>` describes a set of surface color properties and SHOULD NOT reference translucent display properties.

> Colors [elements] are used to represent rich color, specifically what most 3D formats call “vertex colors”. These elements are used when color is the only property of interest for the material, and a large number will be needed. The format is the same sRGB color as defined in the core 3MF specification.

The `object` element references have the same flow and it can be seen that the `object` with `id="2"` references the properties in the element `<m:color name="Material.001" color="#02CC00" />`.

### Base Materials vs Color Groups

The only significant difference (as far as color is concerned) between Blender and Prusaslicer produced 3MF files is the use of `basematerial` vs `colorgroup`.

Base Materials describe the actual materials used for manufacturing an object and have a `displaycolor` attribute to specifically define the color used for rendering a material. This is the more extensible element of the two and as additional non color data may be added in the future.

Color Groups describe ONLY colors and are used when color is the only property of interest for a material. This is the more restricted of the two and may be used for brevity when many colors are expected.

## Adding Color Groups to Blender

I added an option to the Blender3MFFormat addon to use Color Groups to describe material colors and use `object.name` to keep human readable names when exporting 3MF files.

One of the most annoying issues was dealing with the addition of the 3MF Materials Extension Spec as a second XML namespace. I also learned that Ultimaker [Cura does not import the human readable `object.name`](https://github.com/Ultimaker/Cura/issues/17110) and sets `object.name` to the filename incremented by 1 when exporting as 3MF which is destructive and not user friendly.

If you want to see the actual code addition, you can view the [pull request on Github](https://github.com/Ghostkeeper/Blender3mfFormat/pull/58).

If you want to use the updated Blender3MFFormat addon with Color Group support, all you need to do is download my [color-groups branch](https://github.com/ansonl/Blender3mfFormat/tree/color-groups) of the Blender addon and copy the folder to your `C:\Users\%USER%\AppData\Roaming\Blender Foundation\Blender\X.X\scripts\addons` directory.

## Colors on Printables.com

Voila! Now you can upload your Blender models with colors to Printables and users can view your models with the colors you want!

![Maryland MD before color and after color](/wp-content/uploads/2023/12/MD-before-after.webp)

If you want to see the color 3D model preview you can try viewing my [topographic relief map models](https://ansonliu.com/maps/) on [Printables](https://www.printables.com/@ansonl/collections/714909). The 3D viewer downloads the entire model for viewing so I have linked a few of the smaller models below for faster viewing:

- [Massachusetts, USA](https://www.printables.com/model/520999-massachusetts-usa-ma-topographic-map-with-hydrogra)

- [Connecticut, USA](https://www.printables.com/model/520632-connecticut-usa-ct-topographic-map-with-hydrograph)

- [Maryland, USA](https://www.printables.com/model/531455-maryland-usa-md-topographic-map-with-rivers)

After some use, I found that Printables preiew shifts the render color towards orange so your colors will appear off and the wireframe/xray views do not seem to be enabled when viewing a multicolor model. There is also an arbitrary limit on file size/memory/rendering time for generation of a Printables thumbnail so larger models won't show a color preview until you actually click the preview to load it.

Most of these minor issues are understandable as multicolor previews were not a high use feature in the past.

## The Rise of Multi-color/Multi-material Printing and 3MF

Recently many reliable and lower cost multicolor consumer 3D printers have been released. Some of these systems include the Prusa XL toolchanger, Prusa MMU3, Bambu Lab AMS, and [Ultimaker DXU](https://github.com/ansonl/DXU). I was drafting a separate post on multimaterial 3D printing solution in the past but new 3D printers changed the landscape + I ran out of time so I will just note here that a multiple filament to single nozzle system such as the Prusa MMU and Bambu AMS pass all filament through the same path, so purges and material contamination are unavoidable and can only be minimized. If you print in different plastics that do not mix well, the print may suffer in adhesion or strength as bits of the previous material will be mixed with the new material.

A multi-nozzle solution most often seen on the Prusa XL and Ultimaker printers avoids contamination and wasteful color swap procedures. Priming an unused nozzle is still needed but the lengthy purging procedure is not needed.

With more people doing multicolor prints at home with a 3D printer working out of the box, I expect that we will see more 3D models shared as 3MF with assigned colors. If you want to read more about why 3MF is replacing STL, see the [3D map printing FAQ](https://ansonliu.com/maps/faq/#1-what-is-3mf-why-are-you-using-3mf-over-stl).

[Printables](https://www.printables.com/)'s color 3D model preview shows the high attention to detail of the team at Prusa Research. Even though few creators may publish multicolor designs, users who do publish multicolor models create a more accessible experience for users and are rewarded with a nice 3D model preview!
