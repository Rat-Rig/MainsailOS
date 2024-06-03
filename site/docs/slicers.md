# Slicer Configuration

# Macros

RatOS comes with START_PRINT and END_PRINT macros that you can call directly from your slicers. This way the printer knows how to start a print, and you can there easily switch between slicers without worrying if you changed anything in another slicer.
The g-code for these macros are found in `config/printers/[PRINTER_NAME]/macros.cfg`

## Prusa Slicer 

*Prusa Slicer comes with full IDEX support and is the recommended slicer for all RatRig printers.*

:::info
This is the ONLY gcode you need, delete everything else. Copy paste the following **as is**.
:::

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

## Super Slicer

*Super Slicer comes with full IDEX support.*

:::info
You should be using "Klipper" as the gcode flavor and have the "Only custom Start G-Code" box checked in Printer Settings -> Custom G-Code
:::
:::info
This is the ONLY gcode you need, delete everything else. Copy paste the following **as is**.
:::

Start GCode for single toolhead printers

```properties
START_PRINT EXTRUDER_TEMP={first_layer_temperature[0]} EXTRUDER_OTHER_LAYER_TEMP={temperature[0]} BED_TEMP=[first_layer_bed_temperature] CHAMBER_TEMP=[chamber_temperature] TOTAL_LAYER_COUNT={total_layer_count} X0={first_layer_print_min[0]} Y0={first_layer_print_min[1]} X1={first_layer_print_max[0]} Y1={first_layer_print_max[1]}
```

Start GCode for IDEX printers

```properties
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
Make sure to set the GCode flavor to klipper
:::

Start GCode for single toolhead printers

```properties
START_PRINT EXTRUDER_TEMP={first_layer_temperature[0]} EXTRUDER_OTHER_LAYER_TEMP={nozzle_temperature[0]} BED_TEMP=[bed_temperature_initial_layer_single] TOTAL_LAYER_COUNT={total_layer_count} X0={adaptive_bed_mesh_min[0]} Y0={adaptive_bed_mesh_min[1]} X1={adaptive_bed_mesh_max[0]} Y1={adaptive_bed_mesh_max[1]}
```

Start GCode for IDEX printers

```properties
START_PRINT EXTRUDER_TEMP={first_layer_temperature[0]},{first_layer_temperature[1]} EXTRUDER_OTHER_LAYER_TEMP={nozzle_temperature[0]},{nozzle_temperature[1]} BED_TEMP=[bed_temperature_initial_layer_single] INITIAL_TOOL={initial_tool} TOTAL_LAYER_COUNT={total_layer_count} X0={adaptive_bed_mesh_min[0]} Y0={adaptive_bed_mesh_min[1]} X1={adaptive_bed_mesh_max[0]} Y1={adaptive_bed_mesh_max[1]}
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
START_PRINT EXTRUDER_TEMP={material_print_temperature_layer_0} BED_TEMP={material_bed_temperature_layer_0}
```

machine end gcode

```properties
END_PRINT
```

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
