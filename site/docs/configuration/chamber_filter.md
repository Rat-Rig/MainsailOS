# RatOS 2.1 Chamber filter control

RatOS comes with a built in chamber filter control. 

## Prerequisites

To be able to use the chamber control feature you just need to configure a generic fan with the name `filter`. 
```
[fan_generic filter]
```

## RatOS Configuration

The feature is activated by default, you dont need to do anything. But you can override the settings in your printer.cfg if wanted. 
```
[gcode_macro RatOS]
variable_chamber_filter_enable: True                     # True|False = enable chamber filter control
variable_chamber_filter_speed: 1.0                       # float = chamber filter fan speed.
variable_chamber_filter_enable_at: "after_print_start"   # before_print_start|after_print_start|print_end = when to enable the filter
variable_chamber_filter_disable_period: 300              # int = disable fan after X seconds after the print ends
variable_chamber_filter_disable_bed_temp: 0              # int = wait for X°C bed temp after the print ends before disabling the filter
```
