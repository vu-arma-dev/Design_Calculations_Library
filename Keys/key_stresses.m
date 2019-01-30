function [ shear_stress, compressive_stress, FOS_shear, FOS_compressive ] = key_stresses( shaft_diameter, torque, width, height, length, yield_stress, theory )
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
% theory: Gives the option of using 'vonMises' or 'tresca' to
%         determine the max allowable shear stress. Defaults to 'tresca'.
%% OUTPUTS
% shear_stress: average shear stress in the key [pa or psi]
% compressive_stress: compressive bearing stress in the key [pa or psi]
% FOS_shear: Factor of safety against shear stress using 'vonMises' or 
%            'tresca' failure theory.
% FOS_compressive: Factor of safety against compressive stress
%% Assumptions:
% bearing stress from forces on the top and bottom of the key is zero
%% Revision History:
% 10/16/2018: File Created -- Garrison Johnston 
% 1/30/2019: Now calculates shear FOS and compressive stress FOS --
%            Garrison Johnston
%% Set default value of theory to tresca
if nargin < 7
    theory = 'tresca';
end
%% Average Shear stress
As = width*length; % Area of the shearing plane
shear_stress = F/As;
%% Shear stress FOS
if strcmp('tresca',theory)
    shear_yield = yield_stress/2;
elseif strcmp('vonMises',theory)
    shear_yield = yield_stress/sqrt(3);
end
FOS_shear = shear_yield/shear_stress;
%% Compressive force
F = torque/(shaft_diameter/2); % Compressive force in the key
%% Compressive bearing stress
Acomp = height*length; % Area of the bearing stress contact plane
compressive_stress = F/Acomp;
%% Factor of safety
FOS_compressive = yield_stress/compressive_sress;
end
    
