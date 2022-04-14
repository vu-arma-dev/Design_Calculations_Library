# Design_Calculations_Library
This repository provides a library of MATLAB functions used to calculate design metrics for various common mechanical components. The inputs of each function are described in the code comments. Most codes based off methods recommended in [1].

ARMA Lab Members: http://arma.vuse.vanderbilt.edu/mediawiki/index.php/Design_Calculations_Library
## Beams
* ```euler_bucking.m```: Calculates the critical bucking force for straight, uniform, axially loaded beams using the Euler equation
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
* ```key_stresses.m```: Calculates the average shear stress, compressive bearing stress, and FOS against compression and shear for the key. Gives the option of using Von Mises or Tresca theory to determine maximum allowable shear stress.
* ```Square_key_recommendation_inch.m```: Calculates a recommended square key/setscrew combo for a given shaft size. This script only sizes the side width of the key, the length can be designed to meet strength requirements.
## Shafts
* ```fatigue_strength.m```: Calculates the fatigue strength of a shaft given a series of knockdown factors. Pass [] into the function to use default values as recommended in [1]. Note the corresponding equation in [1] has an error which was fixed in the code. See errata for [1] for more information.
* ```min_shaft_diameter.m```: Calculates the minimum shaft diameter for shafts in bending and torsion given a desired number of cycles and factor of safety.
* ```Shaft_diameter_example.m```: Provides example calls of ```fatigue_strength.m``` and ```min_shaft_diameter.m```.
## Springs
* ```spring_rate.m```: Calculates the rate of a spring in N/m given the spring's outer diameter in meters, wire diameter in meters, Shear modulus in Pa, and number of coils.
* ```spring_max_deflection.m```: Calculates the maximum allowable deflection in a spring given the spring's outer diameter in meters, wire diameter in meters, Shear modulus in Pa, number of coils, desired safety factor against yielding, and yeild stress in Pa.
# References
[1] J. Collins, H. Busby and G. Staab, Mechanical design of machine elements and machines, 2nd ed. Hoboken: John Wiley & Sons, 2010. 
[2] Budynas, R. G., and Nisbett, J. K., 2011. Shigley’s mechanical engineering design, 9 ed. McGraw-Hill Education.
# Disclaimer
Although these equations are intended to be correct, final designs should not rely on these scripts for critical design calculations.   
