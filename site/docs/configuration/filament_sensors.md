# RatOS Filament Sensors

## Sensor types
- Toolhead filament sensors are attached directly onto the toolhead 
- Bowden filament sensors are bowden inline sensors, like the BTT SFS filament sensor
- Motion sensors can be used for clog detection

## Sensor action buttons
All filament sensor types can have a optional action button

## Toolhead filament sensor features
- runout detection 
- insert detection
- auto load filament on insert
- auto unload filament after runout
- auto resume print after insert
- spool join for IDEX printer
- filament grabbing on insert
- check for filament presence/runuout before starting a print
- frontend toolhead color used as status display

# Bowden filament sensor features
- runout detection 
- insert detection (no automatic action available, macro can be overridden)
- auto unload filament after runout
- spool join for IDEX printer
- check for filament presence/runuout before starting a print
- frontend toolhead color used as status display

# Motion filament sensor features
- optional runout detection 
- optional insert detection (no automatic action available, macro can be overridden)
- clog detection
- auto unload filament after runout
- spool join for IDEX printer

## Action button features
- filament unload

## Toolhead filament sensor configuration
```
[filament_switch_sensor toolhead_filament_sensor_t0]
pause_on_runout: False
event_delay: 0.1
switch_pin: ^!toolboard_t0:PB3
runout_gcode: 
    _ON_TOOLHEAD_FILAMENT_SENSOR_RUNOUT TOOLHEAD=0
insert_gcode: 
    _ON_TOOLHEAD_FILAMENT_SENSOR_INSERT TOOLHEAD=0
```

## Bowden filament sensor configuration
```
[filament_switch_sensor bowden_filament_sensor_t0]
pause_on_runout: False
event_delay: 0.1
switch_pin: ^!PC15
runout_gcode: 
    _ON_BOWDEN_FILAMENT_SENSOR_RUNOUT TOOLHEAD=0
insert_gcode: 
    _ON_BOWDEN_FILAMENT_SENSOR_INSERT TOOLHEAD=0
```

## Filament motion sensor configuration
example configuration for the BTT SFS Filament Sensor
```
[filament_motion_sensor bowden_filament_clog_t0]
switch_pin: ^PG15
detection_length: 8
extruder: extruder   # extruder for T0, extruder1 for T1
pause_on_runout: False
event_delay: 3.0
pause_delay: 0.5
runout_gcode:
  _ON_BOWDEN_FILAMENT_SENSOR_CLOG TOOLHEAD=0
insert_gcode:
```

## Filament sensor action button configuration
```
[gcode_button toolhead_filament_sensor_button_t0]
pin: ^!toolboard_t0:PB4 
release_gcode:     
  _ON_FILAMENT_SENSOR_BUTTON_PRESSED TOOLHEAD=0
press_gcode:
```

## Example configuration for the Orbiter filament sensor with action button
```
[filament_switch_sensor toolhead_filament_sensor_t0]
pause_on_runout: False
event_delay: 0.1
switch_pin: ^!toolboard_t0:PB3
runout_gcode: 
    _ON_TOOLHEAD_FILAMENT_SENSOR_RUNOUT TOOLHEAD=0
insert_gcode: 
    _ON_TOOLHEAD_FILAMENT_SENSOR_INSERT TOOLHEAD=0

[gcode_button toolhead_filament_sensor_button_t0]
pin: ^!toolboard_t0:PB4 
release_gcode:     
  _ON_FILAMENT_SENSOR_BUTTON_PRESSED TOOLHEAD=0
press_gcode:
```

## Example configuration for the BTT SFS V2 filament sensor with clog detection
```
[filament_switch_sensor bowden_filament_sensor_t0]
pause_on_runout: False
event_delay: 0.1
switch_pin: ^!PC15
runout_gcode: 
    _ON_BOWDEN_FILAMENT_SENSOR_RUNOUT TOOLHEAD=0
insert_gcode: 
    _ON_BOWDEN_FILAMENT_SENSOR_INSERT TOOLHEAD=0

[filament_motion_sensor bowden_filament_clog_t0]
switch_pin: ^PG15
detection_length: 8
extruder: extruder   # extruder for T0, extruder1 for T1
pause_on_runout: False
event_delay: 3.0
pause_delay: 0.5
runout_gcode:
  _ON_BOWDEN_FILAMENT_SENSOR_CLOG TOOLHEAD=0
insert_gcode:
```

## Example configuration for the Orbiter filament sensor with action button and a additional bowden filament sensor
When combining toolhead and bowden sensors then each sensor has only one function.
The Toolhead reacts to the insert detection and the bowden sensor is responsible for the runout detection.
This has the benefit that one doesnt need to remove the bowden tube from the toolhead sensor to remove the old filament, it will be ejected and can be easily removed at the end of the bowden tube.
```
[filament_switch_sensor toolhead_filament_sensor_t0]
pause_on_runout: False
event_delay: 0.1
switch_pin: ^!toolboard_t0:PB3
runout_gcode: 
    _ON_TOOLHEAD_FILAMENT_SENSOR_RUNOUT TOOLHEAD=0
insert_gcode: 
    _ON_TOOLHEAD_FILAMENT_SENSOR_INSERT TOOLHEAD=0

[gcode_button toolhead_filament_sensor_button_t0]
pin: ^!toolboard_t0:PB4 
release_gcode:     
  _ON_FILAMENT_SENSOR_BUTTON_PRESSED TOOLHEAD=0
press_gcode:

[filament_switch_sensor bowden_filament_sensor_t0]
pause_on_runout: False
event_delay: 0.1
switch_pin: ^!PC15
runout_gcode: 
    _ON_BOWDEN_FILAMENT_SENSOR_RUNOUT TOOLHEAD=0
insert_gcode: 
    _ON_BOWDEN_FILAMENT_SENSOR_INSERT TOOLHEAD=0
```

## Example configuration for a toolhead filament sensor, a inline motion sensor for clog detection and a bowden filament sensor
Toolhead sensor will be responsible for insert actions, motion sensor for clog detection and bowden sensor for runout detection.
```
[filament_switch_sensor toolhead_filament_sensor_t0]
pause_on_runout: False
event_delay: 0.1
switch_pin: ^!toolboard_t0:PB3
runout_gcode: 
    _ON_TOOLHEAD_FILAMENT_SENSOR_RUNOUT TOOLHEAD=0
insert_gcode: 
    _ON_TOOLHEAD_FILAMENT_SENSOR_INSERT TOOLHEAD=0

[filament_motion_sensor bowden_filament_clog_t0]
switch_pin: ^PG15
detection_length: 8
extruder: extruder   # extruder for T0, extruder1 for T1
pause_on_runout: False
event_delay: 3.0
pause_delay: 0.5
runout_gcode:
  _ON_BOWDEN_FILAMENT_SENSOR_CLOG TOOLHEAD=0
insert_gcode:

[filament_switch_sensor bowden_filament_sensor_t0]
pause_on_runout: False
event_delay: 0.1
switch_pin: ^!PC15
runout_gcode: 
    _ON_BOWDEN_FILAMENT_SENSOR_RUNOUT TOOLHEAD=0
insert_gcode: 
    _ON_BOWDEN_FILAMENT_SENSOR_INSERT TOOLHEAD=0
```

## Enable filament sensor RatOS features
```
[gcode_macro T0]
variable_enable_insert_detection: True     # enables the insert detection
variable_enable_runout_detection: True     # enables the runout detection
variable_enable_clog_detection: True       # enables the clog detection
variable_unload_after_runout: True         # unload filament after runout has been detected
variable_resume_after_insert: True         # resumes the print after inserting new filament
```

## Filament grabbing on filament insert
When inserting a filament into the toolhead filament sensor, the extruder gears will grab the filament, even if the hotend is still cold.
```
[gcode_macro T0]
variable_filament_grabbing_speed: 1     # filament grabbing speed in mm/s
variable_filament_grabbing_length: 5    # filament grabbing length in mm
```

## Purge on load/unload filament
```
[gcode_macro T0]
variable_purge_after_load: 30      # purge x mm after the filament has been loaded to the nozzle tip
variable_purge_before_unload: 0    # purge x mm before the filament unloads
```

## Load/unload feedrates
```
[gcode_macro T0]
variable_filament_load_speed: 10   # filament nozzle loading speed
variable_extruder_load_speed: 60   # extruder/cooling zone loading speed
```

## Advanced configuration
```
[gcode_macro T0]
variable_cooling_position_to_nozzle_distance: 40            # distance between the cooling position and the nozzle
variable_tooolhead_sensor_to_extruder_gear_distance: 15     # distance between the filament sensor trigger point 
                                                            # and where the filament hits the extruder gears
variable_extruder_gear_to_cooling_position_distance: 30     # distance between the extruder gears and the center of the heatsink cooling tube
variable_filament_loading_nozzle_offset: -10                # offset tuning value. positive or negative number. 
                                                            # different nozzles can lead to too much or not enough extrusion while loading the filament
```

## Useful configuration which can be used to tune the runout and auto resume workflow
```
[gcode_macro PAUSE]
variable_retract: 1.5   # retract on pause print
variable_extrude: 1.5   # extrude before resume print
```
