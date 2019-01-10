function d = min_shaft_diameter(S_u, n_d, S_N, K_fb, M_a, K_ft, T_a, M_m, T_m)
%% min_shaft_diameter: Uses the method described in [1] to calculate the minimum recommended shaft diameter to last N cycles with a saftey factor of n_d
%% Citations  
% [1] J. Collins, H. Busby and G. Staab, Mechanical design of machine elements and machines, 2nd ed. Hoboken: John Wiley & Sons, 2010.
% Equation 8-8. Page 347
%% INPUTS:
%  S_u -- Ultimate strength
%  n_d -- Desired safety factor
%  S_N -- Fatigue strength for a design life of N cycles (S_N = S_f for
%         infinite life. See function "fatigue_strength.m" for finding S_f from S_u)  
%  K_fb -- Fatigue stress concentration factor for bending. See Table
%          8.3 for fatigue stress concentration factors for keyways.
%          Otherwise use K_f = q(Kt-1)+1. Where q is the knotch sensitivity
%          index ands can be found from Fig. 5.46 of [1] and Kt is the
%          stress concentration factor which can be found in Figs. 5.4-5.12
%          of [1] for various geometeries.
%  M_a -- Alternating bending moment on the shaft.
%  K_ft -- Fatigue stress concentration factor for torsion. See Table
%          8.3 for fatigue stress concentration factors for keyways.
%          Otherwise, use K_f = q(Kt-1)+1. Where q is the knotch sensitivity
%          index ands can be found from Fig. 5.46 of [1] and Kt is the
%          stress concentration factor which can be found in Figs. 5.4-5.12
%          of [1] for various geometeries.
%  T_a -- Alternating torsional moment on the shaft.
%  M_m -- Mean bending moment on the shaft.
%  T_m -- Mean torsional moment on the shaft.
%% OUTPUTS:
% d: recommended shaft diameter
%% Revision History:
% 1/10/19: File Created -- Garrison Johnston
%% Recommended shaft diameter (Eq. 8-8 of [1])
d = (16/(pi*S_u)*(n_d*S_u/S_N*((2*K_fb*M_a)^2+3*(K_ft*T_a)^2)^(1/2)+((2*M_m)^2+3*T_m^2)^(1/3)))^(1/3);
end