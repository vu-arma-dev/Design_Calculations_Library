function [ shear_stress, compressive_stress, principle_stress_1, FOS ] = key_stresses( shaft_diameter, torque, width, height, length, yield_stress )
%% KEY_STRESSES: this function calculates the stesses and factor of safety in a key 
%% [1] J. Collins, H. Busby and G. Staab, Mechanical design of machine elements and machines, 2nd ed. Hoboken: John Wiley & Sons, 2010.
% Chapter 8.8. Pages 367-368
%% INPUTS
% shaft_diameter: Diameter of the drive shaft [m or in]
% torque: torque on the drive shaft [Nm or lbf-in]
% width: width of the key [m or in]
% height: heigth of the key [m or in]
% length: length of the key [m or in]
% yeild_stress: yeild stress of the key material [Pa or psi]
%% OUTPUTS
% shear_stress: average shear stress in the key [pa or psi]
% compressive_stress: compressive bearing stress in the key [pa or psi]
% principle_stress_1: first principle stress in the key [pa or psi]
% FOS: Factor of safety against the first principle stress
%% Assumptions:
% bearing stress from forces on the top and bottom of the key is zero
%% Garrison Johnston 10/16/2018
%% Compressive force
F = torque/(shaft_diameter/2); % Compressive force in the key
%% Average Shear stress
As = width*length; % Area of the shearing plane
shear_stress = F/As;
%% Compressive bearign stress
Acomp = height*length; % Area of the bearing stress contact plane
compressive_stress = F/Acomp;
%% First Principle Stress
% sigma1 = (Mohr's circle center) + (Mohr's circle radius) 
principle_stress_1 = compressive_stress/2+sqrt((compressive_stress/2)^2+shear_stress^2);
%% Factor of safety
FOS = yield_stress/principle_stress_1;
end

