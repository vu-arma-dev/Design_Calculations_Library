function x_max = spring_max_deflection(d, D, G, N, n_s, sigma_y)
%% spring_rate: calculates the rate of a spring
%% INPUTS:
% d: wire diameter [m]
% D: Coil ceneter diameter [m]
% G: Shear modulus [Pa]
% N: Number of coils 
% n_s: safety factor
% sigma_y: yield stress [Pa]
%% OUTPUTS:
% x_max: spring max deflection [m]
%% Find the spring's mean coil diameter. (See sec. 10-1 in shigley's) 
D_c = D - d;

%% Bergstrasser factor
c = D_c/d; % Spring index 
k_B = (4*c+2)/(4*c-3);

%% max allowable force
f_max = pi*d^3*sigma_y/(16*n_s*k_B*D_c);

%% Max deflection
x_max = 8*f_max*D_c^3*N/(d^4*G)*(1+1/(2*c^2));

end