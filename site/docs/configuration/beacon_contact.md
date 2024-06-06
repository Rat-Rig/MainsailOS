# RatOS 2.1 with Beacon Contact 

- [Prerequisites](#prerequisites)
- [Initial calibration](#initial-calibration)
- [First test](#first-test)
- [Temperature expansion calibration](#temperature-expansion-calibration)
- [RatOS configuration](#ratos-configuration)
- [First print and fine tuning](#first-print-and-fine-tuning)
- [Final calibration](#final-calibration)
- [Measuring gantry twist](#measuring-gantry-twist)
- [Measuring z-axis backlash](#measuring-z-axis-backlash)

## Prerequisites
- update RatOS 2.1 via mainsail
- read the official [beacon contact documentation](https://docs.beacon3d.com/contact/), but do not follow any installation instructions from there. 

## Initial calibration
We need to create a intial beacon model to be able to home the printer. 
- Run `BEACON_INITIAL_CALIBRATION` 

	It will home your printer and run the calibration fully automated. This command can throw a tolerance error, in this case just repeat it until the command gets successfully completed. 

	For safety and peace of mind, the LED will turn on as soon as the contact system determines it has a strong enough signal for detection. It should normally turn on up to 10mm in advance of the metal target, allowing enough time to manually estop the machine if necessary.

- Run `SAVE_CONFIG` to save the model to your printer.cfg file.

## First test
- Run `BEACON_POKE_TEST`

	It will home your printer and poke the bed multiple times. After it check the console output, it should look like this: 
```
Overshoot: 35.625 um
Triggered at: z=0.07369 with latency=2
Armed at: z=4.76021
Poke test from 5.000 to -0.300, at 3.000 mm/s
```

Compare your latency values with the following list.

| Score	| Notes |
| :------------ |:--------------- |
| 0-1	| Extremely low noise, rarely achieved
| 2-3	| Excellent performance for a typical printer
| 4-6	| Acceptable performance, machine may have considerable cyclic axis noise
| 7-9	| Not ideal, may want to verify proper mounting or use thinner stackups
| 10-11	| Reason for concern, present setup may be risky to continue with

## Temperature expansion calibration
RatOS comes with a built in temperature expansion calibration and compensation.

**Preparation**
- Unload filament from the nozzle
- Make sure the nozzle is clean and that no filament is leaking out of it. Make a cold pull for example.
- Let the machine cool down to ambient temperature
- Do **NOT** make this calibration on a smooth PEI sheet, in this case turn the sheet arround and make the calibration on the bare metall of it. 

**Single toolhead printer**
- Run `BEACON_CALIBRATE_NOZZLE_TEMP_OFFSET`

	It homes your printer and runs the calibration fully automated. This will take some time.

**IDEX printer**
- Start VAOC
- Center both nozzles over the camera
- run `_VAOC_CALIBRATE_TEMP_OFFSET`

	It calibrates both nozzles fully automated. This will take some time.

It is recommended to repeat that process always when you change a nozzle and before loading any new filament into it.

After the test is finished check the console output, it should look like this typical result:
```
RatOS | Beacon: T0 expansion coefficient: 0.075000
```
This value is in mm and represents the thermal expansion for a temperature difference of 100°C. RatOS uses this value to calculate the needed offset and applies it automatically.

The result will be saved automatically to the configuration file, there is no user action required.

## RatOS configuration
The beacon contact feature is activated by default, you dont need to do anything. But you can override the settings to enable more beacon contact features if wanted. 
```
#####
# Beacon probe configuration
#####
[gcode_macro RatOS]
variable_beacon_bed_mesh_scv: 25                         # square corner velocity for bed meshing with proximity method
variable_beacon_contact_z_homing: False                  # printer z-homing with contact method
variable_beacon_contact_z_calibration: True              # contact z-calibration before the print starts
                                                         # after changing this variable please run a recalibration before you use the printer  
                                                         # if you use a smooth PEI sheet turn this feature off
variable_beacon_contact_calibration_location: "center"   # center = center of the build plate
                                                         # front = front center
                                                         # corner = front corner
variable_beacon_contact_calibrate_margin_x: 30           # x-margin if calibrate in front corners
variable_beacon_contact_bed_mesh: False                  # bed mesh with contact method
variable_beacon_contact_bed_mesh_samples: 2              # probe samples for contact bed mesh
variable_beacon_contact_z_tilt_adjust: False             # z-tilt adjust with contact method
variable_beacon_contact_z_tilt_adjust_samples: 2         # probe samples for contact z-tilt adjust
variable_beacon_contact_prime_probing: True              # probe for priming with contact method
variable_beacon_contact_calibration_temp: 150            # nozzle temperature for auto calibration
variable_beacon_contact_expansion_compensation: True     # enables the nozzle thermal expansion compensation
variable_beacon_contact_expansion_multiplier: 1.0        # multiplier for the nozzle thermal expansion compensation
```

## First print and fine tuning
- Print a 50x50mm one layer thick square in the middle of the buildplate. 
- Use the `beacon_contact_expansion_multiplier` variable to fine tune your first layer squish. Higher value means less squish and lower value means more squish. 1.1 = a bit less squish, 0.9 = a bit more squish, ....

## Final calibration
For the scan method z-homing we should create a beacon model under real conditions. This is optional but recommended.
- Run `BEACON_FINAL_CALIBRATION BED_TEMP=85`

	Use your target bed temperature for the `BED_TEMP` parameter. It will home your printer and run the calibration fully automated.
	In case you have a chamber heater it is recommended to heat it up to your target temperature before starting the test.

- Run `SAVE_CONFIG` to save the model to your printer.cfg file.

## Measuring gantry twist
With the RatOS macro `BEACON_MEASURE_GANTRY_TWIST` you can automatically measure your gantry twist on multiple locations on the bed. It will home your printer and level the bed if needed. The result will be displayed after the test has finished. The command can throw a tolerance error, in this case just repeat it until the command gets successfully executed. 

```
Gantry twist:
Front left:    0.015022mm
Front center:  0.013889mm
Front right:   0.007666mm
Left center:   0.000000mm
Right center:  0.009345mm
Back left:    -0.026518mm
Back center:   0.027997mm
Back right:    0.013992mm
```

## Measuring z-axis backlash
With the beacon macro `BEACON_ESTIMATE_BACKLASH` you can measure the backlash of your setup. You need to home your printer and level your bed before using it.

```
Median distance moving up 1.99990, down 2.00286, delta 0.00296 over 20 samples
```

The delta value represents your backlash in mm.