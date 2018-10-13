function [FOSa, FOSm, FOSs, L] = crossed_bearing_fatigue(C, C0, dp, Fa, Fr, M, fw, ft)
%% crossed_bearing_fatigue: This function calculates the fatigue life and various factors of safety for THK Crossed roller bearings.
% These calculation are based on the spec sheet:
% https://www.thkstore.com/media/product_custom_files/3/8/382-3E_CrossRollerRing.pdf.
%% INPUTS:
% C: Basic load rating (from spec sheet) [kN]
% C0: Basic load rating (from spec sheet) [kN]
% dp: Roller pitch circle diameter (from spec sheet) [mm]
% Fa: Axial Force* [N]
% Fr: Radial Force* [N]
% M: Moment* [Nmm]
% fw: Loading factor (from spec sheet)
% ft: Temperature factor (from spec sheet)
% *Loading definitions in spec sheet
%% OUTPUTS:
% FOSa: Static Axial Safety Factor
% FOSm: Static Moment Safety Factor
% FOSs: Static Equivalent Safety Factor
% L: Rated Life [cycles]
%% Garrison Johnston 7/30/2018 
%% Static Axial Safety Factor
Fa0 = C0/0.44; % Static Permissible Moment [kN]
FOSa = (Fa0*10^3)/Fa;
%% Static Moment Safety Factor
M0 = C0*dp/2*10^(-3); % Static Permissible Moment [kNm]
FOSm = (M0*10^6)/M;
%% Static Safety Factor
P0 = Fr+2*M/dp+0.44*Fa; % Static Equivalent Radial Load [N]
FOSs = (C0*10^3)/P0;
%% Dynamic Equivalent Radial Load (Pc)
% Dynamic Radial Factor and Dynamic Axial Factor 
if (Fa/(Fr+2*M/dp)) <= 1.5
    X = 1;
    Y = 0.45;
else
    X = 0.67;
    Y = 0.67;
end
Pc = X*(Fr+2*M/dp)+Y*Fa; % [N]
%% Rated Life (L)
L = ((ft*C*10^3)/(fw*Pc))^(10/3)*10^6;
end