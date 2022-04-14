function k = spring_rate(d, D, G, N)
%% spring_rate: calculates the rate of a spring
%% INPUTS:
% d: wire diameter [m]
% D: Coil outer diameter [m]
% G: Shear modulus [Pa]
% N: Number of coils 
%% OUTPUTS:
% k: spring rate [N/m]
%% Find the spring's mean coil diameter. (See sec. 10-1 in shigley's)
D_c = D - d;

%% Spring index 
c = D_c/d;

%% Spring rate
k = d^4*G/(8*D_c^3*N)*(1+1/(2*c^2))^-1;

end

