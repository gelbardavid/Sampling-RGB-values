clear all; clc;
%% Deciding how many images to sample
ColorSamples=[];
prompt='\How many images would you like to sample?\n';
Count=input(prompt);
Conclusion=1;
clear prompt
%% Sampling loop
for C=1:Count
I=imread(sprintf...
    ('Ocean (%d).jpg',C));

if size(I,1)>1000
    I=imresize(I,[1000 NaN]);
end
% I=medfilt3(I);
imshow(I);

area=imfreehand;
% area=impoly;
% area=imline;
% area=impoint;
% area=imrect;

Mask=createMask(area);

Icolor=zeros(size(I,1),size(I,2),3);
Icolor(:,:,1)=double(I(:,:,1)).*Mask;
Icolor(:,:,2)=double(I(:,:,2)).*Mask;
Icolor(:,:,3)=double(I(:,:,3)).*Mask;
Icolor=uint8(Icolor);

ColorSamples(C).Mean_Red=(sum(sum(Icolor(:,:,1))))/sum(sum(Mask));
ColorSamples(C).Mean_Green=(sum(sum(Icolor(:,:,2))))/sum(sum(Mask));
ColorSamples(C).Mean_Blue=(sum(sum(Icolor(:,:,3))))/sum(sum(Mask));
imshow(Icolor);

Yr=size(I,1);
Xr=size(I,2);

J=struct([]);
j=1;
K=struct([]);
k=1;

for i=1:Yr
    SUMred=max(sum(Icolor(i,:,1)));
    SUMgreen=max(sum(Icolor(i,:,2)));
    SUMblue=max(sum(Icolor(i,:,3)));
    if SUMred~=0 || SUMgreen~=0 || SUMblue~=0
        J{j}=i;
        j=j+1;
    end
end
J=cell2mat(J);
Ymin=min(J);
Ymax=max(J);

for i=1:Xr
    SUMred=max(sum(Icolor(:,i,1)));
    SUMgreen=max(sum(Icolor(:,i,2)));
    SUMblue=max(sum(Icolor(:,i,3)));
    if SUMred~=0 || SUMgreen~=0 || SUMblue~=0
        K{k}=i;
        k=k+1;
    end
end
K=cell2mat(K);
Xmin=min(K);
Xmax=max(K);

ImSampCrop=imcrop(Icolor,[Xmin Ymin (Xmax-Xmin) (Ymax-Ymin)]);
imshow(ImSampCrop);

m=1;
R=[];
for i=1:size(ImSampCrop,1)
    for j=1:size(ImSampCrop,2)
        if ImSampCrop(i,j,1)~=0
            R{m}=ImSampCrop(i,j,1);
            m=m+1;
        end
    end
end
R=cell2mat(R);

m=1;
G=[];
for i=1:size(ImSampCrop,1)
    for j=1:size(ImSampCrop,2)
        if ImSampCrop(i,j,2)~=0
            G{m}=ImSampCrop(i,j,2);
            m=m+1;
        end
    end
end
G=cell2mat(G);

m=1;
B=[];
for i=1:size(ImSampCrop,1)
    for j=1:size(ImSampCrop,2)
        if ImSampCrop(i,j,3)~=0
            B{m}=ImSampCrop(i,j,3);
            m=m+1;
        end
    end
end
B=cell2mat(B);

ColorSamples(C).Min_Red=min(R);
ColorSamples(C).Min_Green=min(G);
ColorSamples(C).Min_Blue=min(B);

ColorSamples(C).Max_Red=max(R);
ColorSamples(C).Max_Green=max(G);
ColorSamples(C).Max_Blue=max(B);

ColorSamples(C).Median_Red=median(R);
ColorSamples(C).Median_Green=median(G);
ColorSamples(C).Median_Blue=median(B);

Conclusion=Conclusion+1;

close all force;
end
%% Clearing redundant varibles
clear I a R B G Count i Icolor IMIM j J K k m Mask p SUMblue SUMred ...
    SUMgreen Xmax Xmin Ymax Ymin Yr Xr
%% Mean of all "Mean" inputs
ColorSamples(Conclusion+1).Mean_Red=...
    sum([ColorSamples(:).Mean_Red])/length(ColorSamples);
ColorSamples(Conclusion+1).Mean_Green=...
    sum([ColorSamples(:).Mean_Green])/length(ColorSamples);
ColorSamples(Conclusion+1).Mean_Blue=...
    sum([ColorSamples(:).Mean_Blue])/length(ColorSamples);
%% Standard deviation of all "Mean" inputs
ColorSamples(Conclusion+2).Mean_Red=...
    std(double([ColorSamples.Mean_Red]));
ColorSamples(Conclusion+2).Mean_Green=...
    std(double([ColorSamples.Mean_Green]));
ColorSamples(Conclusion+2).Mean_Blue=...
    std(double([ColorSamples.Mean_Blue]));
%% Min of all "Min" inputs
ColorSamples(Conclusion+1).Min_Red=min([ColorSamples(:).Min_Red]);
ColorSamples(Conclusion+1).Min_Green=...
    min([ColorSamples(:).Min_Green]);
ColorSamples(Conclusion+1).Min_Blue=...
    min([ColorSamples(:).Min_Blue]);
%% Standard deviation of all "Min" inputs
ColorSamples(Conclusion+2).Min_Red=...
    std(double([ColorSamples.Min_Red]));
ColorSamples(Conclusion+2).Min_Green=...
    std(double([ColorSamples.Min_Green]));
ColorSamples(Conclusion+2).Min_Blue=...
    std(double([ColorSamples.Min_Blue]));
%% Max of all "Max" inputs
ColorSamples(Conclusion+1).Max_Red=max([ColorSamples(:).Max_Red]);
ColorSamples(Conclusion+1).Max_Green=max([ColorSamples(:).Max_Green]);
ColorSamples(Conclusion+1).Max_Blue=max([ColorSamples(:).Max_Blue]);
%% Standard deviation of all "Max" inputs
ColorSamples(Conclusion+2).Max_Red=...
    std(double([ColorSamples.Max_Red]));
ColorSamples(Conclusion+2).Max_Green=...
    std(double([ColorSamples.Max_Green]));
ColorSamples(Conclusion+2).Max_Blue=...
    std(double([ColorSamples.Max_Blue]));
%% Median of all "Median" inputs
ColorSamples(Conclusion+1).Median_Red=...
    median([ColorSamples.Median_Red]);
ColorSamples(Conclusion+1).Median_Green=...
    median([ColorSamples.Median_Green]);
ColorSamples(Conclusion+1).Median_Blue=...
    median([ColorSamples.Median_Blue]);
%% Standard deviation of all "Median" inputs
ColorSamples(Conclusion+2).Median_Red=...
    std(double([ColorSamples.Median_Red]));
ColorSamples(Conclusion+2).Median_Green=...
    std(double([ColorSamples.Median_Green]));
ColorSamples(Conclusion+2).Median_Blue=...
    std(double([ColorSamples.Median_Blue]));
%%
A=zeros(500,500,3);
A_up=A;
A_down=A;

A(:,:,1)=ColorSamples(end-1).Median_Red;
A(:,:,2)=ColorSamples(end-1).Median_Green;
A(:,:,3)=ColorSamples(end-1).Median_Blue;

if (ColorSamples(end-1).Median_Red+ColorSamples(end).Median_Red)>255
    A_up(:,:,1)=255;
else
    A_up(:,:,1)=ColorSamples(end-1).Median_Red+ColorSamples(end).Median_Red;
end

if (ColorSamples(end-1).Median_Green+ColorSamples(end).Median_Green)>255
    A_up(:,:,2)=255;
else
    A_up(:,:,2)=ColorSamples(end-1).Median_Green+ColorSamples(end).Median_Green;
end

if (ColorSamples(end-1).Median_Blue+ColorSamples(end).Median_Blue)>255
    A_up(:,:,3)=255;
else
    A_up(:,:,3)=ColorSamples(end-1).Median_Blue+ColorSamples(end).Median_Blue;
end

if (ColorSamples(end-1).Median_Red-ColorSamples(end).Median_Red)<0
    A_down(:,:,1)=0;
else
    A_down(:,:,1)=ColorSamples(end-1).Median_Red-ColorSamples(end).Median_Red;
end

if (ColorSamples(end-1).Median_Green-ColorSamples(end).Median_Green)<0
    A_down(:,:,2)=0;
else
    A_down(:,:,2)=ColorSamples(end-1).Median_Green-ColorSamples(end).Median_Green;
end

if (ColorSamples(end-1).Median_Blue-ColorSamples(end).Median_Blue)<0
    A_down(:,:,3)=0;
else
    A_down(:,:,3)=ColorSamples(end-1).Median_Blue-ColorSamples(end).Median_Blue;
end

A=uint8(A); A_up=uint8(A_up); A_down=uint8(A_down); 

subplot(1,3,1)
imshow(A);
title(['[', num2str(A(1,1,1)), ',', num2str(A(1,1,2)), ',',...
    num2str(A(1,1,3)), ']'],'fontsize',16);
subplot(1,3,2)
imshow(A_up);
title(['[+', num2str(round(ColorSamples(end).Median_Red)), ',+',...
    num2str(round(ColorSamples(end).Median_Green)), ',+',...
    num2str(round(ColorSamples(end).Median_Blue)), ']'],'fontsize',16);
subplot(1,3,3)
imshow(A_down);
title(['[-', num2str(round(ColorSamples(end).Median_Red)), ',-',...
    num2str(round(ColorSamples(end).Median_Green)), ',-',...
    num2str(round(ColorSamples(end).Median_Blue)), ']'],'fontsize',16);
% clear A A_down A_up Conclusion
%%

G1=imread('Ocean (14).jpg');
i=1;
Igr=rgb2gray(G1);
Igr=imresize(Igr,[800 NaN]);

Icolor=zeros(size(Igr,1),size(Igr,2),3);
Icolor(:,:,1)=Igr; Icolor(:,:,2)=Igr; Icolor(:,:,3)=Igr;
Icolor=uint8(Icolor);

imshow(Icolor);
Mask=imfreehand;
Mask=createMask(Mask);
U=double(Igr).*Mask;
Icolor=GrayscalePaint(Igr,Icolor,U,ColorSamples);
imshow(Icolor);
while i==1
    Mask=imfreehand;
    Mask=createMask(Mask);
    U=double(Igr).*Mask;
    Icolor=GrayscalePaint(Igr,Icolor,U,ColorSamples);
    imshow(Icolor);
end