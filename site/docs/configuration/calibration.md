# RatOS 2.1 Calibration Macros

- [PID_CALIBRATE_HOTEND](#pid_calibrate_hotend)
- [PID_CALIBRATE_BED](#pid_calibrate_bed)
- [INITIALIZE_PA_TUNING](#initialize_pa_tuning)
- [MEASURE_COREXY_BELT_TENSION](#measure_corexy_belt_tension)
- [GENERATE_SHAPER_GRAPHS](#generate_shaper_graphs)


## PID calibration macros

PID (Proportional-Integral-Derivative) calibration for 3D printer hotends and beds is a crucial process that ensures stable and accurate temperature control. PID tuning minimizes temperature fluctuations in the hot end and the bed heater of your 3D printer. Unlike the less precise Bang-Bang method, PID calibration maintains a constant temperature, resulting in better print quality. 

Remember to run PID tuning when you get a new printer, change the hot end, or make modifications. It ensures consistent and reliable printing!

At the completion of the PID calibration run `SAVE_CONFIG` to update the printer.cfg file with the new PID settings.

### PID_CALIBRATE_HOTEND
- **Parameters** `[TEMP|TOOLHEAD]`

	`TEMP` = The target calibration temperature for the hotend. Default value is 220°C.

	`TOOLHEAD` = Only needed for IDEX printer. 0 = Left toolhead, 1 = right Toolhead. Default value is -1.

### PID_CALIBRATE_BED
- **Parameters** `[TEMP]`

	`TEMP` = The target calibration temperature for the bed heater. Default value is 80°C.


## Pressure advance tuning macro

Pressure advance tuning (also known as PA or Linear Advance) is a critical process for achieving better print quality in 3D printing. During accelerations and decelerations, the extruder experiences lag, causing over-extrusion at the start of a line and under-extrusion at the end. Pressure advance adjusts the extruder speed to maintain consistent pressure in the nozzle, resulting in more accurate extrusion.

Remember, pressure advance helps maintain consistent extrusion, especially during rapid movements! 

RatOS comes with a simple way to get high precise 3 digits PA values for your filament profiles.

### INITIALIZE_PA_TUNING
- **Parameters** `[START|FACTOR]`

	`START` = The PA start value for this calibration. Default is 0.0.

	`FACTOR` = The PA value change per millimeter.  Default is 0.001.

	**How to use it.**
	- Place a 50x50mm square on your buildplate and make it 100mm height.
	- Use 2 or 3 perimeters and little infill.
	- Print with your target printing profile, do not change anything.
	- After it starts to print the first layer run the `INITIALIZE_PA_TUNING` macro with its default values.
	- Measure with a caliper form the bottom of the print to the best corner quality of the print.
	- if the value is 45.5mm then yor new PA value is 0.0455.


## Vibration analysis macros

Vibration analysis in the context of 3D printers involves studying the vibrations generated during printing. It helps to understand the state of the 3D printer during printing. Vibration monitoring enhances 3D printing quality and helps maintain reliable operation! 

At the completion of the vibration analysis you'll find the graphs in the input_shaper folder in the machine tab in the frontend.

### MEASURE_COREXY_BELT_TENSION
- **Parameters** `[TOOLHEAD|FREQUENCY_START|FREQUENCY_END|HZ_PER_SEC]`

	`TOOLHEAD` = Only needed for IDEX printer. 0 = Left toolhead, 1 = right Toolhead. By default it uses both toolheads.

	`FREQUENCY_START` = The start frequency for the test. Default value is 10HZ.

	`FREQUENCY_END` = The end frequency for the test. Default value is 133HZ.

	`HZ_PER_SEC` = HZ per second to test. A value between 0.1HZ and 2.0HZ per second is allowed. Default is 1.0HZ.

### GENERATE_SHAPER_GRAPHS
- **Parameters** `[TOOLHEAD|AXIS|FREQUENCY_START|FREQUENCY_END|HZ_PER_SEC]`

	`TOOLHEAD` = Only needed for IDEX printer. 0 = Left toolhead, 1 = right Toolhead. By default it uses both toolheads.

	`AXIS` = The printer axis for the test. X or Y. By default both axis will be used.

	`FREQUENCY_START` = The start frequency for the test. Default value is 10HZ.

	`FREQUENCY_END` = The end frequency for the test. Default value is 133HZ.

	`HZ_PER_SEC` = HZ per second to test. A value between 0.1HZ and 2.0HZ per second is allowed. Default is 1.0HZ.

	On a IDEX printer you can run this test in COPY and MIRROR mode as well. 
