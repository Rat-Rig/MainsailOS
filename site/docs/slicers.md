# Slicer Configuration

- [Prusa Slicer](#prusa-slicer)
- [Super Slicer](#super-slicer)
- [Orca Slicer](#orca-slicer)
- [Cura](#cura)
- [Simplify 3D V5](#simplify-3d-v5)
- [IdeaMaker](#ideamaker)
- [Slicer thumbnails](#slicer-thumbnails)

# Macros

RatOS comes with START_PRINT and END_PRINT macros that you can call directly from your slicers. This way the printer knows how to start a print, and you can there easily switch between slicers without worrying if you changed anything in another slicer.
The g-code for these macros are found in `config/RatOS/macros.cfg`

## Prusa Slicer 

*Prusa Slicer comes with full IDEX support and is the recommended slicer for all RatRig printers.*

:::info
You should be using "Klipper" as the gcode flavor and have the "Use relative E distances" box checked in Printer Settings -> General -> Advanced.
:::

:::info
This is the ONLY gcode you need, delete everything else. Copy paste the following **as is**.
:::

### Configuration

- Select `Klipper` in Printer Settings -> General -> Firmware -> G-code Flavor
- Enable `Use relative E distances` in Printer Settings -> General -> Advanced

### GCode Settings

Start GCode for single toolhead printers

```properties
START_PRINT EXTRUDER_TEMP={first_layer_temperature[0]} EXTRUDER_OTHER_LAYER_TEMP={temperature[0]} BED_TEMP=[first_layer_bed_temperature] TOTAL_LAYER_COUNT={total_layer_count} X0={first_layer_print_min[0]} Y0={first_layer_print_min[1]} X1={first_layer_print_max[0]} Y1={first_layer_print_max[1]}
```

Start GCode for IDEX printers

```properties
START_PRINT EXTRUDER_TEMP={first_layer_temperature[0]},{first_layer_temperature[1]} EXTRUDER_OTHER_LAYER_TEMP={temperature[0]},{temperature[1]} BED_TEMP=[first_layer_bed_temperature] INITIAL_TOOL={initial_tool} TOTAL_LAYER_COUNT={total_layer_count} X0={first_layer_print_min[0]} Y0={first_layer_print_min[1]} X1={first_layer_print_max[0]} Y1={first_layer_print_max[1]}
```

Before layer change GCode

```properties
;BEFORE_LAYER_CHANGE
;[layer_z]
```

After layer change GCode

```properties
;AFTER_LAYER_CHANGE
;[layer_z]
G92 E0
_ON_LAYER_CHANGE LAYER={layer_num + 1}
```

Tool change GCode for IDEX printers

```properties
T[next_extruder]
```

Between objects GCode

```properties
;BETWEEN_OBJECTS
G92 E0
```

Start filament GCode

```properties
; Filament gcode
SET_PRESSURE_ADVANCE ADVANCE=0.05
```

### Chamber temperature with Prusa Slicer

Unlike Super Slicer and Orca Slicer, Prusa Slicer doesnt come with a chamber temperature configuration option. There is a workarround, but it works only if the filament profile notes are empty and not used otherwise.

- in your filament profile notes enter `CHAMBER_TEMP=50`
- add `{filament_notes[current_extruder]}` to the end of your printer start gcode.

This isnt a ideal solution but it lets you pass the chamber temperature to the START_PRINT macro based on your filament profiles.

Another option is to to hardcode the CHAMBER_TEMP parameter directly into the printer start gcode. In this case the parameters will be activated for every print, no matter which filament profile you use.

- add `CHAMBER_TEMP=50` to the end of your printer start gcode.


## Super Slicer

*Super Slicer comes with full IDEX support.*

:::info
You should be using "Klipper" as the gcode flavor and have the "Only custom Start G-Code" box checked in Printer Settings -> Custom G-Code and "Use relative E distances" box checked in Printer Settings -> General -> Advanced.
:::

:::info
This is the ONLY gcode you need, delete everything else. Copy paste the following **as is**.
:::

### Configuration

- Select `Klipper` in Printer Settings -> General -> Firmware -> G-code Flavor
- Enable `Use relative E distances` in Printer Settings -> General -> Advanced
- Enable `Only custom Start G-Code` in Printer Settings -> Custom G-Code

### GCode Settings

Start GCode for single toolhead printers

```properties
G90
G21
SET_GCODE_VARIABLE MACRO="RatOS" variable="relative_extrusion" VALUE="True"
START_PRINT EXTRUDER_TEMP={first_layer_temperature[0]} EXTRUDER_OTHER_LAYER_TEMP={temperature[0]} BED_TEMP=[first_layer_bed_temperature] CHAMBER_TEMP=[chamber_temperature] TOTAL_LAYER_COUNT={total_layer_count} X0={first_layer_print_min[0]} Y0={first_layer_print_min[1]} X1={first_layer_print_max[0]} Y1={first_layer_print_max[1]}
```

Start GCode for IDEX printers

```properties
G90
G21
START_PRINT EXTRUDER_TEMP={first_layer_temperature[0]},{first_layer_temperature[1]} EXTRUDER_OTHER_LAYER_TEMP={temperature[0]},{temperature[1]} BED_TEMP=[first_layer_bed_temperature] CHAMBER_TEMP=[chamber_temperature] INITIAL_TOOL={initial_tool} TOTAL_LAYER_COUNT={total_layer_count} X0={first_layer_print_min[0]} Y0={first_layer_print_min[1]} X1={first_layer_print_max[0]} Y1={first_layer_print_max[1]}
```

End GCode
```properties
END_PRINT
```

Before layer change GCode

```properties
;BEFORE_LAYER_CHANGE
;[layer_z]
```

After layer change GCode

```properties
;AFTER_LAYER_CHANGE
;[layer_z]
G92 E0
_ON_LAYER_CHANGE LAYER={layer_num + 1}
```

Tool change GCode for IDEX printers

```properties
T[next_extruder]
```

Between objects GCode

```properties
;BETWEEN_OBJECTS
G92 E0
```

Start filament GCode

```properties
; Filament gcode
SET_PRESSURE_ADVANCE ADVANCE=0.05
```

## Orca Slicer

*Orca Slicer comes with partial IDEX support only. It lacks multi extruder support. You cant for example assign one extruder to print supports or infill.*

:::info
You should be using "Klipper" as the gcode flavor and have the "Use relative E distances" box checked in in Printer Settings -> Advance.
:::

:::info
This is the ONLY gcode you need, delete everything else. Copy paste the following **as is**.
:::

### Configuration

- Select `Klipper` in Printer Settings -> Advanced -> G-code Flavor
- Enable `Use relative E distances` in Printer Settings -> Advanced

### GCode Settings

Start GCode for single toolhead printers

```properties
START_PRINT EXTRUDER_TEMP={first_layer_temperature[0]} EXTRUDER_OTHER_LAYER_TEMP={nozzle_temperature[0]} BED_TEMP=[bed_temperature_initial_layer_single] CHAMBER_TEMP={overall_chamber_temperature} TOTAL_LAYER_COUNT={total_layer_count} X0={adaptive_bed_mesh_min[0]} Y0={adaptive_bed_mesh_min[1]} X1={adaptive_bed_mesh_max[0]} Y1={adaptive_bed_mesh_max[1]}
```

Start GCode for IDEX printers

```properties
START_PRINT EXTRUDER_TEMP={first_layer_temperature[0]},{first_layer_temperature[1]} EXTRUDER_OTHER_LAYER_TEMP={nozzle_temperature[0]},{nozzle_temperature[1]} BED_TEMP=[bed_temperature_initial_layer_single] CHAMBER_TEMP={overall_chamber_temperature} INITIAL_TOOL={initial_tool} TOTAL_LAYER_COUNT={total_layer_count} X0={adaptive_bed_mesh_min[0]} Y0={adaptive_bed_mesh_min[1]} X1={adaptive_bed_mesh_max[0]} Y1={adaptive_bed_mesh_max[1]}
```

End GCode

```
END_PRINT
```

Before layer change GCode

```
;BEFORE_LAYER_CHANGE
;[layer_z]
```

Layer change GCode

```
;AFTER_LAYER_CHANGE
;[layer_z]
G92 E0
_ON_LAYER_CHANGE LAYER={layer_num + 1}
```

Change filament GCode for IDEX printers

```
T{next_extruder}
```

Printing by object GCode

```
;BETWEEN_OBJECTS
G92 E0
```

Filament start GCode

```
; Filament gcode
```

## Cura

*Cura does not support RatRig IDEX printers.*

:::info
This is the ONLY gcode you need, delete everything else. Copy paste the following **as is**.
:::

Machine start gcode

```properties
START_PRINT EXTRUDER_TEMP={material_print_temperature_layer_0} BED_TEMP={material_bed_temperature_layer_0} X0=%MINX% Y0=%MINY% X1=%MAXX% Y1=%MAXY%
```

machine end gcode

```properties
END_PRINT
```

To make adaptive meshing work with Cura you need to install a post processing plugin

1. in cura open menu `Help -> Show configuration folder`
2. Copy the following and save it as `MeshPrintSize.py` in the `scripts` folder

```python
# --------------------------------------------------------------------------------
# Original Version from https://gist.github.com/frankbags
# https://gist.github.com/frankbags/c85d37d9faff7bce67b6d18ec4e716ff
#
# Modified version from https://github.com/kmarty
# https://github.com/kmarty/klipper_config_km_addons/blob/master/bed_mesh_calibrate/MeshPrintSize.py
#
# thank you frankbags and kmarty!
# --------------------------------------------------------------------------------

import re #To perform the search and replace.

from ..Script import Script

class MeshPrintSize(Script):

    def getSettingDataString(self):
        return """{
            "name": "Mesh Print Size",
            "key": "MeshPrintSize",
            "metadata": {},
            "version": 2,
            "settings":{}
        }"""

    def execute(self, data):
        minMaxXY = {'MINX':0,'MINY':0,'MAXX':0,'MAXY':0}
        re_pattern = re.compile(r'%(' + r'|'.join(minMaxXY.keys()) + r')%')
        minmax_counter = len(minMaxXY)

        for i in range(len(data)):
            # in Cura "layer' != "line" :-(
            for k,v in minMaxXY.items():
                if minmax_counter:
                    result = re.search(r';' + k + r':\s*(\d*\.\d+|\d+)', data[i])
                    if result:
                        minMaxXY[k] = result.group(1)
                        minmax_counter -= 1
                else:
                    if re_pattern.search(data[i]):
                        data[i] = re.sub(r'%' + k + r'%', v, data[i])

        return data
```

3. restart cura
4. in cura open menu `Extensions -> Post processing -> Modify G-Code` and select `Mesh Print Size`

## Simplify 3D V5

*Simplify 3D does not support RatRig IDEX printers.*

:::info
This is the ONLY gcode you need, delete everything else. Copy paste the following **as is**.
:::

Start GCode

```properties
START_PRINT EXTRUDER_TEMP=[extruder0_temperature] BED_TEMP=[bed0_temperature] X0=[build_min_x] Y0=[build_min_y] X1=[build_max_x] Y1=[build_max_y]
```

End GCode

```properties
END_PRINT
```

## IdeaMaker

*IdeaMaker does not support RatRig IDEX printers.*

:::info
This is the ONLY gcode you need, delete everything else. Copy paste the following **as is**.
:::

Start GCode

```properties
START_PRINT EXTRUDER_TEMP={temperature_extruder1} BED_TEMP={temperature_heatbed} X0={print_pos_min_x} Y0={print_pos_min_y} X1={print_pos_max_x} Y1={print_pos_max_y}
```

End GCode

```properties
END_PRINT
```

:::tip
IdeaMaker will complain there's no heating commands, you can safely ignore this.
:::

## Slicer thumbnails

See the Mainsail documentation: [G-Code Thumbnails in Mainsail](https://docs.mainsail.xyz/overview/features/thumbnails)
