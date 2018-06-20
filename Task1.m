% MATLAB script for Assessment Item-1
% Task-1
clear; close all; clc;
% Task-1.1:Read in Zebra image 
Zebra = imread('Zebra.jpg');

% Task-1.2:Conversion of input image to grey-scale image;
ZIgray = rgb2gray(imread('Zebra.jpg'));
%Displays the Images for Task-1.1 and Task-1.2 in a subplot
figure('Name','load output Image and Conversion of input Image to grey-scale Image','NumberTitle','off');
subplot (2, 2, 1); imshow(Zebra); title ('Task-1.1:Load output Image');
subplot (2, 2, 4); imshow(ZIgray); title('Task-1.2:Conversion of input Image to grey-scale Image');

% Task-1.3:Nearest Neighbour Interpolation
scale = [3, 3];
originalSize = size (ZIgray);
newSize = max(floor(scale.*originalSize(1:2)),1);

rowIndex = min(round(((1:newSize(1))-0.5)./scale(1)+0.5),originalSize(1));
colIndex = min(round(((1:newSize(2))-0.5)./scale(2)+0.5),originalSize(2));

%Displays the Images for Task-l.3
figure('Name','Nearest Neighbour Interpolation','NumberTitle','off');
imshow(ZIgray(rowIndex, colIndex,:));
title ('Task-1.3:Nearest Neighbour Interpolation');

% Step-1.4 - Bilinear interpolation
%creates a matrix of 0s of correct size 
NewIgray = zeros(1668, 1836);

for A = 1:1668

    ValA0 = (A - 1)/3;
    ValA_1 = (A / 3);
    ValA_2 = (A + 1)/3;
    
    A0 = round (ValA0);
    A_1 = round (ValA_1);
    A_2 = round (ValA_2);
    
    if (A0 < 1)
        A0 = A0 + 1;
        ValA0 = A0;
    end
    
    if (A_2 > 1668)
        A_2 = A_2 - 1;
        ValA_2 = A_2;
    end
    
    WeightA0 = (1 - (ValA_2 - ValA0)) / 3;
    WeightA_2 = (1 - (ValA0 - ValA_1)) / 3;
    
    if (A_1 < 2)
        A_1 = A_1 +1;
        WeightA0 = (1 / 3);
        WeightA_2 = (1 / 3);
    end
    
    for B = 1:1836
        
        ValB0 = (B - 1) / 3;
        ValB_1 = (B/3);
        ValB_2 = (B + 1) / 3;
        
        B0 = round(ValB0);
        B_1 = round(ValB_1);
        B_2 = round(ValB_2);
        
        if (B0 < 1)
            B0 = B0 + 1;
            ValB0 = B0;
        end
        
        if (B_2 > 1836)
            B_2 = B_2 - 1;
            ValB_2 = B_2;
        end
        
    WeightB0 = (1 - (ValB_2 - ValB0))/3;
    WeightB_2 = (1 - (ValB0 - ValB_1))/3;
    
    if (B_1 < 2)
        B_1 = B_1 +1;
        WeightB0 = (1/3);
        WeightB_2 = (1/3);
    end
    
    % Take all 4 coners of the Image, and then resizes it 
        BL=ZIgray(A0,B_1,:);          
        TL=ZIgray(A_2,B_1,:);
        BR=ZIgray(A_1,B0,:);
        TR=ZIgray(A_1,B_2,:);
        
         R1=BR*WeightB0+BL*(1-WeightB0);
         R2=TR*WeightB_2+TL*(1-WeightB_2);
        
        
       im_zoom(A,B,:)=R1*WeightA_2+R2*(1-WeightA0);
    end
end
%double to uint8 for viewing
im_zoom = uint8(im_zoom);
%Displays the Image for Task-1.4
figure('Name','Bilnear Interpolation','NumberTitle','off');
imshow(im_zoom);
title('Figure 4: Bilinear Interpolation');
