# Design_Calculations_Library
This repository provides a library of MATLAB functions used to calculate design metrics for various common mechanical components. The inputs of each function are described in the code comments

ARMA Lab Members: http://arma.vuse.vanderbilt.edu/mediawiki/Design_Calculations_Library

## Bearings
* ```ball_bearing_fatigue.m```: Calculates the fatigue life of a ball bearing in number of cycles
* ```crossed_bearing_fatigue.m```: Calculates the axial, moment, and static equivalent FOSs for a crossed roller bearing. It also calculates the fatigue life in number of cycles.
* ```roller_bearing_fatigue.m```: Calculates the fatigue life of a roller bearing in number of cycles
## Gears
* ```gear_design_check.m```: Prints in terminal if a pair of 20 degree pressure angle gears pass the following design checks...
  * Matching modules for metric gears or matching circular pitches for inch gears
  * Gear ratio is not a whole number
  * Maximum number of gear teeth
  * Minimum Number of pinion teeth
  * Contact ratio is greater than 1.4
  * Pinion tooth bending stress FOS using the lewis form factor
  * Gear tooth bending stress FOS using the lewis form factor
  * Pinion tooth bending stress FOS using the AGMA equations
  * Gear tooth bending stress FOS using the AGMA equations
  * Calculates the bending fatigue life adjustment factors, YN
  * Calculates the surface fatigue life adjustment factors, ZN
  * Calculates the radial and tangental forces on the gear pair
* ```Gear_design_check_example.m```: Shows an example call of ```gear_design_check.m``` for a pair of McMaster gears that fail the design check
* ```Lewis_form_factor20deg_splinefit.mat```: MATLAB splinefit that is used to calculate the Lewis form factor in ``` gear_design_check.m ```
## Keys
* ```Woodruff_key_recommendation_inch.m```: Calculates a recommended inch woodruff key for a shaft of specified diameter in inches
* ```key_stresses.m```: Calculates the average shear stress, compressive bearing stress, first principle stress, and FOS for the key.
* ```Square_key_recommendation_inch.m```: Calculates a recommended square key/setscrew combo for a given shaft size. This script only sizes the side width of the key, the length can be designed to meet strength requirements.
# Disclaimer
Although these equations are intended to be correct, final designs should not rely on these scripts for critical design calculations.   
