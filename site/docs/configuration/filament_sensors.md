# RatOS 2.1 Filament Sensors

RatOS supports multiple sensor types that are toolhead aware. These sensors can be combined to work together. Configure them as described, there are no other changes needed. 

When combining toolhead and bowden sensors then each sensor has only one function. The Toolhead sensor reacts to the insert detection and the bowden sensor is responsible for the runout detection. This has the benefit that one doesnt need to open a heated chamber and remove the bowden tube to remove the old filament, it will be ejected and can be easily removed at the end of the bowden tube.

:::info
Sensors can be temporarily deactivated by disabling them in the mainsail user interface.
:::

:::info
If a sensor shows detected if no filament is loaded and empty if a filament is loaded, inverse the `switch_pin` by adding or removing a `!` in front of the pin name. The sensor state will be displayed in the mainsail user interface.
:::

### Supported Sensors

- [Toolhead Filament Sensor](#toolhead-filament-sensor)
- [Bowden Filament Sensor](#bowden-filament-sensor)
- [Motion Filament Sensor](#motion-filament-sensor)
- [Action Button](#action-button)

### RatOS configuration

- [Sensor features](#sensor-features)
- [Filament grabbing](#filament-grabbing)
- [Purging](#purging)
- [Feedrates](#feedrates)
- [Retraction](#retraction)
- [Advanced](#advanced)

# Toolhead Filament Sensor

Toolhead filament sensors are attached directly onto the toolhead.

### Features

- runout detection 
- insert detection
- auto load filament on insert
- auto unload filament after runout
- auto resume print after insert
- spool join for IDEX printer
- filament grabbing on insert
- check for filament presence/runuout before starting a print
- frontend toolhead color used as status display

### Configuration
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

# Bowden Filament Sensor

Bowden filament sensors are attached somewhere at the bowden tube.

### Features

- runout detection 
- insert detection (no automatic action available, macro can be overridden)
- auto unload filament after runout
- spool join for IDEX printer
- check for filament presence/runuout before starting a print
- frontend toolhead color used as status display

### Configuration
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

# Motion Filament Sensor

Motion sensors can be used for clog detection.

### Features

- optional runout detection 
- optional insert detection (no automatic action available, macro can be overridden)
- clog detection
- auto unload filament after runout
- spool join for IDEX printer

### Configuration
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

# Action Button

Some filament sensors, like the orbiter filament sensor, do come with a action button.

### Features

- filament unload

### Configuration
```
[gcode_button toolhead_filament_sensor_button_t0]
pin: ^!toolboard_t0:PB4 
release_gcode:     
  _ON_FILAMENT_SENSOR_BUTTON_PRESSED TOOLHEAD=0
press_gcode:
```

# RatOS Configuration

### Sensor features
```
[gcode_macro T0]
variable_enable_insert_detection: True     # enables the insert detection
variable_enable_runout_detection: True     # enables the runout detection
variable_enable_clog_detection: True       # enables the clog detection
variable_unload_after_runout: True         # unload filament after runout has been detected
variable_resume_after_insert: True         # resumes the print after inserting new filament
```

### Filament grabbing
When inserting a filament into the toolhead filament sensor, the extruder gears will grab the filament, even if the hotend is still cold.
```
[gcode_macro T0]
variable_filament_grabbing_speed: 1     # filament grabbing speed in mm/s
variable_filament_grabbing_length: 5    # filament grabbing length in mm
```

### Purging
```
[gcode_macro T0]
variable_purge_after_load: 30      # purge x mm after the filament has been loaded to the nozzle tip
variable_purge_before_unload: 0    # purge x mm before the filament unloads
```

### Feedrates
```
[gcode_macro T0]
variable_filament_load_speed: 10   # filament nozzle loading speed
variable_extruder_load_speed: 60   # extruder/cooling zone loading speed
```

### Retraction
```
[gcode_macro PAUSE]
variable_retract: 1.5   # retract on pause print
variable_extrude: 1.5   # extrude before resume print
```

### Parking Position
```
[gcode_macro RatOS]
variable_runout_park_in: "front"   # back|front|center = gantry parking position if a runout or clog has been detected
variable_runout_park_x: 50         # float = if configured the x position of the toolhead. if not configured it will park in the middle
```

### Advanced
```
[gcode_macro T0]
variable_cooling_position_to_nozzle_distance: 40            # distance between the cooling position and the nozzle
variable_tooolhead_sensor_to_extruder_gear_distance: 15     # distance between the filament sensor trigger point 
                                                            # and where the filament hits the extruder gears
variable_extruder_gear_to_cooling_position_distance: 30     # distance between the extruder gears and the center of the heatsink cooling tube
variable_filament_loading_nozzle_offset: -10                # offset tuning value. positive or negative number. 
                                                            # different nozzles can lead to too much or not enough extrusion while loading the filament
```
