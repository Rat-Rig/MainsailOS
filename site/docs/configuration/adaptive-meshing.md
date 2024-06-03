---
sidebar_position: 2
---

# Bed Meshing

- [Bed Mesh Calibration](#bed-mesh-calibration)
- [Adaptive Meshing](#adaptive-meshing)
- [Adaptive Meshing configuration](#adaptive-meshing-configuration)
- [Adaptive Prime Blob configuration](#adaptive-prime-blob-configuration)
- [Prime Blob x-margin ](#prime-blob-x-margin)
- [Slicer configuration](#slicer-configuration)
- [Zero reference osition](#zero-reference-position)

## Bed Mesh Calibration

By default RatOS calibrates the bed mesh before each print, if you prefer calibrating your bed mesh manually, you can disable it. Disabling `variable_calibrate_bed_mesh` will stop RatOS from loading a bed mesh entirely. If you want it to load a mesh, you can set `variable_bed_mesh_profile` to the name of the profile you want it to load.

| Name                        | Possible Values    | Default   | Description                                               |
| :-------------------------- | :----------------- | :-------- | :-------------------------------------------------------- |
| variable_calibrate_bed_mesh | True / False       | True      | Whether or not to calibrate a bed mesh before each print. |
| variable_bed_mesh_profile   | undefined / string | undefined | The name of the profile you want to load.                 |

If `variable_calibrate_bed_mesh` is `False` you must set `variable_bed_mesh_profile` variable to the profile name you wish to load, or no bed mesh will be loaded. If `variable_calibrate_bed_mesh` is `True` and this variable isn't set, RatOS will use `ratos` as the profile name.

## Adaptive Meshing

RatOS comes with it's own, deeply integrated and IDEX aware, adaptive meshing implementation. Do not try to set up the klipper variant of it, which works only in combination with the exclude_objects feature. RatOS will only probe the print area and your configured probe location, potentially saving a lot of time on smaller prints on bigger printers. RatOS will keep the resolution of your mesh (probes per mm), so that you always get consistent mesh performance. Contrary to other implementations, RatOS doesn't move your prime location, instead it probes the prime location (constrained by min/max bed_mesh settings) a single time and uses the difference between the probe result and your z_offset to dynamically apply a gcode offset only for the prime macro. This ensures no collision with the prime blob and the toolhead on small meshes.

### Adaptive Meshing configuration

Adaptive bed meshing is enabled by default. To disable it set `variable_adaptive_mesh` to `False` in your printer.cfg file.

| Name                   | Possible Values | Default | Description                        |
| :--------------------- | :-------------- | :------ | :--------------------------------- |
| variable_adaptive_mesh | True / False    | True    | Whether to enable adaptive meshing |

### Adaptive Prime Blob configuration

For single toolhead printer you can control the location and direction of the prime blob, IDEX printers do use a fully automated and intelligent prime control depending on the situation and print mode. 

| Name                             | Possible Values                 | Default     | Description                      |
| :------------------------------- | :------------------------------ | :---------- | :------------------------------- |
| variable_nozzle_priming          | "primeblob", False              | "primeblob" | Whether to enable the prime blob |
| variable_nozzle_prime_start_x    | "min", "max", Number            | "max"       | non IDEX priming x-location      |
| variable_nozzle_prime_start_y    | "min", "max", Number            | "min"       | non IDEX priming y-location      |
| variable_nozzle_prime_direction  | "auto", "forwards", "backwards" | "auto"      | non IDEX priming y-direction     |
| variable_nozzle_prime_bridge_fan | Number                          | 102         | priming bridging fan speed 0-255 |

### Prime Blob x-margin 

By default the primeblob has a x-margin of 5 mm from the edge. This value can be changed by overriding it in the printer.cfg.
```
[gcode_macro PRIME_BLOB]
variable_x_offset: 5   # the prime blob x-margin 
```

### Slicer configuration

Make sure to setup your slicer according to the [official RatOS slicer configuration](../slicers.md).

### Zero reference position

RatOS Adaptive Meshing currently doesn't modify the zero reference position, it's generally not advised to set the zero reference position with adaptive meshing.
