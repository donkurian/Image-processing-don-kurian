  %MATLAB script for Assessment Item-1
%Task-3.1:read in image 
clear; close all; clc;
%Task-3.1:read in image with Noisy  
NoisyI =imread('Noisy.png');

%Task-3.2:convert Image to grayscale 
GINoisy = rgb2gray(imread('Noisy.png'));

%Task-3.3:Median Image Filtering 
%N is the kernel mask size which is 5by5 
%Y5 is Zero padding which deals with pixel that are on the edge of the
%Image 
N = 5;
K5 = zeros(size(GINoisy));

%This section of the code is used to workout the Median value of the kernel
for i = 1:size(GINoisy,1)-N+1
    for j = 1:size(GINoisy,2)-N+1
        K5(i,j) = median(reshape(GINoisy(i:i+N-1,j:j+N-1),[1, N^2]));
    end
end

%Task-3.4:Average Image Filtering
%R and C indicate the rows, and colums within the Image
%this section of the code delcares the size of the kernel mask which is 5  
[r,c]=size(GINoisy);
z=ones(5);
[p,q]=size(z);

w=1:p;
x=round(median(w));
anz=zeros(r+2*(x-1),c+2*(x-1));

for i=x:(r+(x-1))
    for j=x:(c+(x-1))
        anz(i,j)=GINoisy(i-(x-1),j-(x-1));
    end
end

sum=0;
x=0;
y=0;
for i=1:r
    for j=1:c
        for k=1:p
            for l=1:q 
                sum= sum+anz(i+x,j+y)*z(k,l);
                y=y+1;
            end
            y=0;
            x=x+1;
        end
        x=0;
        GINoisy(i,j)=(1/(p*q))*(sum);
        sum=0;
    end
end

%Display Averaging Filter Image 
figure('Name','Averaging Filter Image','NumberTitle','off');
imshow(GINoisy);
title ('Averaging Filter Image');

%Display Median Filter Image
figure('Name','Median Filter Image','NumberTitle','off');
imshow(uint8(K5));
title('Median Filter Image');

%Display all Image for Task3 in a subplot 
figure('Name','Images Results For Filtering','NumberTitle','off');
subplot(2,2,1);imshow (NoisyI);title('Task-3.2:Grayscale Noisy Image');
subplot(2,2,2);imshow(uint8(K5));title ('Task-3.3:Median Filter Image');
subplot(2,2,3);imshow (GINoisy);title ('Task-3.4:Averaging Filter Image');


