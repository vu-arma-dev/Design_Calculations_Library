%% Gear_design_check_example
%{
This script gives an example call of the gear_design_check function for 
two McMaster gears 7880K38 and 7880K44.
%}
%% Garrison Johnston 10/25/2018
%% 7880K38 specs (pinion)
N_7880K38 = 15;    % Number of teeth
d_7880K38 = 0.625; % Pitch Diameter [in]
F_7880K38 = 0.25;  % Face width [in]
ys_7880K38 = 36984.6;  % Yeild Stress [psi] 
E_7880K38 = 1.537e7; % modulus of elasticity [psi]
v_7880K38 = 0.318; % poisson's ratio
BHN_7880K38 = 65.1; % Brinell Hardness

%% 7880K44 Specs (gear)
N_7880K44 = 36;    % Number of teeth
d_7880K44 = 1.5; % Pitch Diameter [in]
F_7880K44 = 0.25;  % Face width [in]
ys_7880K44 = 36984.6;  % Yeild Stress [psi]
E_7880K44 = 1.537e7; % modulus of elasticity [psi]
v_7880K44 = 0.318; % poisson's ratio
BHN_7880K44 = 65.1; % Brinell Hardness

%% Knockdown Factors for AGMA bending stress
knockdown_factors.Jp = 0.34; %pinion geometry factor
knockdown_factors.Jg = 0.3850; %gear geometry factor
knockdown_factors.Ka = 1.5; %application factor
knockdown_factors.Kv = 1.0; %dynamic factor
knockdown_factors.Km = 1.6; %mounting factor
knockdown_factors.Ki = 1.42; %idler factor
knockdown_factors.Rg = 1.18; % reliability factor (90%)

%% Torque in Pinion 
T_max = 10; % [lbf-in]

%% Run Design Rules Check
gear_design_check('in', N_7880K38, N_7880K44, d_7880K38, d_7880K44, F_7880K38,F_7880K44, ys_7880K38, ys_7880K44, E_7880K38, E_7880K44, v_7880K38, v_7880K44, BHN_7880K38, BHN_7880K44, T_max, knockdown_factors);

%% Notes: 
% Brass Data From: http://www.matweb.com/search/datasheet_print.aspx?matguid=d3bd4617903543ada92f4c101c2a20e5
