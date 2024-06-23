# RatOS 2.1 Chamber heater control

RatOS comes with a built in chamber heater control that supports 3 differenct scenarios. 

- [1. Hotend thermistor controlled chamber heating](#1-hotend-thermistor-controlled-chamber-heating)
- [2. Classic chamber heater control](#2-classic-chamber-heater-control)
- [3. External heater device control](#3-external-heater-device-control)


## Prerequisites
- Make sure to configure your slicer according to the [official RatOS slicer configuration](../slicers.md)

## 1. Hotend thermistor controlled chamber heating
RatOS uses by default the hotend thermistor and the bed heater to control the chamber temperature. No further configuration needed.

## 2. Classic chamber heater control
A pwm controlled chamber heater, a heater fan and a chamber thermistor to control the chamber temperature. 

### Configuration

Make sure to name your devices after this example configuration. 
```
[gcode_macro RatOS]
variable_chamber_heater_type: "generic_heater"

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

## 3. External heater device control
A dedicated heater device that can be switched on/off by a output pin and a chamber thermistor to control the chamber temperature. 

### Configuration

Make sure to name your devices after this example configuration. 
```
[gcode_macro RatOS]
variable_chamber_heater_type: "output_pin"

[temperature_sensor chamber]
sensor_type: ATC Semitec 104GT-2
sensor_pin: PF4

[heater_fan chamber_heater_fan]
[output_pin my_pin]
pin: PE14
```

### RatOS Configuration

```
[gcode_macro RatOS]
variable_chamber_heater_enable: True                      # True|False = enable chamber heater control
variable_chamber_heater_type: "hotend"                    # generic_heater|output_pin|hotend = type of heater control
variable_chamber_heater_preheating_temp: 150              # int = the temp the generic_heater is set to when preheating the chamber
variable_chamber_heater_heating_temp_offset: 25           # int = the temp offset for the generic_heater, in addition to the target chamber_temp, while printing
variable_chamber_heater_air_circulation_enable: True      # True|False = uses the part cooling to blow air from the top of the chamber to the bottom when preheating the chamber
variable_chamber_heater_air_circulation_fan_speed: 0.35   # float = the part cooling fan speed that is used to circulate the air when preheating the chamber
variable_chamber_heater_air_circulation_y_pos: 0          # float = toolhead y-pos when circulating the air
variable_chamber_heater_air_circulation_z_pos: 100        # float = toolhead z-pos when circulating the air
```
