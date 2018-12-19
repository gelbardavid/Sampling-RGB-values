function ColoredImage = GrayscalePaint(ImageGray,ColoredImage,MaskMat,ColorSamples)
%GrayscalePaint Paint the grayscale image.

prompt1=['Please select the color you want to paint\n',...
    'For Blue press 1\n', 'For Green press 2\n', 'For Brown press 3\n'];
n=input(prompt1);

switch n
    case 1
        GreenSep=MaskMat;
        BlueSep=GreenSep+double(ColorSamples(end-1).Median_Blue...
            -ColorSamples(end-1).Median_Green);
        RedSep=GreenSep-double(ColorSamples(end-1).Median_Green...
            -ColorSamples(end-1).Median_Red);
    case 2
        RedSep=MaskMat;
        GreenSep=RedSep+double(ColorSamples(end-1).Median_Green...
            -ColorSamples(end-1).Median_Red);
        BlueSep=RedSep-double(ColorSamples(end-1).Median_Red...
            -ColorSamples(end-1).Median_Blue);
    case 3
        GreenSep=MaskMat;
        RedSep=GreenSep+double(ColorSamples(end-1).Median_Red...
            -ColorSamples(end-1).Median_Green);
        BlueSep=GreenSep-double(ColorSamples(end-1).Median_Green...
            -ColorSamples(end-1).Median_Blue);
end

for i=1:size(ImageGray,1)
    for j=1:size(ImageGray,2)
        if MaskMat(i,j)~=0
            ColoredImage(i,j,1)=RedSep(i,j);
            ColoredImage(i,j,2)=GreenSep(i,j);
            ColoredImage(i,j,3)=BlueSep(i,j);
        end
    end
end

end

