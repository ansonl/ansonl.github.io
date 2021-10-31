---
published: false
---
## Custom Doge Ultimaker Original+ Bed Header in Thermochromatic PLA

<iframe width="560" height="315" src="https://www.youtube.com/embed/PIolxWzFIAA" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Not the custom 3D printer part you need but the part you deserve.
The Doge and USA flag themed Ultimaker Original+ bed header. 

## But first...

![Modeling doge ultimaker bed cover in freecad](/wp-content/uploads/2021/10/freecad-compilation.gif)

Adjusted a [printable bed cover created by Neotko](https://www.youmagine.com/designs/umo-bed-cover-step) using FreeCAD. 

In order to model the Doge on the surface of the cover, I imported an SVG drawing of a Doge head into FreeCAD and coverted the "head" outline into a 3d object. The face features were upgraded to separate 3d objects and subtracted from the head 3d object. I needed to adjust the dimensions of the SVG drawing in Inkscape through trial and error.

### Printing finer than the nozzle resolution?!

The United States of America flag was created by doing a similar process on an imported SVG. The 50 stars were tricky. The Ultimaker Original+ has a nozzle size of 0.4mm and an accuracy of at least 0.05mm. The individual star features' resolution was ~0.1mm. Instead of extruding the stars for printing, <0.4mm resolution by printing *around* the stars. Modeling the stars as voids in the models allowed me to print every star in higher quality.


### Print it!

![24 hr print](/wp-content/uploads/2021/10/print-timelapse.gif)

The print had to be positioned with the front facing up in order to print the angled Doge features without support material. I made the mistake of printing it with the front facing down on a test print and the Doge becomes a husky. The front face is very glossy and smooth when it is facing down, so I had to try to replicate the effect using ironing with the front facing up. 

| My UMO+ Ironing Setting | Value |
| --- | --- |
| Pattern | Zig Zag |
| Line Spacing | 0.2 mm |
| Flow | 35% |
| Inset | 0.33 mm |
| Speed | 60 mm/s |

![test umo+ bed cover prints](/wp-content/uploads/2021/10/test-bed-cover-prints.jpg)

I used [Gizmo Dorks 2.85mm Gray-White Color Changing PLA](https://gizmodorks.com/pla-3d-printer-filament/) filament to print the final bed cover.
