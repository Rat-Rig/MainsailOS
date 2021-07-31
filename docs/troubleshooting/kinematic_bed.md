# 3D Printer Klipper Troubleshooting guide

## Motors
### Kinematic Bed does not finish leveling successfully
This issue often shows up as bed being more out of alignment each iteration and sometimes does throw an error after few iterations.

If you are getting this error, this section should help you:

```
!! Retries aborting: Probed points range is increasing.
!! Retries aborting: Probed points range is increasing.
```

There are two most common mistakes that cause this behavior:
 - one of the motors cable detached
 - mixed cables of the motors
 
In order to verify expected order of the drives look for `z_tilt` section in
your printer.cfg.
```
[z_tilt]
points:
	60,60
	235,370
	360,60
```

These points designate where the probing will occur and should correspond to
nearest stepper. In this case motors should left bottom of the buildplate,
top middle of the buildplate, and right bottom of the buildplate.

You can use [STEPPER_BUZZ](https://github.com/KevinOConnor/klipper/blob/master/docs/Config_checks.md#verify-stepper-motors) command:
```
STEPPER_BUZZ STEPPER=stepper_z
STEPPER_BUZZ STEPPER=stepper_z1
STEPPER_BUZZ STEPPER=stepper_z2
```

Upon execution, motor in question should go first up and then down.

Stepper names should correspond to their names in the printer.cfg.