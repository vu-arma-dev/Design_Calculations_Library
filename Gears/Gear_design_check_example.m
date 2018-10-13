%% Gear_design_check_example
%{
This script gives an example call of the gear_design_check function for 
two McMaster gears 7880K38 and 7880K44. You will see that the gears do not
meet a design rules check because the pinion bending stress FOS is <1.
%}
%% Garrison Johnston 7/25/2018
%% 7880K38 specs
N_7880K38 = 15;    % Number of teeth
d_7880K38 = 0.625; % Pitch Diameter [in]
F_7880K38 = 0.25;  % Face width [in]
ys_7880K38 = 135;  % Yeild Stress [MPa] 

%% 7880K44 Specs
N_7880K44 = 36;    % Number of teeth
d_7880K44 = 1.5; % Pitch Diameter [in]
F_7880K44 = 0.25;  % Face width [in]
ys_7880K44 = 135;  % Yeild Stress [MPa]
%% Torque in Pinion 
T_max = 100; % [lbf-in]
%% Run Design Rules Check
gear_design_check('in', N_7880K38, N_7880K44, d_7880K38, d_7880K44, F_7880K38,F_7880K44, ys_7880K38, ys_7880K44, T_max )
%% Notes: 
% Brass Data From: http://elginfasteners.com/resources/materials/material-specifications/brass-material/
