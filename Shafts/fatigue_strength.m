function S_f = fatigue_strength(S_prime_f, k_gr, k_we, k_f, k_sr, k_sz, k_rs, k_fr, k_cr, k_sp, k_r)
%% fatigue_strength: Uses the method described in [1] to calculate the fatigue strength S_f of a shaft given several knockdown factors.
%% Citations  
% [1] J. Collins, H. Busby and G. Staab, Mechanical design of machine elements and machines, 2nd ed. Hoboken: John Wiley & Sons, 2010.
% Equation 5-55 and 5-57. Page 249. Knockdown factors and their deafult values are described in
% Table 5.3
%% INPUTS: INPUT [] if you want to use the default value.
%  S_prime_f -- Unadjusted fatigue strength. Typically 40% of the ultimate
%               strength (S_u) for cast irons and cast steels if S_u <= 88 
%               ksi. Else, S_prime_f = 40 ksi. See page 248 of [1] for 
%               estimates of S_prime_f for other alloys. No default value. 
%  k_gr -- Grain size and direction factor. Typical range 0.4-1.0. Default
%          value 1.0.
%  k_we -- Welding factor. Typical range 0.3-0.9. Default value 0.8. Use 
%          1.0 if no welding is anticipated.
%  k_f --  Geometrical discontinuity factor. Typical range 0.2-1.0. Default
%          value 1.0. Reciprocal of K_f. See Table 8.3 for fatigue stress 
%          concentration factors for keyways. Otherwise K_f = q(Kt-1)+1. 
%          Where q is the knotch sensitivity index and can be found from 
%          Fig. 5.46 of [1] and Kt is the stress concentration factor which
%          can be found in Figs. 5.4-5.12 of [1] for various geometeries. 
%          Use 1.0 for shafts with no discontinuities.  
%  k_sr -- Surface condition factor. Typical range 0.2-0.9. Default value
%          0.7.
%  k_sz -- Size effect factor. Typical range 0.5-1.0. Default value 0.9. 
%  k_rs -- Residual surface stress factor. Typical range 0.5-2.5. Default 
%          value 1.0. 
%  k_fr -- Fretting factor. Use 0.35 if fretting is anticipated and 1.0 
%          otherwise. Default value 1.0.
%  k_cr -- Corrosion factor. Typical range 0.1-1.0. Default value 1.0.
%  k_sp -- Operational speed factor. Typical range 0.9-1.2. Default value 
%          1.0.
%  k_r --  Reliability factor. Default value 90% reliability --> k_r = 0.9
%          From Table 5.4 of [1]
%          Reliability | k_r
%          -----------------
%          90%         | 0.9
%          95%         | 0.87
%          99%         | 0.81
%          99.9%       | 0.75
%          99.995%     | 0.69 
%% OUTPUTS:
% S_f: Fatigue strength
%% Revision History:
% 1/10/19: File Created -- Garrison Johnston
%% k_gr
if isempty(k_gr)
    k_gr = 1.0; % Set default value
end
%% k_we
if isempty(k_we)
    k_we = 0.8; % Set default value
end
%% k_f
if isempty(k_f)
    k_f = 1.0; % Set default value
end
%% k_sr
if isempty(k_sr)
    k_sr = 0.7; % Set default value
end
%% k_sz
if isempty(k_sz)
    k_sz = 0.9; % Set default value
end

%% k_rs
if isempty(k_rs)
    k_rs = 1.0; % Set default value
end

%% k_fr
if isempty(k_fr)
    k_fr = 1.0; % Set default value
end
%% k_cr
if isempty(k_cr)
    k_cr = 1.0; % Set default value
end

%% k_sp
if isempty(k_sp)
    k_sp = 1.0; % Set default value
end

%% k_r
if isempty(k_r)
    k_r = 0.9; % Set default value
end
%% k_inf (Eq. 5-57 of [1])
k_inf = k_gr*k_we*k_f*k_sr*k_sz*k_rs*k_fr*k_cr*k_sp*k_r;
%% S_f (Eq. 5-55 of [1])
S_f = k_inf*S_prime_f;
end