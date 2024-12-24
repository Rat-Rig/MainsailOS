# Beacon Contact

- [Prerequisites](#prerequisites)
- [Fully automated RatOS Beacon calibration](#fully-automated-ratos-beacon-calibration)
- [Initial calibration](#1-initial-calibration)
- [Beacon latency check](#2-beacon-latency-check)
- [Temperature expansion calibration](#3-temperature-expansion-calibration)
- [Final calibration](#4-final-calibration)
- [Beacon Scan Compensation](#5-beta-automated-beacon-scan-compensation)
- [First print and fine tuning](#6-first-print-and-fine-tuning)
- [RatOS configuration](#7-ratos-configuration)
- [Beacon Tools](#8-tools)
- [FAQ](#9-faq)

## Prerequisites

Please read the official [beacon contact documentation](https://docs.beacon3d.com/contact/), but do not follow any installation instructions. Beacon is already installed and configured in RatOS, you just need to connect it to your Raspberry Pi.

## NEW! Bed and hotend heat soaking time

It is recommended to use the new RatOS heat soaking variables. The Beacon calibration and the `START_PRINT` macro are using these values.

```
[gcode_macro RatOS]
variable_bed_heat_soak_time: 1200
variable_hotend_heat_soak_time: 300
variable_start_print_park_in: 'primeblob'
```

## Fully automated RatOS Beacon calibration

RatOS comes with a fully automated Beacon model and temperature offset calibration.

By default the Beacon contact feature is enabled. If you want to disable it, set `variable_beacon_contact_start_print_true_zero` to False.

1. Run `BEACON_RATOS_CALIBRATE BED_TEMP=85 CHAMBER_TEMP=45`. Use your target temperature for the `BED_TEMP` and `CHAMBER_TEMP` parameter. `CHAMBER_TEMP` is optional, and can be omitted.

The automated beacon calibration will run the following calibrations and tests, which can also be used individually. Please make sure to read every section before starting the calibration.

- [Initial calibration](#1-initial-calibration)
- [Beacon latency check](#2-beacon-latency-check)
- [Temperature expansion calibration](#3-temperature-expansion-calibration) (for non IDEX printer)
- [Final calibration](#4-final-calibration)
- [Beacon scan compensation](#5-beta-automated-beacon-scan-compensation) _if [beacon_scan_compensation_enable: True](#7-ratos-configuration) a reference mesh will be created if needed_

All calibration results will be saved automatically, and no user action is required. Klipper will restart on its own after the calibration is complete.

## 1. Initial calibration

We need to create an initial Beacon model to be able to home the printer.

1. Run `BEACON_INITIAL_CALIBRATION`

It will home your printer and run the calibration fully automated. This command can throw a tolerance error - in this case, simply repeat it until the command completes successfully.

For safety and peace of mind, the LED will turn on as soon as the contact system determines it has a strong enough signal for detection. It should normally turn on up to 10mm in advance of the metal target, allowing enough time to manually e-stop the machine if necessary.

2. Run `SAVE_CONFIG` to save the model to your printer.cfg file.

## 2. Beacon latency check

This test will show you the quality of your Beacon probing.

- Run `BEACON_POKE_TEST`

It will home your printer and poke the bed multiple times. After the test completes, check the console output - it should look similar to this:

```
Overshoot: 35.625 um
Triggered at: z=0.07369 with latency=2
Armed at: z=4.76021
Poke test from 5.000 to -0.300, at 3.000 mm/s
```

Compare your latency values with the following list.

| Score | Notes                                                                   |
| ----- | ----------------------------------------------------------------------- |
| 0-1   | Extremely low noise, rarely achieved                                    |
| 2-4   | Excellent performance for a typical printer                             |
| 5-8   | Acceptable performance, machine may have considerable cyclic axis noise |
| 9-11  | Not ideal, may want to verify proper mounting or use thinner stackups   |
| 12-14 | Reason for concern, present setup may be risky to continue with         |

## 3. Temperature expansion calibration

RatOS comes with built-in temperature expansion calibration and compensation.

**Preparation**

- Unload filament from the nozzle
- Make sure the nozzle is clean and that no filament is leaking out of it. Make a manual cold pull or use the RatOS `COLD_PULL` macro
- Let the machine cool down to ambient temperature
- Do **NOT** perform this calibration on a smooth PEI sheet - in this case, turn the sheet around and calibrate on its bare metal surface

**Cold Pull Macro**

The cold pull macro lets you perform an automated cold pull to clean your nozzle. Before the cold pull, 30mm of filament will be extruded at the specified `EXTRUSION_TEMP`.

The default values work well for PLA cold pulls. For PETG and ABS, you should use higher temperatures like `EXTRUSION_TEMP=250 COLD_PULL_TEMP=95`. If you hear skipping during the cold pull, slightly increase the `COLD_PULL_TEMP`.

```
COLD_PULL EXTRUSION_TEMP=220 COLD_PULL_TEMP=80 TOOLHEAD=0
```

**Single toolhead printer**

- Run `BEACON_CALIBRATE_NOZZLE_TEMP_OFFSET`

This command will home your printer and run the calibration automatically. The process will take some time to complete.

**IDEX printer**

- Start VAOC
- Center both nozzles over the camera
- Click the `Calibrate Thermal Expansion` button in VAOC

This will automatically calibrate both nozzles. The process will take some time to complete.

It is recommended to repeat this calibration whenever you change a nozzle or before loading new filament.

After the test finishes, check the console output. A typical result looks like this:

```
RatOS | Beacon: T0 expansion coefficient: 0.075000
```

This value is in millimeters and represents the thermal expansion for a temperature difference of 100°C. RatOS uses this value to automatically calculate and apply the needed offset.

The result is automatically saved to the configuration file - no user action is required.

## 4. Final Calibration

For scan method Z-homing, we should create a Beacon model under real operating conditions. While optional, this step is recommended.

- Run `BEACON_FINAL_CALIBRATION BED_TEMP=85 CHAMBER_TEMP=45`

Use your target temperatures for the `BED_TEMP` and `CHAMBER_TEMP` parameters. This command will home your printer and run the calibration automatically.

- Run `SAVE_CONFIG` to save the model to `printer.cfg`.

## 5. BETA! Automated Beacon Scan Compensation

With RatOS, you can automatically compensate for gantry twist across the entire build plate and inaccuracies in the build sheet's material thickness that cause ripple effects on scanned bed meshes.

### How do I know if I need this?

#### Measuring Gantry Twist

- `BEACON_MEASURE_GANTRY_TWIST` automatically measures the gantry twist at multiple locations on the bed. It will home your printer and level the bed if needed. The results will be displayed after the test has finished. The command may throw a tolerance error - in this case, simply repeat it until successful.

The result will look like the following example:

```
Gantry twist relative to the center

Low gantry twist: 50.324232μm.
You may experience first layer inconsistensies, consider beacon scan compensation.

Front left: 2.362576μm
Front center: 16.475233μm
Front right: -47.959155μm
Left center: 24.925954μm
Right center: -22.468182μm
Back left: 50.324232μm
Back center: 37.143389μm
Back right: -4.167238μm
```

Check your build plate:

- Create a scan bed mesh and save it as `Scan1`
- Rotate the build plate 90 degrees (rotate only the sheet, not the bed itself)
- Create a second scan bed mesh and save it as `Scan2`
- If you observe that the mesh pattern follows the build plate when rotated, you need this compensation

Scan 1

![Scan 1: 0 degrees rotation](_media/0degree.png)

Scan 2 with the build plate rotated by 90°

![Scan 2: 90 degrees rotation](_media/90degree.png)

Since this feature is still in beta, you need to activate it manually by copying the following configuration to `printer.cfg`:

```
[gcode_macro RatOS]
variable_beacon_scan_compensation_enable: True          # Enables the beacon scan compensation
```

1. Run `BEACON_CREATE_SCAN_COMPENSATION_MESH BED_TEMP=85 CHAMBER_TEMP=45 PROFILE=Contact` to create a contact reference bed mesh.

Use your target temperatures for the `BED_TEMP` and `CHAMBER_TEMP` parameters. The command will home your printer, heat it to the target temperatures, wait for heat soaking, and run the calibration automatically.

2. You'll need a reference contact mesh for each build plate and each time your target bed temperature changes more than 10 or 20 degrees (TBD).

For example, if I primarily print ABS at 110°C and PETG at 80°C both on the same powder-coated sheet, I would need two contact meshes - one for 80°C and one for 110°C. If I print at 90°C and 110°C, I might be able to use a single contact mesh at 100°C. You can create separate compensation meshes by running the `BEACON_CREATE_SCAN_COMPENSATION_MESH` command with the `PROFILE` parameter. For example: `BEACON_CREATE_SCAN_COMPENSATION_MESH PROFILE="PEI_PC_90"`

3. Set the profile name for the desired reference mesh profile in the gcode variable `beacon_scan_compensation_profile`. The default profile name is `Contact`.

- If `BEACON_CREATE_SCAN_COMPENSATION_MESH` throws an error while meshing, you can simply run `BED_MESH_CALIBRATE PROBE_METHOD=contact USE_CONTACT_AREA=1 SAMPLES=2 SAMPLES_DROP=1 SAMPLES_TOLERANCE_RETRIES=10 PROFILE=Contact`. This will skip the heat soaking part which is no longer needed in this case.

- If the feature is enabled, it will automatically compensate while printing - no additional user action is required. If you want to see the compensation for a manually created mesh, open the mesh in Mainsail and run `BEACON_APPLY_SCAN_COMPENSATION PROFILE=Contact` in the console. This will update the mesh visualization in Mainsail.

Click the image to open the video and see the results in action

[<img src="https://img.youtube.com/vi/qjRhAHsX0Hc/maxresdefault.jpg" width="50%" />](https://youtu.be/qjRhAHsX0Hc)

## 6. First print and fine tuning

1. Print a 150x30mm single layer rectangle in the middle of the build plate.
2. While printing, fine-tune using baby stepping.
3. Run `SAVE_Z_OFFSET` to save the changes. Don't click the button - type `SAVE_Z_OFFSET` into the console.

## 7. RatOS configuration

The Beacon contact feature is activated by default, so no configuration is required. However, you can override the settings to enable additional Beacon contact features if desired. Simply copy and paste the complete configuration block below into your printer.cfg file and modify the settings as needed.

```
#####
# Beacon probe configuration
#####
[gcode_macro RatOS]
variable_beacon_bed_mesh_scv: 25                        # Square corner velocity for bed meshing with proximity method
variable_beacon_contact_z_homing: False                 # Makes all G28 calls use contact instead of proximity scan
variable_beacon_contact_start_print_true_zero: True     # Uses contact to determine true Z=0 for the last homing move during START_PRINT
variable_beacon_contact_wipe_before_true_zero: True     # Enables a nozzle wipe at Y10 before true zeroing
variable_beacon_contact_true_zero_temp: 150             # Nozzle temperature for true zeroing
                                                        # WARNING: If you're using a smooth PEI sheet, be careful with the temperature

variable_beacon_contact_prime_probing: True             # Probes for priming with contact method
variable_beacon_contact_expansion_compensation: True    # Enables the nozzle thermal expansion compensation

variable_beacon_contact_bed_mesh: False                 # Performs bed mesh with contact method
variable_beacon_contact_bed_mesh_samples: 2             # Number of probe samples for contact bed mesh

variable_beacon_contact_z_tilt_adjust: False            # Performs z-tilt adjust with contact method
variable_beacon_contact_z_tilt_adjust_samples: 2        # Number of probe samples for contact z-tilt adjust

variable_beacon_scan_compensation_enable: False         # Enables the Beacon scan compensation
variable_beacon_scan_compensation_profile: "Contact"    # The contact profile name for scan compensation
variable_beacon_scan_compensation_probe_count: 15,15    # The contact probe count for scan compensation

variable_beacon_contact_poke_bottom_limit: -1           # The bottom limit for the contact poke test
variable_beacon_scan_method_automatic: False            # Enables the METHOD=automatic scan option
```

## 8. Tools

### Measuring Z-Axis Backlash

The Beacon macro `BEACON_ESTIMATE_BACKLASH` allows you to measure the backlash in your printer's setup. Before using this macro, ensure your printer is homed and the bed is properly leveled.

```
Median distance moving up 1.99990, down 2.00286, delta 0.00296 over 20 samples
```

The delta value represents your backlash in millimeters.

## 9. FAQ

### Q: How can I set different Z-offsets for different filaments?

A: If you want to have different Z-offsets for different filament profiles, you can use `SET_GCODE_OFFSET Z_ADJUST=+0.01` for positive adjustments or `SET_GCODE_OFFSET Z_ADJUST=-0.01` for negative adjustments in your filament profile's custom G-code section. Note: Using `Z` instead of `Z_ADJUST` will cause Klipper to replace all previously set Z-offset adjustments, including hotend expansion compensation, with your provided value (which is not recommended).
