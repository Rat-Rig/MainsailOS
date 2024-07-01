# RatOS 2.1 Chamber heater control

RatOS comes with a built in chamber heater control that supports 3 differenct scenarios. 

- [1. Bed heater](#1-bed-heater)
- [2. Internal heater](#2-internal-heater)
- [3. External heater](#3-external-heater)


## Prerequisites
- Make sure to configure your slicer according to the [official RatOS slicer configuration](../slicers.md)

## 1. Bed heater
RatOS uses by default the bed heater to heat the chamber, the hotend thermistor or a chamber thermistor will be used to wait for the initial chamber temperature.

- if no `temperature_sensor chamber` is defined, the hotend thermistor will be used to wait for the initial chamber temperature.

### Configuration

*Make sure to name your devices after this example configuration.* 
```
[temperature_sensor chamber]
sensor_type: ATC Semitec 104GT-2
sensor_pin: PF4
```

## 2. Internal heater
A pwm controlled chamber heater, a heater fan and a chamber thermistor to control the chamber temperature. 

- if no `temperature_sensor chamber` is defined, the hotend thermistor will be used to wait for the initial chamber temperature.
- if `temperature_sensor chamber` is defined it will be used for the automatic chamber temperature control. 

### Configuration

*Make sure to name your devices after this example configuration.* 
```
[temperature_sensor chamber]
sensor_type: ATC Semitec 104GT-2
sensor_pin: PF4

[heater_generic chamber_heater]
gcode_id: chamber_heater
heater_pin: PA2
smooth_time: 10
sensor_type: PT1000
sensor_pin: PF5
control: pid
pid_kp: 24.750
pid_ki: 2.578
pid_kd: 59.400
pwm_cycle_time: 0.25
min_temp: 0
max_temp: 200
max_power: 1.0

[heater_fan chamber_heater_fan]
pin: PE14
heater: chamber_heater
heater_temp: 40
```

## 3. External heater
A dedicated heater device with or without its own temperature control that can be switched on/off by a relais/output_pin and a chamber thermistor to control the initial chamber temperature. 

- if no `temperature_sensor chamber` is defined, the hotend thermistor will be used to wait for the initial chamber temperature.
- a `temperature_sensor chamber` can be used for the automatic chamber temperature control. In this case set `chamber_heater_control_external_heater` to `True`. This will turn the heater on/off when needed.

### Configuration

*Make sure to name your devices after this example configuration.*
```
[temperature_sensor chamber]
sensor_type: ATC Semitec 104GT-2
sensor_pin: PF4

[output_pin chamber_heater_pin]
pin: PE14
```

## Extra Chamber Heater Fan
A extra fan can be configured to support the chamber heating process, control its speed with the `chamber_heater_extra_fan_speed` variable.
```
[fan_generic chamber_heater_extra_fan]
```

## User Macro Hooks
```
[gcode_macro _USER_CHAMBER_HEATER_BEFORE_PREHEATING]
description: Will be executed before chamber preheating, only if heating is needed.
gcode:

[gcode_macro _USER_CHAMBER_HEATER_AFTER_PREHEATING]
description: Will be executed after chamber preheating, only if heating was needed.
gcode:
```

### RatOS Configuration

```
[gcode_macro RatOS]
variable_chamber_heater_enable: True                      # True|False = enable chamber heater control
variable_chamber_heater_bed_temp: 115                     # int = bed temperature during chamber preheating
variable_chamber_heater_preheating_temp: 150              # int = the temp the generic_heater is set to when preheating the chamber
variable_chamber_heater_heating_temp_offset: 25           # int = the temp offset for the generic_heater, in addition to the target chamber_temp, while printing
variable_chamber_heater_control_external_heater: False    # True|False = automatic heater control for external heater devices
variable_chamber_heater_air_circulation_enable: True      # True|False = uses the part cooling to blow air from the top of the chamber to the bottom when preheating the chamber
variable_chamber_heater_air_circulation_fan_speed: 0.35   # float = the part cooling fan speed that is used to circulate the air when preheating the chamber
variable_chamber_heater_air_circulation_y_pos: 0          # float = toolhead y-pos when circulating the air
variable_chamber_heater_air_circulation_z_pos: 100        # float = toolhead z-pos when circulating the air
variable_chamber_heater_extra_fan_speed: 1.0              # float = the extra chamber heater fan that is used to circulate the air when preheating the chamber
variable_chamber_heater_filter_fan_speed: 1.0             # float = the filter fan speed that is used to circulate the air when preheating the chamber
```
