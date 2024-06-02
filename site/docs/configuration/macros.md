---
sidebar_position: 1
---

# Configuring RatOS Macros

RatOS comes with a bunch of flexible predefined macro's that can be customized via variables and macro hooks.

## Variables

In your printer.cfg at the top, you'll notice this:

```properties title="printer.cfg"
##########################################
### MACRO CONFIGURATION
### Configure the behavior...
##########################################
[gcode_macro RatOS]
....
```

This is a macro that serves as a place to store variables that all the RatOS macro's refer to when they're executed. Since they're gcode variables you can change them on the fly, for example from your slicer's custom gcode sections:

```gcode
SET_GCODE_VARIABLE MACRO=RatOS VARIABLE=relative_extrusion VALUE=True
SET_GCODE_VARIABLE MACRO=RatOS VARIABLE=preheat_extruder_temp VALUE=200
```

Not all of the available variables are listed in printer.cfg by default. If you want to change a variable that isn't in printer.cfg simply just add it under the `[gcode_macro RatOS]` section.

Below you'll find a list of the available variables and what they do.

### Relative Extrusion
[gcode_macro RatOS]

| Name                        | Possible Values | Default |
| --------------------------- | --------------- | ------- |
| variable_relative_extrusion | True / False    | False   |

Controls which extrusion mode START_PRINT ends in. Which value you use here depends on your slicer configuration, in other words this variable should always correspond to the extrusion mode setting in your slicer. It is recommended to configure your slicer for relative extrusion and set this variable to True.

### Absolute Position
[gcode_macro RatOS]

| Name                             | Possible Values | Default |
| -------------------------------- | --------------- | ------- |
| variable_force_absolute_position | True / False    | False   |

Forces absolute positioning before the print starts.

### Speed
[gcode_macro RatOS]

| Name                        | Possible Values | Default |
| --------------------------- | --------------- | ------- |
| variable_macro_travel_speed | number          | 300     |
| variable_macro_travel_accel | number          | 2000    |
| variable_macro_z_speed      | number          | 15      |

Travel speed to use for gcode moves in RatOS Macro's in mm/s.

### Homing
[gcode_macro RatOS]

| Name                          | Possible Values           | Default     | Description                                                                         |
| ----------------------------- | ------------------------- | ----------- | ----------------------------------------------------------------------------------- |
| variable_z_probe              | "static" / "stowable"     | "static"    | z-probe type                                                                        |
| variable_homing               | "endstops" / "sensorless" | "endstops"  | axis homing method                                                                  |
| variable_safe_home_x          | "middle" / number         | "middle"    | The x coordinate for where to return the toolhead to when homing Z                  |
| variable_safe_home_y          | "middle" / number         | "middle     | The y coordinate for where to return the toolhead to when homing Z                  |
| variable_homing_z_hop         | number                    | 15          | How much to raise the toolhead after homing Z. Probe configs may change this value. |
| variable_driver_type_x        | string                    | "tmc2209"   | The driver type used on X. Used to restore current after sensorless homing          |
| variable_driver_type_y        | string                    | "tmc2209"   | The driver type used on X. Used to restore current after sensorless homing          |
| variable_sensorless_x_current | number                    | 0.4         | stepper driver run current for sensorless x-homing                                  |
| variable_sensorless_y_current | number                    | 0.4         | stepper driver run current for sensorless y-homing                                  |


### Heating
[gcode_macro RatOS]

| Name                                       | Possible Values | Default | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| ------------------------------------------ | --------------- | ------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| variable_preheat_extruder                  | True / False    | True    | Enables or disables preheating of the nozzle to 150 degrees during the START_PRINT macro. There are several benefits to preheating the nozzle. 1) Gives the bed additional time to diffuse the heat. 2) Softens plastic that may be stuck in the nozzle so it doesn't block your probe from triggering. 3) If using a non thermally compensated inductive probe, it makes the temperature and thus the offset of the probe more predictable and consistent. |
| variable_start_print_heat_chamber_bed_temp | Number          | 115     | The bed temperature to use when heating the chamber when the `CHAMBER_TEMP` parameter is supplied to the `START_PRINT` macro.                                                                                                                                                                                                                                                                                                                               |
| variable_preheat_extruder_temp             | Number          | 150     | The temperature to preheat the extruder to, to soften the material at the nozzle tip                                                                                                                                                                                                                                                                                                                                                                        |

### Bed Mesh Calibration
[gcode_macro RatOS]

| Name                        | Possible Values | Default |
| --------------------------- | --------------- | ------- |
| variable_calibrate_bed_mesh | True / False    | True    |
| variable_adaptive_mesh      | True / False    | True    |

Whether or not to calibrate a bed mesh before each print. If you prefer calibrating your bed mesh manually instead of on each print, you can disable it by setting this to `False`. Disabling `variable_calibrate_bed_mesh` will stop RatOS from loading a bed mesh entirely. If you want it to load a mesh, you can set `variable_bed_mesh_profile` to the name of the profile you want it to load.

| Name                      | Possible Values    | Default   |
| ------------------------- | ------------------ | --------- |
| variable_bed_mesh_profile | undefined / string | undefined |

Use this variable to set name for the bed_mesh profile that RatOS calibrate and loads. If `variable_calibrate_bed_mesh` is `False` you must set this variable to the profile name you wish to load, or no bed mesh will be loaded. If variable_calibrate_bed_mesh is `True` and this variable isn't set, RatOS will use `ratos` as the profile name.

### Nozzle Priming
[gcode_macro RatOS]

| Name                            | Possible Values                   | Default     | Description                                                                                                                                                                                                                                                                                                                                                                 |
| ------------------------------- | --------------------------------- | ----------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| variable_nozzle_priming         | "primeblob" / False | "primeblob" | Whether or not to prime the nozzle during the START_PRINT macro. "primeblob" will put a small blob at the edge of the bed that is intended to wrap around the nozzle, then lifts the toolhead out of it while extruding a small line, effective for cleaning the nozzle and it's easy to clean up. |
| variable_nozzle_prime_start_x   | "min" / "max" / number            | "max"       | Where to place the primeline or blob in X. "min" starts the blob or line at x=0 + some safety margin. "max" starts the blob or line at x=max - some safety margin. If set to a number, that number will be used as the starting x coordinate of the line or blob.                                                                                                           |
| variable_nozzle_prime_start_y   | "min" / "max" / number            | "min"       | Where to place the primeline or blob in Y. "min" starts the blob or line at y=0 + some safety margin. "max" starts the blob or line at y=max - some safety margin. If set to a number, that number will be used as the starting y coordinate of the line or blob.                                                                                                           |
| variable_nozzle_prime_direction | "auto" / "forwards" / "backwards  | "auto"      | The direction to draw the line or blob in, if "backwards" the toolhead will move toward the front of the printer, if "forwards" it will move towards the back. When set to "auto" it will move towards the middle regardless of `variable_nozzle_prime_start_y`.                                                                                                            |
| variable_nozzle_prime_bridge_fan | number  | 102      | priming fan speed 0-255                                                                                                            |

### Filament loading/unloading
[gcode_macro RatOS]

| Name                            | Possible Values | Default | Description                                                                       |
| ------------------------------- | --------------- | ------- | --------------------------------------------------------------------------------- |
| variable_filament_unload_length | number          | 130     | How much to retract in mm when unloading filament after the tip has been formed   |
| variable_filament_unload_speed  | number          | 5       | How fast to retract the `filament_unload_length` filament in mm/s                 |
| variable_filament_load_length   | number          | 100     | How much to extrude in mm when loading filament to get the filament to the nozzle |
| variable_filament_load_speed    | number          | 10      | How fast to extrude the `filament_load_length` in mm/s                            |

### Parking
[gcode_macro RatOS]

| Name                               | Possible Values             | Default   | Description                                                                 |
| ---------------------------------- | --------------------------- | --------- | --------------------------------------------------------------------------- |
| variable_start_print_park_in       | "back" / "center" / "front" | "back"    | Where to park the toolhead during final nozzle heating.                     |
| variable_start_print_park_x        | number / undefined          | undefined | Custom X coordinate to park the toolhead during final nozzle heating.       |
| variable_start_print_park_z_height | number                      | 50        | The z height at which to park the toolhead during final nozzle heating.     |
| variable_end_print_park_in         | "back" / "center" / "front" | "back"    | Where to park the toolhead after ending or canceling a print.               |
| variable_end_print_park_x          | number / undefined          | undefined | Custom X coordinate to park the toolhead after ending or canceling a print. |
| variable_end_print_park_z_hop      | number                      | number    | How many mm to lift the nozzle when after ending or cancelling a print.     |
| variable_pause_print_park_in       | "back" / "center" / "front" | "back"    | Where to park the toolhead when pausing a print.                            |

### Toolhead configuration
[gcode_macro T0]

| Name                                                | Possible Values   | Default | Description                                                               |
| --------------------------------------------------- | ----------------- | ------- | ------------------------------------------------------------------------- |
| variable_hotend_type                                | "SF", "HF", "UHF" |         | Nozzle type. used for loading/unloading macros.                           |
| variable_has_cht_nozzle                             | number            |         | Nozzle type. used for loading/unloading macros.                           |
| variable_cooling_position_to_nozzle_distance        | number            | 40      | MM from the cooling position to the nozzles melting zone.                 |
| variable_tooolhead_sensor_to_extruder_gear_distance | number            | 15      | MM from the toolhead filament sensor trigger point to the extruder gears. |
| variable_extruder_gear_to_cooling_position_distance | number            | 30      | MM from the extruder gears to the cooling zone.                           |
| variable_filament_loading_nozzle_offset             | number            | -5      | MM loading offset for fine tuning.                                        |
| variable_filament_grabbing_length                   | number            | 5       | MM filament grabbing length when inserting filament into the extruder.    |
| variable_filament_grabbing_speed                    | number            | 1       | Filament grabbing speed.                                                  |
| variable_enable_insert_detection                    | True / False      | True    | Enable the filament sensor insert detection.                              |
| variable_enable_runout_detection                    | True / False      | True    | Enable the filament sensor runout detection.                              |
| variable_enable_clog_detection                      | True / False      | True    | Enable the filament sensor clog detection.                                |
| variable_unload_after_runout                        | True / False      | True    | Unload filament from toolhead after if runout has been detected.          |
| variable_resume_after_insert                        | True / False      | True    | Auto resume a paused print after runout and insert.                       |
| variable_purge_after_load                           | number            | 0       | Purge x mm after the filament has been loaded to the nozzle tip.          |
| variable_purge_before_unload                        | number            | 0       | Purge x mm before the filament unloads.                                   |
| variable_extruder_load_speed                        | number            | 60      | Extruder/cooling zone loading speed.                                      |
| variable_filament_load_speed                        | number            | 10      | Filament nozzle loading speed.                                            |
| variable_temperature_offset                         | number            | 0       | Adds a positive or negative offset to the nozzle temperature.             |
| variable_has_oozeguard                              | True / False      | False   | Toolhead has a oozeguard.                                                 |
| variable_has_front_arm_nozzle_wiper                 | True / False      | False   | Toolhead has a front arm nozzle wiper.                                    |
| variable_loading_position                           | number            | 0       | X-position for filament loading/unloading actions.                        |
| variable_parking_position                           | number            | 0       | Toolhead parking x-position.                                              |

### VAOC
[gcode_macro _VAOC]

| Name                                | Possible Values | Default | Description                                                             |
| ----------------------------------- | --------------- | ------- | ----------------------------------------------------------------------- |
| variable_is_fixed                   | True / False    | False   | VAOC is installed on a fix position.                                    |
| variable_safe_z                     | number          | 60      | Safe z-height for xy travel moves.                                      |
| variable_auto_z_offset_calibration  | True / False    | True    | Performs a auto z-offset calibration before the print starts if needed. |
| variable_enable_camera_cooling      | True / False    | True    | Enables the part cooling fan of the currently loaded toolhead.          |
| variable_camera_cooling_fan_speed   | number          | 0.3     | Part cooling fan speed of the currently loaded toolhead.                |
| variable_camera_cooling_temperature | number          | 50      | Enables the integrated VAOC fan at the configured bed temperature.      |
| variable_toolchange_travel_speed    | number          | 300     | XY travel move speeds.                                                  |
| variable_toolchange_travel_accel    | number          | 5000    | XY travel move sccelerations.                                           |

### IDEX
[gcode_macro RatOS]

| Name                                 | Possible Values | Default | Description                                                                                |
| ------------------------------------ | --------------- | ------- | ------------------------------------------------------------------------------------------ |
| variable_auto_center_subject         | True / False    | False   | Experimental auto centering subject on build plate for copy and mirror mode.               |
| variable_toolchange_zhop             | number          | 2.0     | Toolshift z-hop.                                                                          |
| variable_toolchange_zspeed           | number          | 25      | Toolshift z-hop speed.                                                                    |
| variable_toolchange_sync_fans        | True / False    | False   | Synchronizes fan speeds while printing.                                                    |
| variable_toolchange_combined_zhop    | True / False    | False   | Combines z-hop and retract/deretract moves for toolshifts.                                 |
| variable_toolchange_travel_speed     | number          | 300     | Toolshift travel speed.                                                                    |
| variable_toolchange_travel_accel     | number          | 5000    | Toolshift travel acceleration.                                                             |
| variable_toolchange_extrusion        | number          | 2.0     | Toolshift deretraction.                                                                    |
| variable_toolchange_retraction       | number          | 2.0     | Toolshift retraction.                                                                      |
| variable_toolchange_feedrate         | number          | 7200    | Extruder feedrate for retract/deretract moves for toolshifts.                              |
| variable_toolchange_prepurging_timer | number          | 0       | Prepurge some filament before going back to the buildplate after X seconds of inactivity.  |
| variable_toolchange_purge            | number          | 25      | MM of filament that gets prepruged in case the timer has been configured,                  |
| variable_toolchange_standby_temp     | number          | -1      | If configured the toolheads are going into standby mode when parked.                       |
| variable_toolchange_first_purge      | number          | 50      | MM of filament that gets purged before a toolheads first use.                              |

### Beacon probe
[gcode_macro RatOS]

| Name                                           | Possible Values | Default | Description                                               |
| ---------------------------------------------- | --------------- | ------- | --------------------------------------------------------- |
| variable_beacon_bed_mesh_scv                   | number          | 25      | Square corner velocity for beacon proximity bed meshing.  |
| variable_beacon_contact_z_homing               | True / False    | False   | Use beacon contact for z-homing.                          |
| variable_beacon_contact_z_calibration          | True / False    | False   | Use beacon contact z-calibration.                         |
| variable_beacon_contact_calibration_location   | number          | 130     | Beacon contact z-calibration location.                    |
| variable_beacon_contact_calibrate_margin_x     | number          | 30      | Beacon contact z-calibration x-margin.                    |
| variable_beacon_contact_bed_mesh               | True / False    | False   | Use beacon contact for bed meshing.                       |
| variable_beacon_contact_bed_mesh_samples       | number          | 2       | Beacon contact bed mesh probe samples.                    |
| variable_beacon_contact_z_tilt_adjust          | True / False    | False   | Use beacon contact for z-tilting.                         |
| variable_beacon_contact_z_tilt_adjust_samples  | number          | 2       | Beacon contact z-tilt probe samples.                      |
| variable_beacon_contact_prime_probing          | True / False    | False   | Use beacon contact to probe for prime blobs.              |
| variable_beacon_contact_calibration_temp       | number          | 150     | Beacon contact z-calibration nozzle temperature.          |
| variable_beacon_contact_expansion_compensation | True / False    | False   | Use nozzle thermal expansion compensation.                |
| variable_beacon_contact_expansion_multiplier   | number          | 1.0     | Multiplier for the nozzle thermal expansion compensation. |

### Stowable probes
[gcode_macro RatOS]

These variables are only relevant when using a stowable probe such as Euclid or Klicky. Use these to customize and finetune the deployment and stowing procedures.

| Name                                       | Possible Values | Default   | Description                                                                                                                               |
| ------------------------------------------ | --------------- | --------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| variable_stowable_probe_position_preflight | Tuple           | undefined | The coordinates to move the toolhead to before the probe deployment routine. Example: `[30, 60]`                                          |
| variable_stowable_probe_position_side      | Tuple           | undefined | The coordinates to move the toolhead to before entering the dock during deployment, or exiting the dock while stowing. Example: `[30, 0]` |
| variable_stowable_probe_position_dock      | Tuple           | undefined | The coordinates of the toolhead when it's positioned perfectly inside the dock for pickup. Example: `[0, 0]`                              |
| variable_stowable_probe_position_exit      | Tuple           | undefined | The coordinates to move the toolhead to when exiting the dock while deploying or entering the dock while stowing. Example: `[0, 60]`      |

### Skew profile

| Name                  | Possible Values     | Default   | Description                                                                                                                                                                       |
| --------------------- | ------------------- | --------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| variable_skew_profile | string or undefined | undefined | Use this if you have calibrated and saved a skew profile that you want to load in the START_PRINT macro. To activate it, set the variable to the name of your saved skew profile. |

## User macro hooks

These hooks do nothing by default, that means you can safely implement them in your USER OVERRIDES section without copy pasting anything from the RatOS config files, like so:

```properties
[gcode_macro _USER_START_PRINT_BED_MESH]
gcode:
	SETUP_KAMP_MESHING
```

### \_USER_START_PRINT_BEFORE_HOMING

Runs before the printer homes at the start of START_PRINT.

### \_USER_START_PRINT_HEAT_CHAMBER

Runs right after the chamber has started heating, if CHAMBER_TEMP is supplied to START_PRINT.

### \_USER_START_PRINT_AFTER_HEATING_BED

Runs right after the bed has reached temp, before the internal \_START_PRINT_AFTER_HEATING_BED

### \_USER_START_PRINT_BED_MESH

Runs before \_START_PRINT_BED_MESH

### \_USER_START_PRINT_PARK

Runs before \_START_PRINT_PARK

### \_USER_START_PRINT_AFTER_HEATING_EXTRUDER

Runs just before \_START_PRINT_AFTER_HEATING_EXTRUDER

### \_USER_END_PRINT_BEFORE_HEATERS_OFF

Runs before the heaters are turned off in END_PRINT

### \_USER_END_PRINT_AFTER_HEATERS_OFF

Runs after the heaters are turned off in END_PRINT

### \_USER_END_PRINT_PARK

Runs before the toolhead is parked in END_PRINT

### \_USER_START_PRINT

Runs before the START_PRINT macro

### \_USER_END_START_PRINT

Runs after the START_PRINT macro

### \_USER_START_FEATURE

### \_USER_END_FEATURE

## Internal macro hooks

These hooks are used internally, so if you override these be sure to copy paste the original implementation and modify that or you may break some functionality. Remember to check if there's an override in the printer's macro.cfg file, in which case that's the one you would copy.

### \_START_PRINT_HEAT_CHAMBER

Heats the chamber, if CHAMBER_TEMP is supplied to START_PRINT.

### \_START_PRINT_AFTER_HEATING_BED

Runs right after the bed has reached temp, after \_USER_START_PRINT_AFTER_HEATING_BED. It is usually used for additional bed calibration, such as Z_TILT_ADJUST or QUAD_GANTRY_LEVELING depending on the printer.

### \_START_PRINT_BED_MESH

Handles bed meshing logic.

### \_START_PRINT_PARK

Parks the extruder while heating the nozzle to print temperature.

### \_START_PRINT_AFTER_HEATING_EXTRUDER

Primes the nozzle and loads the skew profile if any is defined in the RatOS variables.

### \_END_PRINT_AFTER_HEATERS_OFF

Runs right after the heaters have been turned off in the END_PRINT macro.


