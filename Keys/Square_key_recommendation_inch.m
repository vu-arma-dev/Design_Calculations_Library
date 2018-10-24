function [ set_screw_size, key_size ] = Square_key_recommendation_inch( shaft_diameter )
%% SQUARE_KEY_RECOMMENDATION: Recommends an inch square key/inch set screw combo for a given shaft diameter of range 5/16 to 6.5 inches. Based on ANSI Standard B17.1.
%% [1] J. Collins, H. Busby and G. Staab, Mechanical design of machine elements and machines, 2nd ed. Hoboken: John Wiley & Sons, 2010.
% Table 8.1. Page 366.
%% Garrison Johnston 10/24/2018
%% INPUTS:
% shaft_diameter: The diameter of the shaft where the key will be placed
%% OUTPUTS:
% set_screw_size: The size of the set screw ex: '#10-32'
% key_size: The side width of the key [in]
%% Main
if (((5/16)<= shaft_diameter) && (shaft_diameter <= 7/16))
    key_size = 3/32;
    set_screw_size = '#10-32';
    
elseif (((1/2)<= shaft_diameter) && (shaft_diameter <= 9/16))
    key_size = 1/8;
    set_screw_size = '1/4-20';
    
elseif (((5/8)<= shaft_diameter) && (shaft_diameter <= 7/8))
    key_size = 3/16;
    set_screw_size = '5/16-18';
    
elseif (((15/16)<= shaft_diameter) && (shaft_diameter <= (1+1/4)))
    key_size = 1/4;
    set_screw_size = '3/8-16';
    
elseif (((1+5/16)<= shaft_diameter) && (shaft_diameter <= (1+3/8)))
    key_size = 5/16;
    set_screw_size = '7/16-14';
    
elseif (((1+7/16)<= shaft_diameter) && (shaft_diameter <= (1+3/4)))
    key_size = 3/8;
    set_screw_size = '1/2-13';
    
elseif (((1+13/16)<= shaft_diameter) && (shaft_diameter <= (2+1/4)))
    key_size = 1/2;
    set_screw_size = '9/16-12';

elseif (((2+5/16)<= shaft_diameter) && (shaft_diameter <= (2+3/4)))
    key_size = 5/8;
    set_screw_size = '5/8-11';
    
elseif (((2+13/16)<= shaft_diameter) && (shaft_diameter <= (3+1/4)))
    key_size = 3/4;
    set_screw_size = '3/4-10';

elseif (((3+5/16)<= shaft_diameter) && (shaft_diameter <= (3+3/4)))
    key_size = 7/8;
    set_screw_size = '7/8-9'; 
    
elseif (((3+13/16)<= shaft_diameter) && (shaft_diameter <= (4+1/2)))
    key_size = 1;
    set_screw_size = '1-8'; 

elseif (((4+9/16)<= shaft_diameter) && (shaft_diameter <= (5+1/2)))
    key_size = 1+1/4;
    set_screw_size = '1 1/8-7';     

elseif (((5+9/16)<= shaft_diameter) && (shaft_diameter <= (6+1/2)))
    key_size = 1+1/2;
    set_screw_size = '1 1/4-6';
else
    disp('Shaft diameter out of the range.')
end
%% NOTE: It is still nessesary to do a stress analysis. This is only a first pass design step. 
