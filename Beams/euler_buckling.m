function [ P_cr ] = euler_buckling( E, I, L, constraint_type )
%% euler_buckling: Returns the critical buckling force for a straight, axially loaded beam using the Euler formula
%% Citations  
% [1] J. Collins, H. Busby and G. Staab, Mechanical design of machine elements and machines, 2nd ed. Hoboken: John Wiley & Sons, 2010.
% Chapter 8.8. Pages 631-643
%% INPUTS:
%  E -- Young's Modulus [Pa or psi]
%  I -- Area moment of inertia [m^4 or in^4]
%  L -- Beam lenght [m or in]
%  constraint_type -- 0 = both ends pinned, 1 = one end-pinned one end
%                     fixed, 2 = one end fixed one end free, 3 = both ends
%                     fixed (See Fig. 2.7 of [1])
%% OUTPUTS:
% P_cr: Critical axial force for buckling
%% Revision History:
% 5/3/19: File Created -- Garrison Johnston
%% Get effective length (See Table 2.1 of [1])
if constraint_type == 0
    Le = L;
elseif constraint_type == 1
    Le = 0.7*L;
elseif constraint_type == 2
    Le = 2*L;
elseif constraint_type == 3
    Le = 0.5*L;
else
    disp('Please specify a constraint type 0-3')
end
%% Find critical buckling force -- Euler equation (see Eq. 2-36 of [1]) 
P_cr = pi^2*E*I/(Le^2);

end

