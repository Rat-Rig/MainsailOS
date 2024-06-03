---
sidebar_position: 2
---

# Adaptive Meshing

RatOS comes with it's own adaptive meshing (functionality was previously handled by PAM by Helge Keck), similar to KAMP. When enabled and configured in your slicer, RatOS will only probe the print area and your configured probe location, potentially saving a lot of time on smaller prints on bigger printers. RatOS will keep the resolution of your mesh (probes per mm), so that you always get consistent mesh performance. Contrary to KAMP and PAM, RatOS doesn't move your prime location, instead it probes the prime location (constrained by min/max bed_mesh settings) a single time and uses the difference between the probe result and your z_offset to dynamically apply a gcode offset only for the prime macro. This ensures no collision with prime blob and the toolhead on small meshes.

## Macro configuration

To enable adaptive priming set `variable_adaptive_mesh` to `True` in your RatOS macro configuration section (if it isn't already there, add it):

| Name                   | Possible Values | Default | Description                        |
| ---------------------- | --------------- | ------- | ---------------------------------- |
| variable_adaptive_mesh | True / False    | True    | Whether to enable adaptive meshing |

:::info
If you are currently using PAM, you should delete the PAM includes from printer.cfg before proceeding. Afterwards you can delete the PAM directory and remove the PAM moonraker.conf entry.
:::

## Slicer configuration

Make sure to setup your slicer according to the [official RatOS slicer configuration](../slicers.md).

## Relative reference index

RatOS Adaptive Meshing currently doesn't modify the relative reference index, it's generally not advised to use relative reference index with adaptive meshing.
