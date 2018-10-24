%% Gear_design_check_example
%{
This script gives an example call of the gear_design_check function for 
two McMaster gears 7880K38 and 7880K44. You will see that the gears do not
meet a design rules check because the pinion bending stress FOS is <1.
%}
%% Garrison Johnston 7/25/2018

%% 7880K38 specs (pinion)
N_7880K38 = 15;    % Number of teeth
d_7880K38 = 0.625; % Pitch Diameter [in]
F_7880K38 = 0.25;  % Face width [in]
ys_7880K38 = 19580;  % Yeild Stress [psi] 
E_7880K38 = 3*10^7; % modulus of elasticity [psi]
v_7880K38 = 0.29; % poisson's ratio
BHN_7880K38 = 450; % Brinell Hardness

%% 7880K44 Specs (gear)
N_7880K44 = 36;    % Number of teeth
d_7880K44 = 1.5; % Pitch Diameter [in]
F_7880K44 = 0.25;  % Face width [in]
ys_7880K44 = 19580;  % Yeild Stress [psi]
E_7880K44 = 3*10^7; % modulus of elasticity [psi]
v_7880K44 = 0.29; % poisson's ratio
BHN_7880K44 = 450; % Brinell Hardness

%% Knockdown Factors for AGMA bending stress
knockdown_factors.Jp = 0.34; %pinion geometry factor
knockdown_factors.Jg = 0.3850; %gear geometry factor
knockdown_factors.Ka = 1.5; %application factor
knockdown_factors.Kv = 1.0; %dynamic factor
knockdown_factors.Km = 1.6; %mounting factor
knockdown_factors.Ki = 1.42; %idler factor
knockdown_factors.Rg = 1.13; %reliability form factor

%% Torque in Pinion 
T_max = 20; % [lbf-in]

%% Run Design Rules Check
gear_design_check('in', N_7880K38, N_7880K44, d_7880K38, d_7880K44, F_7880K38,F_7880K44, ys_7880K38, ys_7880K44, E_7880K38, E_7880K44, v_7880K38, v_7880K44, BHN_7880K38, BHN_7880K44, T_max, knockdown_factors);

%% Notes: 
% Brass Data From: http://elginfasteners.com/resources/materials/material-specifications/brass-material/
