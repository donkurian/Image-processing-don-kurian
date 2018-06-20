% MATLAB script for Assessment Item-1
% Task-2
clear; close all; clc;
% Task-2:Point Processing
SC = imread('SC.png');

new = SC;
[x, y] = size (SC);
%This loop Searches for values that are greater than 80, but are either equal to or less than 100. 
%these values are then assigned the value 220
for A = 1:x
    for B = 1:y
        if SC (A, B) >= 80 && SC (A, B) <= 100
            new (A, B) = 220;
        else
           SC (A, B) = new (A, B);
        end
    end
end

%Displays the Image for Task2 in a subplot
subplot (2, 2, 1); imshow(SC); title ('Task-2.1:Load output Image');
subplot (2, 2, 4); imshow(new); title('Task-2.2:Piecewise-Linear transformation Image');

