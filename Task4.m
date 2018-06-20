% MATLAB script for Assessment Item-1
%Task-4
close all;
% Task-4.1:Load input image
InputImage = imread('Starfish.jpg');
% Task-4.2:Conversion of input image to greyscale
GrayImage = rgb2gray(imread('Starfish.jpg'));
% Task-4.3:Median filetring to remove noise from image 
FilterImage = medfilt2(GrayImage);
% Task-4.4:Sharpening the Image after its Filtered 
SharpenImage= imsharpen(FilterImage);

%Display all tasks from 4.1 - 4.4 in a subplot 
figure('Name','Images of Task 4.1 - 4.4','NumberTitle','off');
subplot(2,2,1);imshow(InputImage); title('Output Image');
subplot(2,2,2);imshow(GrayImage); title('Grayscale Output Image');
subplot(2,2,3);imshow(FilterImage);title('Median Filter Image');
subplot(2,2,4);imshow(SharpenImage);title('Sharpened Image');

% Task-4.5:Binary Image Segmentation 
ImageBW = imbinarize(SharpenImage,0.92);
ImageBW = ~ImageBW ;

% Task-4.6:Morphological Processing
se = strel('square',4);
se2 = strel('disk',3);
SharpenImage = imerode(ImageBW, se);
DilateImage = imdilate(SharpenImage, se2);

MorphImage = bwareaopen(DilateImage, 250);
% Step-7:Starfish recognition

MorphImage1 = MorphImage;
L = bwlabel(MorphImage1);
S = regionprops(L, 'Area', 'Perimeter');
metrics = zeros(1,25);
area = [S.Area];
perimeter = [S.Perimeter];
for i = 1 : length(metrics)
    metrics(i) = 4*pi*area(i)/perimeter(i).^2;
end

 % Find all starfish obejcts based on roundness metric range and move into
 % a new Image.
idx = find(( metrics > 0.21)  & (metrics < 0.26));
StarfishFinal = ismember(L, idx);

%Display all tasks from 4.5 - 4.7 in a subplot 
figure('Name','Images of Task 4.5 - 4.7','NumberTitle','off');
subplot(2,2,1);imshow(ImageBW);title('Binary Image');
subplot(2,2,2);imshow(MorphImage);title('Step-7 Automatic recognition');
subplot(2,2,3);imshow(StarfishFinal);title('Step-7 Automatic recognition');

%Displays the final result of the Image recognition
figure('Name','Final result','NumberTitle','off');
imshow(StarfishFinal);
title('Step-7 Automatic recognition');