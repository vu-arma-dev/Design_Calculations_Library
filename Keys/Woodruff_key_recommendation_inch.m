function [ key_number, width, length, height ] = Woodruff_key_recommendation_inch( shaft_diameter )
%% WOODRUFF_KEY_RECOMMENDATION: Recommends an inch woodruff key for a given shaft diameter of range 7-16 in to 2.5 inches. Based on ANSI Standard B17.2.
%% [1] J. Collins, H. Busby and G. Staab, Mechanical design of machine elements and machines, 2nd ed. Hoboken: John Wiley & Sons, 2010.
%% Garrison Johnston 10/16/2018
%% INPUTS:
% shaft_diameter: The diameter of the shaft where the key will be placed
%% OUTPUTS:
% key_number: Standard industry key number. last two digits are nominal key diameter in 1/8 inches. The reminaing digits are width
%             in 1/32 inches.
% width: width of the key [in]
% length: length of the key [in]
% height: height of the key [in]
%% Main
if (((7/16)<= shaft_diameter) && (shaft_diameter <= 1/2))
    key_number = 305;
    width = 3/32;
    length = 5/8;
    height = 0.25;
elseif (((11/16)<= shaft_diameter) && (shaft_diameter <= 3/4))
    key_number = 405;
    width = 1/8;
    length = 5/8;
    height = 0.25;
elseif (((13/16)<= shaft_diameter) && (shaft_diameter <= 15/16))
    key_number = 506;
    width = 5/32;
    length = 3/4;
    height = 0.312;
elseif ((1<= shaft_diameter <= (1+3/16)) && (shaft_diameter <= (1+3/16)))
    key_number = 608;
    width = 3/16;
    length = 1;
    height = 0.437;
elseif (((1+1/4)<= shaft_diameter) && (shaft_diameter <= (1+3/4)))
    key_number = 809;
    width = 1/4;
    length = 1+1/8;
    height = 0.484;
elseif (((1+7/8)<= shaft_diameter) && (shaft_diameter <= (2+1/2)))
    key_number = 1212;
    width = 3/8;
    length = 1+1/2;
    height = 0.641;
else
    disp('Shaft diameter out of the range.')
end
%% NOTE: It is still nessesary to do a stress analysis. This is only a first pass design step. 
