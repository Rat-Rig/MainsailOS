# RatOS 2.1 LED control

RatOS comes with a built in LED status control for toolhead LED's. It also lets the user add custom LEDs that can be automatically controlled by RatOS. 

## Example toolhead LED configuration for single toolhead printer

Make sure to name your LED `nozzle_led_t0`.

```
[neopixel nozzle_led_t0]
pin: toolboard_t0:PD3
chain_count: 3
color_order: GRB
initial_RED: 1.0
initial_GREEN: 1.0
initial_BLUE: 1.0
```

## Example toolhead LED configuration for IDEX printer

Make sure to name your LED `nozzle_led_t0` and `nozzle_led_t1`.

```
[neopixel nozzle_led_t0]
pin: toolboard_t0:PD3
chain_count: 3
color_order: GRB
initial_RED: 1.0
initial_GREEN: 1.0
initial_BLUE: 1.0

[neopixel nozzle_led_t1]
pin: toolboard_t0:PD3
chain_count: 3
color_order: GRB
initial_RED: 1.0
initial_GREEN: 1.0
initial_BLUE: 1.0
```

## Adding a custom user LED to the RatOS LED control

Configure a LED according to the klipper documentation and then override this macro in your printer.cfg file.

```
[gcode_macro _USER_LED_SET]
gcode:
	# parameter
	{% set toolhead = params.TOOLHEAD|default(-1)|int %}
	{% set r = params.R|default(0)|float %}
	{% set g = params.G|default(0)|float %}
	{% set b = params.B|default(0)|float %}

	# replace MY_LED_NAME with the name you choosed for the custom LED
	SET_LED LED="MY_LED_NAME" RED={r} GREEN={g} BLUE={b} SYNC=0 
```
