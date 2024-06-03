---
sidebar_position: 2
---

# Adaptive Meshing

RatOS comes with it's own, deeply integrated and IDEX aware, adaptive meshing implementation. Do not try to set up the klipper variant of it, which works only in combination with the exclude_objects feature. RatOS will only probe the print area and your configured probe location, potentially saving a lot of time on smaller prints on bigger printers. RatOS will keep the resolution of your mesh (probes per mm), so that you always get consistent mesh performance. Contrary to other implementations, RatOS doesn't move your prime location, instead it probes the prime location (constrained by min/max bed_mesh settings) a single time and uses the difference between the probe result and your z_offset to dynamically apply a gcode offset only for the prime macro. This ensures no collision with prime blob and the toolhead on small meshes.

## Macro configuration

Adaptive bed meshing is enalbed by default. To disable it set `variable_adaptive_mesh` to `False` in your printer.cfg file.

| Name                   | Possible Values | Default | Description                        |
| ---------------------- | --------------- | ------- | ---------------------------------- |
| variable_adaptive_mesh | True / False    | True    | Whether to enable adaptive meshing |

## Slicer configuration

Make sure to setup your slicer according to the [official RatOS slicer configuration](../slicers.md).

## Zero reference position

RatOS Adaptive Meshing currently doesn't modify the zero reference position, it's generally not advised to set the zero reference position with adaptive meshing.
