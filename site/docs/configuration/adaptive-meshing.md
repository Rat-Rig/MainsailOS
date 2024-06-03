---
sidebar_position: 2
---

# Adaptive Meshing

RatOS comes with it's own, deeply integrated and IDEX aware, adaptive meshing implementation. Do not try to set up the klipper variant of it, which works only in combination with the exclude_objects feature. RatOS will only probe the print area and your configured probe location, potentially saving a lot of time on smaller prints on bigger printers. RatOS will keep the resolution of your mesh (probes per mm), so that you always get consistent mesh performance. Contrary to other implementations, RatOS doesn't move your prime location, instead it probes the prime location (constrained by min/max bed_mesh settings) a single time and uses the difference between the probe result and your z_offset to dynamically apply a gcode offset only for the prime macro. This ensures no collision with the prime blob and the toolhead on small meshes.

## Macro configuration

Adaptive bed meshing is enabled by default. To disable it set `variable_adaptive_mesh` to `False` in your printer.cfg file.

| Name                   | Possible Values | Default | Description                        |
| ---------------------- | --------------- | ------- | ---------------------------------- |
| variable_adaptive_mesh | True / False    | True    | Whether to enable adaptive meshing |

## Adaptive prime blob configuration

For single toolhead printer you can control the location and direction of the prime blob, IDEX printers do use a fully automated and intelligent prime control depending on the situation and print mode. 

| Name                             | Possible Values                 | Default     | Description                      |
| -------------------------------- | ------------------------------- | ----------- | -------------------------------- |
| variable_nozzle_priming          | "primeblob", False              | "primeblob" | Whether to enable the prime blob |
| variable_nozzle_prime_start_x    | "min", "max", Number            | "max"       | non IDEX priming x-location      |
| variable_nozzle_prime_start_y    | "min", "max", Number            | "min"       | non IDEX priming y-location      |
| variable_nozzle_prime_direction  | "auto", "forwards", "backwards" | "auto"      | non IDEX priming y-direction     |
| variable_nozzle_prime_bridge_fan | Number                          | 102         | priming bridging fan speed 0-255 |

## Prime blob x-margin 

By default the primeblob has a x-margin of 5mm from the edge. This value can be changed by overriding it the variable in your printer.cfg.
```
[gcode_macro PRIME_BLOB]
variable_x_offset: 5   # the prime blob x-margin 
```

## Slicer configuration

Make sure to setup your slicer according to the [official RatOS slicer configuration](../slicers.md).

## Zero reference position

RatOS Adaptive Meshing currently doesn't modify the zero reference position, it's generally not advised to set the zero reference position with adaptive meshing.
