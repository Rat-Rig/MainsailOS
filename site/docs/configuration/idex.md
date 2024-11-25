# RatOS 2.1 IDEX Macros

- [IDEX_SINGLE]()
- [IDEX_COPY]()
- [IDEX_MIRROR]()
- [IDEX_PARK]()
- [JOIN_SPOOLS]()
- [REMAP_TOOLHEADS]()


## IDEX printing modes

Independent Dual Extrusion (IDEX) 3D printers offer versatile printing modes that enhance productivity and flexibility.

### IDEX_SINGLE

- Single toolhead mode for single, multicolor and multimaterial prints.

	This is the default printing mode.	

### IDEX_COPY

- Prints two identical models simultaneously.

	Run this macro before starting a print to enable the COPY mode. After the print ends the printer returns to single toolhead mode.

### IDEX_MIRROR

- Mirrors your model and prints both the original and its mirror image in one go.

	Run this macro before starting a print to enable the MIRROR mode.  After the print ends the printer returns to single toolhead mode.

### IDEX_PARK

- Moves the current active toolhead to its parking position.

	Only available in single toolhead mode and if printer is not printing.

## IDEX extras

RatOS comes with a built in join spool and toolhead remapping feature.

### JOIN_SPOOLS
- **Parameters** `[SPOOLS]`

    The spool join feature can switch to another filament spool once a runout has been detected. This works only if you have a RatOS runout sensor configured according to the [official RatOS filament sensor documentation](filament_sensors.md). 

	`SPOOLS` = Eg. `0,1` or `1,0`, both settings do the same actually. If one of the spools runs out it switches fully automated to the other and resumes the print.

	To deactivate the feature click the `JOIN_SPOOLS` macro button without any parameter.
	

### REMAP_TOOLHEADS
- **Parameters** `[TOOLHEADS]`

	The toolhead remapping feature lets you swap the toolhead assignemnt.

	`TOOLHEADS` = Eg. `0,1` or `1,0`, both settings do the same actually. Swaps the slicer toolhead assignment.

	- Reprint a already sliced multicolor file with swapped toolheads
	- Reprint a already sliced single toolhead print with the other toolhead

	To deactivate the feature click the `REMAP_TOOLHEADS` macro button without any parameter.
