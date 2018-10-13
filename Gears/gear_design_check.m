function gear_design_check(units, Np, Ng, dp, dg, Fp, Fg, ysp, ysg, Tp)
%% gear_design_check: checks if a 20deg pressure gear-pinion pair meets the design requirements set on the "Gear Design" ARMA Wiki Page
%% INPUTS:
%  units -- 'met' for metric or 'in' for inch
%  Np -- Number of teeth on pinion
%  Ng -- Number of teeth on gear
%  dp -- pitch diameter on pinion [mmm or in]
%  dg -- Pitch diameter on gear [mmm or in]
%  Fp -- Pinion face width [mm or in]
%  Fg -- Gear Face Width [mm or in]
%  ysp -- Pinion material yield stress [MPa]
%  ysg -- Gear Material yield stress [MPa]
%  Tp -- Maximum torque on the pinion [lbf*in or N*m]
%% OUTPUTS:
% NONE
%% Garrison Johnston 7/23/2018
%% Constants
phi = 20;                % [deg] -- pressure angle
k = 1;                   % Geometric Factor for full depth teeth
%% Calculate gear parameters
C = (dp+dg)/2;           % [mm or in] -- center distance
mp = dp/Np;              % pinion module
mg = dg/Ng;              % gear module
R = Ng/Np;               % Gear ratio
rbp = mp*Np/2*cosd(phi); % [mm or in] -- pinion base circle radius
rbg = mg*Ng/2*cosd(phi); % [mm or in] -- gear base circle radius
rap = mp*(Np+2)/2;       % [mm or in] -- pinion addendum circle radius
rag = mg*(Ng+2)/2;       % [mm or in] -- pinion addendum circle radius
pd = Ng/dg;              % Gear Diametral Pitch
%% Check if modules match
if strcmp(units, 'met')
    disp('-----------------------')
    disp('| Module Number Check |')
    disp('-----------------------')
    if mg ~= mp
        fprintf('Fail: The module of the gear (%d) does not equal the module of the pinion (%d). Gears will not mesh.\n', mg, mp)
%         return
    else
        fprintf('Pass: The module of the gear (%d) equals the module of the pinion (%d). Gears will mesh.\n', mg, mp)
    end
elseif strcmp(units, 'in')
    disp('------------------------')
    disp('| Circular Pitch Check |')
    disp('------------------------')
    if mg ~= mp
        fprintf('Fail: The circular pitch of the gear (%d) does not equal the circular pitch of the pinion (%d). Gears will not mesh.\n', pi*mg, pi*mp)
%         return
    else
        fprintf('Pass: The circular pitch of the gear (%d) equals the circular pitch of the pinion (%d). Gears will mesh.\n', pi*mg, pi*mp)
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
    fprintf('Fail: The gear ratio (%d) is a whole number\n', R)
else
    fprintf('Pass: The gear ratio (%d) is a not a whole number\n', R)
end

%% Min/Max Number of Teeth
disp('----------------------------------------')
disp('| Minimum Number of Pinion Teeth Check |')
disp('----------------------------------------')

Np_min = 2*k/((1+2*R)*(sind(phi))^2)*(R+sqrt(R^2 +(1+2*R)*sind(phi)^2));
Np_min = ceil(Np_min);
if Np < Np_min
    fprintf('Fail: Number of pinion teeth (%d) is below recommended number of teeth (%d)\n', Np, Np_min)
else
    fprintf('Pass: Number of pinion teeth (%d) satisfies recommended number of teeth (%d)\n', Np, Np_min)
end

disp('--------------------------------------')
disp('| Maximum Number of Gear Teeth Check |')
disp('--------------------------------------')

Ng_max = (Np_min^2*sind(phi)^2-4*k^2)/(4*k-2*Np_min*sind(phi)^2);
Ng_max = floor(Ng_max);
if Ng > Ng_max
    fprintf('Fail: Number of gear teeth (%d) is above recommended number of teeth (%d)\n', Ng, Ng_max)
else
    fprintf('Pass: Number of gear teeth (%d) satisfies recommended number of teeth (%d)\n', Ng, Ng_max)
end
%% Check if contact Ratio is >= 1.4
disp('-------------------------------')
disp('| Minimum Contact Ratio Check |')
disp('-------------------------------')

LB1B2 = sqrt(rap^2-rbp^2)+sqrt(rag^2-rbg^2)-C*sind(phi); % Length of line action
mc = LB1B2/(pi*mp*cosd(phi)); % Contact Ratio
if mc < 1.4
    fprintf('Fail: The contact ratio (%d) is less than 1.4\n', mc)
else
    fprintf('Pass: The contact ratio (%d) is greater than or equal to 1.4\n', mc')
end
%% Calculate gear bending stress
disp('-----------------------------')
disp('| Pinion Bending Stress FOS |')
disp('-----------------------------')
Wtp=2*Tp/(dp*10^-3); % Tangental Force on the pinion
Wtg=2*R*Tp/(dg*10^-3); % Tangental Force on the gear

% Calculate lewis form factor
load('Lewis_form_factor20deg_splinefit.mat');
Yp = ppval(Y_spline_fit,Np); % pinion Lewis form factor
Yg = ppval(Y_spline_fit,Ng); % gear Lewis form factor

if strcmp(units, 'in')
    sigma_p=Wtp*pd/(Fp*Yp*25.4^2);  %bending stress in the pinion [MPa]
    sigma_g=Wtg*pd/(Fg*Yg*25.4^2);  %bending stress in the pinion [MPa]
else
    sigma_p=Wtp/(Fp*Yp*mp);  %bending stress in the pinion [MPa]
    sigma_g=Wtg/(Fg*Yg*mg);  %bending stress in the pinion [MPa]
end
FOSp = ysp/sigma_p;
FOSg = ysg/sigma_g;
if FOSp < 1
    fprintf('Fail: The lewis bending stress in the pinion (%d MPa) is greater than the material yield stress. FOS = %d\n', sigma_p, FOSp)
else
    fprintf('Pass: The lewis bending stress in the pinion (%d MPa) is less than the material yield stress. FOS = %d\n', sigma_p, FOSp)
end
disp('---------------------------')
disp('| Gear Bending Stress FOS |')
disp('---------------------------')
if FOSg < 1
    fprintf('Fail: The lewis bending stress in the gear (%d MPa) is greater than the material yield stress. FOS = %d\n', sigma_g, FOSg)
else
    fprintf('Pass: The lewis bending stress in the gear (%d MPa) is less than the material yield stress. FOS = %d\n', sigma_g, FOSg)
end
end