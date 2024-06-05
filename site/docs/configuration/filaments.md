# RatOS 2.1 Filament Macros

- [LOAD_FILAMENT](#load_filament)
- [UNLOAD_FILAMENT](#unload_filament)
- [JOIN_SPOOLS](#join_spools)
- [M600](#m600)

## LOAD_FILAMENT
- **Parameters** `[TOOLHEAD|TEMP]`

	`TOOLHEAD` = Only needed for IDEX printer. 0 = Left toolhead, 1 = right Toolhead. Default value is -1.

	`TEMP` = The hotend temperature for the loading process. Default value is 220°C.

## UNLOAD_FILAMENT
- **Parameters** `[TOOLHEAD|TEMP]`

	`TOOLHEAD` = Only needed for IDEX printer. 0 = Left toolhead, 1 = right Toolhead. Default value is -1.

	`TEMP` = The hotend temperature for the unloading process. Default value is 220°C.

## JOIN_SPOOLS
- **Parameters** `[SPOOLS]`

    On IDEX printers you can use the RatOS spool join feature to switch to another filament spool once a runout has been detected. This works only if you have a RatOS runout sensor configured according to the [official RatOS filament sensor documentation](filament_sensors.md). 

	`SPOOLS` = Eg. `0,1` or `1,0`, both settings do the same actually. If one of the spools runs out it switches fully automated to the other and resumes the print.


## M600
- **Parameters** 

    Pauses the print and unloads the filament from the hotend. This macro can be used for manual filament swaps. 