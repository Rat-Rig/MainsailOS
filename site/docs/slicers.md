@ -55,7 +55,7 @@ Make sure the box labeled "Emit temperature commands automatically" is **uncheck
:::

```properties
START_PRINT EXTRUDER_TEMP={first_layer_temperature[0]},{first_layer_temperature[1]} EXTRUDER_OTHER_LAYER_TEMP={temperature[0]},{temperature[1]} BED_TEMP=[first_layer_bed_temperature] INITIAL_TOOL={initial_tool} TOTAL_LAYER_COUNT={total_layer_count} X0={first_layer_print_min[0]} Y0={first_layer_print_min[1]} X1={first_layer_print_max[0]} Y1={first_layer_print_max[1]}
START_PRINT EXTRUDER_TEMP={first_layer_temperature[0]},{first_layer_temperature[1]} EXTRUDER_OTHER_LAYER_TEMP={temperature[0]},{temperature[1]} BED_TEMP=[first_layer_bed_temperature] CHAMBER_TEMP=[chamber_temperature] INITIAL_TOOL={initial_tool} TOTAL_LAYER_COUNT={total_layer_count} X0={first_layer_print_min[0]} Y0={first_layer_print_min[1]} X1={first_layer_print_max[0]} Y1={first_layer_print_max[1]}
```

End GCode
@ -100,20 +100,6 @@ Start filament GCode
SET_PRESSURE_ADVANCE ADVANCE=0.05
```

### Chamber temperature with Prusa Slicer

Unlike Super Slicer and Orca Slicer, Prusa Slicer doesnt come with a chamber temperature configuration option. There is a workarround, but it works only if the filament profile notes are empty and not used otherwise.

- in your filament profile notes enter `CHAMBER_TEMP=50`
- add `{filament_notes[current_extruder]}` to the end of your printer start gcode.

This isnt a ideal solution but it lets you pass the chamber temperature to the START_PRINT macro based on your filament profiles.

Another option is to to hardcode the CHAMBER_TEMP parameter directly into the printer start gcode. In this case the parameters will be activated for every print, no matter which filament profile you use.

- add `CHAMBER_TEMP=50` to the end of your printer start gcode.


# Super Slicer

*Super Slicer comes with full IDEX support.*
