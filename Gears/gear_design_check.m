function gear_design_check(units, Np, Ng, dp, dg, Fp, Fg, ysp, ysg, Ep, Eg, vp, vg, BHNp, BHNg, Tp, kf)
%% gear_design_check: checks if a 20deg pressure gear-pinion pair meets a set of design requirements and calcuates the design life using the American Gear Manufacturers Association Method
%% Citations  
% [1] J. Collins, H. Busby and G. Staab, Mechanical design of machine elements and machines, 2nd ed. Hoboken: John Wiley & Sons, 2010.
% Chapter 8.8. Pages 631-643
% [2] The "Gear Design" page on the ARMA Wiki (http://arma.vuse.vanderbilt.edu/mediawiki/Gear_design)
%% INPUTS:
%  units -- 'met' for metric or 'in' for inch
%  Np -- Number of teeth on pinion
%  Ng -- Number of teeth on gear
%  dp -- pitch diameter on pinion [mm or in]
%  dg -- Pitch diameter on gear [mm or in]
%  Fp -- Pinion face width [mm or in]
%  Fg -- Gear Face Width [mm or in]
%  ysp -- Pinion material yield stress [MPa or psi]
%  ysg -- Gear Material yield stress [MPa or psi]
%  Ep -- pinion modulus of elasticity [Mpa or psi]
%  Eg -- gear moduls of elasticity [MPa or psi]
%  vp -- pinion poisson's ratio
%  vg -- gear poisson's ratio
%  BHNp -- pinion brinell hardness number
%  BHNg -- gear brinell hardness number
%  Tp -- Maximum torque on the pinion [lbf*in or N*m]
%  kf -- struct of knockdown factors: Mechanical Design of Machine Elements and Machines, Collins/Busby/Staab

%% Revision History:
% 7/23/18: File Created -- Garrison Johnston
% 7/26/2018: Fixed incorrect Wt and Ng_max calculation. Added a check if
% the gear ratio is a whole number. -- Garrison Johnston
% 10/15/18: added AGMA calculations -- Andrew Orekhov
% 10/25/2018: added printing for contact stresses and bending life
%             adjustment factor -- Garrison Johnston
%% Setup Directories
addpath(genpath([cd, '\Charts']));
%% Constants
k = 1;    % Geometric Factor for full depth teeth
phi = 20; % Pressure angle [degrees]

%% Calculate gear parameters
C = (dp+dg)/2;           % [mm or in] -- center distance
mp = dp/Np;              % pinion module [mm or in]
mg = dg/Ng;              % gear module [mm or in]
R = Ng/Np;               % Gear ratio
rbp = mp*Np/2*cosd(phi); % [mm or in] -- pinion base circle radius
rbg = mg*Ng/2*cosd(phi); % [mm or in] -- gear base circle radius
rap = mp*(Np+2)/2;       % [mm or in] -- pinion addendum circle radius
rag = mg*(Ng+2)/2;       % [mm or in] -- pinion addendum circle radius
pd = Ng/dg;              % Gear Diametral Pitch
if strcmp(units,'met')
    stress_unit = 'MPa';
else 
    stress_unit = 'psi';
end
%% Check that either 'met' or 'in' was used
if ~(strcmp(units,'met') || strcmp(units,'in'))
    error('''%s'' is not a valid string for units.',units);
end

%% Check if modules match
if strcmp(units, 'met')
    disp('-----------------------')
    disp('| Module Number Check |')
    disp('-----------------------')
    if abs(mg-mp) > 10^-12
        fprintf('[\bFail: The module of the gear (%0.2f) does not equal the module of the pinion (%0.2f). Gears will not mesh.]\b\n', mg, mp)
        return
    else
        fprintf('Pass: The module of the gear (%0.2f) equals the module of the pinion (%0.2f). Gears will mesh.\n', mg, mp)
    end
elseif strcmp(units, 'in')
    disp('------------------------')
    disp('| Circular Pitch Check |')
    disp('------------------------')
    if mg ~= mp
        fprintf('[\bFail: The circular pitch of the gear (%0.3f) does not equal the circular pitch of the pinion (%0.3f). Gears will not mesh.]\b\n', pi*mg, pi*mp)
        return
    else
        fprintf('Pass: The circular pitch of the gear (%0.3f) equals the circular pitch of the pinion (%0.3f). Gears will mesh.\n', pi*mg, pi*mp)
    end
else
    warning('PLEASE ENTER CORRECT UNITS')
    return
end

%% Check if Gear Ratio is a whole number
disp('---------------------------------')
disp('| Gear Ratio whole number check |')
disp('---------------------------------')

if floor(R)==R
    fprintf('[\bFail: The gear ratio (%0.3f) is a whole number]\b\n', R)
else
    fprintf('Pass: The gear ratio (%0.3f) is a not a whole number\n', R)
end

%% Min/Max Number of Teeth
disp('----------------------------------------')
disp('| Minimum Number of Pinion Teeth Check |')
disp('----------------------------------------')

Np_min = 2*k/((1+2*R)*(sind(phi))^2)*(R+sqrt(R^2 +(1+2*R)*sind(phi)^2));
Np_min = ceil(Np_min);
if Np < Np_min
    fprintf('[\bFail: Number of pinion teeth (%d) is below recommended number of teeth (%d)]\b \n', Np, Np_min)
else
    fprintf('Pass: Number of pinion teeth (%d) satisfies recommended number of teeth (%d)\n', Np, Np_min)
end

disp('--------------------------------------')
disp('| Maximum Number of Gear Teeth Check |')
disp('--------------------------------------')

if Np >= 17
    Ng_max = inf; %if pinion has more than 17 teeth than you can use any size gear
else
    Ng_max = (Np^2*sind(phi)^2-4*k^2)/(4*k-2*Np*sind(phi)^2);
    Ng_max = floor(Ng_max);
end

if Ng > Ng_max
    fprintf('[\bFail: Number of gear teeth (%d) is above recommended number of teeth (%d)]\b \n', Ng, Ng_max)
else
    fprintf('Pass: Number of gear teeth (%d) satisfies max recommended number of teeth (%d)\n', Ng, Ng_max)
end

%% Check if contact Ratio is >= 1.4
disp('-------------------------------')
disp('| Minimum Contact Ratio Check |')
disp('-------------------------------')

LB1B2 = sqrt(rap^2-rbp^2)+sqrt(rag^2-rbg^2)-C*sind(phi); % Length of line action
mc = LB1B2/(pi*mp*cosd(phi)); % Contact Ratio
if mc < 1.4
    fprintf('[\bFail: The contact ratio (%0.3f) is less than 1.4]\b\n', mc)
else
    fprintf('Pass: The contact ratio (%0.3f) is greater than or equal to 1.4\n', mc')
end

%% Calculate gear bending stress using Lewis Form Factor
disp('-------------------------------------------------')
disp('| Pinion Bending Stress FOS - Lewis Form Factor |')
disp('-------------------------------------------------')

if strcmp(units, 'in')
    Wtp=2*Tp/dp; % Tangental Force on the pinion [lb]
    Wtg=2*R*Tp/dg; % Tangental Force on the gear [lb]
else
    Wtp=2*Tp/(dp*10^-3); % Tangental Force on the pinion [N]
    Wtg=2*R*Tp/(dg*10^-3); % Tangental Force on the gear [N]
end

% Calculate lewis form factor
load('Lewis_form_factor20deg_splinefit.mat');
Yp = ppval(Y_spline_fit,Np); % pinion Lewis form factor
Yg = ppval(Y_spline_fit,Ng); % gear Lewis form factor

if strcmp(units, 'in')
    sigma_p=Wtp*pd/(Fp*Yp);  %bending stress in the pinion [psi]
    sigma_g=Wtg*pd/(Fg*Yg);  %bending stress in the gear [psi]
else
    sigma_p=Wtp/(Fp*Yp*mp);  %bending stress in the pinion [MPa]
    sigma_g=Wtg/(Fg*Yg*mg);  %bending stress in the gear [MPa]
end

FOSp = ysp/sigma_p;
FOSg = ysg/sigma_g;

if FOSp < 1
    fprintf('[\bFail: The lewis bending stress in the pinion (%0.3d %s) is greater than the material yield stress. FOS = %0.3f]\b\n', sigma_p, stress_unit, FOSp)
else
    fprintf('Pass: The lewis bending stress in the pinion (%0.3d %s) is less than the material yield stress. FOS = %0.3f\n', sigma_p, stress_unit, FOSp)
end

disp('-----------------------------------------------')
disp('| Gear Bending Stress FOS - Lewis Form Factor |')
disp('-----------------------------------------------')

if FOSg < 1
    fprintf('[\bFail: The lewis bending stress in the gear (%0.3d %s) is greater than the material yield stress. FOS = %0.3f]\b\n', sigma_g, stress_unit, FOSg)
else
    fprintf('Pass: The lewis bending stress in the gear (%0.3d %s) is less than the material yield stress. FOS = %0.3f\n', sigma_g, stress_unit, FOSg)
end

%% Calculate bending stress using AGMA equations
disp('----------------------------------------------')
disp('| Pinion Bending Stress FOS - AGMA Equations |')
disp('----------------------------------------------')

sigma_p_AGMA = Wtp/(mp*Fp*kf.Jp)*kf.Ka*kf.Kv*kf.Km*kf.Ki; %note that module here is either in [mm] or [in]
sigma_g_AGMA = Wtg/(mg*Fg*kf.Jg)*kf.Ka*kf.Kv*kf.Km*kf.Ki;

FOSp_AGMA_bending = ysp/sigma_p_AGMA;
FOSg_AGMA_bending = ysg/sigma_g_AGMA;

if FOSp_AGMA_bending < 1
    fprintf('[\bFail: The AGMA bending stress in the pinion (%0.3d %s) is greater than the material yield stress. FOS = %0.3f]\b\n', sigma_p_AGMA, stress_unit, FOSp_AGMA_bending)
else
    fprintf('Pass: The AGMA bending stress in the pinion (%0.3d %s) is less than the material yield stress. FOS = %0.3f\n', sigma_p_AGMA, stress_unit, FOSp_AGMA_bending)
end
disp('--------------------------------------------')
disp('| Gear Bending Stress FOS - AGMA Equations |')
disp('--------------------------------------------')
if FOSg_AGMA_bending < 1
    fprintf('[\bFail: The AGMA bending stress in the gear (%0.3d %s) is greater than the material yield stress. FOS = %0.3f]\b\n', sigma_g_AGMA, stress_unit, FOSg_AGMA_bending)
else
    fprintf('Pass: The AGMA bending stress in the gear (%0.3d %s) is less than the material yield stress. FOS = %0.3f\n', sigma_g_AGMA, stress_unit, FOSg_AGMA_bending)
end
%% Tooth Bending Fatigue - AGMA Equations
disp('------------------------------------------');
disp('| Tooth Bending Fatigue - AGMA Equations |');
disp('------------------------------------------');

if strcmp(units, 'met')
    psi_over_MPA = 145.0377;
    Stbf_prime_p = (77.3*BHNp+12800)/psi_over_MPA; % MPa
    Stbf_prime_g = (77.3*BHNg+12800)/psi_over_MPA; % MPa
else 
    Stbf_prime_p = (77.3*BHNp+12800); % psi
    Stbf_prime_g = (77.3*BHNg+12800); % psi
end 
YN_p = sigma_p_AGMA/(kf.Rg*Stbf_prime_p);
YN_g = sigma_g_AGMA/(kf.Rg*Stbf_prime_g);

fprintf('YN for pinion: %0.3f \n', YN_p);
fprintf('YN for gear: %0.3f \n', YN_g);
fprintf('[\bLook at chart to find fatigue life in cycles ]\b\n');
open('YN.pdf');

%% Surface Stress - AGMA Equations

Cp = sqrt(1/(pi*( (1-vp^2)/(Ep) + (1-vg^2)/(Eg) ))); % Elastic Coefficient
I = sind(phi)*cosd(phi)*0.5*(R/(R+1)); % geometry factor

% Contact Stresses
sigma_sf_p = Cp*sqrt(Wtp*kf.Ka*kf.Kv*kf.Km/(dp*Fp*I)); %[MPa or psi]
sigma_sf_g = Cp*sqrt(Wtg*kf.Ka*kf.Kv*kf.Km/(dp*Fg*I)); %[MPa or psi]

% FOS
FOSp_AGMA_sf = ysp/sigma_sf_p;
FOSg_AGMA_sf = ysg/sigma_sf_g;

disp('-------------------------------------------------------')
disp('| Pinion Surface Contact Stress FOS  - AGMA Equations |')
disp('-------------------------------------------------------')

if FOSp_AGMA_sf < 1
    fprintf('[\bFail: The AGMA surface contact stress in the pinion (%0.3d %s) is greater than the material yield stress. FOS = %0.3f]\b\n', sigma_sf_p, stress_unit ,FOSp_AGMA_sf)
else
    fprintf('Pass: The AGMA surface contact stress in the pinion (%0.3d %s) is less than the material yield stress. FOS = %0.3f\n', sigma_sf_p, stress_unit, FOSp_AGMA_sf)
end
disp('----------------------------------------------------')
disp('| Gear Surface Contact Stress FOS - AGMA Equations |')
disp('----------------------------------------------------')
if FOSg_AGMA_sf < 1
    fprintf('[\bFail: The AGMA surface contact stress in the gear (%0.3d %s) is greater than the material yield stress. FOS = %0.3f]\b\n', sigma_sf_g, stress_unit, FOSg_AGMA_sf)
else
    fprintf('Pass: The AGMA surface contact stress in the gear (%0.3d %s) is less than the material yield stress. FOS = %0.3f\n', sigma_sf_g, stress_unit, FOSg_AGMA_sf)
end

%% Surface Fatigue Life - AGMA Equations
disp('------------------------------------');
disp('| Surface Fatigue - AGMA Equations |');
disp('------------------------------------');

if strcmp(units, 'met');
    Ssf_prime_p = (322*BHNp+29100)/psi_over_MPA; %MPa
    Ssf_prime_g = (322*BHNg+29100)/psi_over_MPA; %MPa
else
    Ssf_prime_p = (322*BHNp+29100); % psi
    Ssf_prime_g = (322*BHNg+29100); % psi
end

ZN_p = sigma_sf_p/(kf.Rg*Ssf_prime_p);
ZN_g = sigma_sf_g/(kf.Rg*Ssf_prime_g);

fprintf('ZN for pinion: %0.3f \n', ZN_p);
fprintf('ZN for gear: %0.3f \n', ZN_g);
fprintf('[\bLook at chart to find fatigue life in cycles ]\b\n');
open('ZN.pdf');

%% Output the Maximum radial load
disp('-------------------------------');
disp('| Tangential and Radial Loads |');
disp('-------------------------------');

if strcmp(units, 'in')
    fprintf('Pitch line tangential force: %0.2f lb\n',Wtp);
    fprintf('Radial load: %0.2f lb \n',Wtp*tand(20));
else
    fprintf('Pitch line tangential force: %0.2f N\n',Wtp);
    fprintf('Radial load: %0.2f N \n',Wtp*tand(20));
end

end