%% This scripts demomstrates an example call of the min_shaft_diameter and fatigue strength functions
% Uses Misumi drive shaft: SSFHKRRA15-95-F20-S32-KA0-A20-KB25-B20 as an
% example. 
% Material: 1045 Carbon Steel. S_u = 565 MPa [2]
%% Citations  
% [1] J. Collins, H. Busby and G. Staab, Mechanical design of machine elements and machines, 2nd ed. Hoboken: John Wiley & Sons, 2010.
% [2] Material data from https://www.azom.com/article.aspx?ArticleID=6130
%% Revision History:
% 1/10/19: File Created -- Garrison Johnston
%% Unadjusted Fatigue Strength
S_u = 565*10^6; % [Pa] Ultimate strength [2]
S_prime_f = 0.4*S_u; % [Pa] unadjusted fatigue strength. See page 248 of [1].
%% Knockdown factors ([] = use default value);
k_gr = [];   % Grain size and direction factor
k_we = 1.0;  % Welding factor. No welding anticipated.
k_f = 1.0; % Geometrical discontinuity factor. Reciprocal of K_f from Table 8.3 of [1]
k_sr = [];   % Surface condition factor.
k_sz = [];   % Size effect factor
k_rs = [];   % Residual surface stress factor
k_fr = [];   % Fretting factor
k_cr = [];   % Corrosion Factor
k_sp = [];   % Operational speed factor
k_r = [];    % Reliability factor.
%% Fatigue Strength
S_f = fatigue_strength(S_prime_f, k_gr, k_we, k_f, k_sr, k_sz, k_rs, k_fr, k_cr, k_sp, k_r);
%% Factors for the minimum shaft diameter function
S_N = S_f;  % For infinite life
n_d = 3.0;  % Desired safety factor
K_fb = 1.6; % Bending fatigue stress concentration factor for unhardened steel profile keys. Table 8.3 on page 369 of [1].
K_ft = 1.3; % Torsion fatigue stress concentration factor for unhardened steel profile keys. Table 8.3 on page 369 of [1].
M_a = 9.42; % Alternating bending moment [Nm]
M_m = 6.42; % Mean bending moment [Nm]
T_a = 44.7; % Alternating torsional moment [Nm]
T_m = 29.63;% Mean torsional moment [Nm]
%% Minimum Recommended Shaft Diameter
d = min_shaft_diameter(S_u, n_d, S_N, K_fb, M_a, K_ft, T_a, M_m, T_m)
