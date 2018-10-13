function [ L_rev ] = roller_bearing_fatigue( dynamic_rating, radial_load )
%% BALL_BEARING_FATIGUE: This function calculates the 90% reliability* fatigue life of a roller bearing 
%% INPUTS: 
% dynamic_rating: Dynamic radial load rating of the bearing [N or lbf]
% radial_load: Radial load applied to the bearing [N or lbf]
%% OUTPUTS:
% L_rev: Estimated number revolutions to failure
%% Garrison Johnston 10/13/2018
%% revolutions to failure
L_rev = (dynamic_rating/radial_load)^(10/3)*10^6;
end