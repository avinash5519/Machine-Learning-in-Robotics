function [ CenterPixels ] = ExtractCenterPixels( ImageName, p )
%EXTRACTCENTERPIXELS Summary of this function goes here
%   Detailed explanation goes here


 I=imread(ImageName);
  
 %height and width of image
 H=size(I,1) ;
 W=size(I,2);
 
 %Center Pixels
 CenterPixel_Row= H/2 ;
 CenterPixel_Column= W/2 ;

%Height and Width of surrounding rectangle
 RHeight= floor(p*H);
 RWidth= floor(p*W);
 
%Left most corners of rectangle R around the center
 R_Row= CenterPixel_Row - floor(RHeight/2)+1 ;
 R_Column= CenterPixel_Column - floor(RWidth/2)+1 ;
 
%transforming in spatial cordinates for imcrop
 R_X=R_Column;
 R_Y= R_Row;
 
 % -1 is done because imcrop returns one extra pixel
 R=imcrop(I,[R_X, R_Y , RWidth-1, RHeight-1]);
 rgbValues = reshape(R, [size(R,1)*size(R,2), 3]);
 CenterPixels= rgbValues;

end

