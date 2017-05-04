function [ mu, sigma ] = LearnModelParameters( DirectoryName, n ,p)
%LEARNMODELPARAMETERS Summary of this function goes here
%   Detailed explanation goes here

CenterPixelsArray=[];
filesList=dir(strcat(DirectoryName,'*jpg') );

if (n == 0 )
    %n zero means consider all files in directory
     n = length(filesList);   
else
    if (n > length(filesList))
        return ;
    end 
end 

for i=1:n
   ImageName=getImageName(DirectoryName,filesList(i).name);
   CenterPixels= ExtractCenterPixels(ImageName,p) ;
   CenterPixelsArray=[ CenterPixelsArray; CenterPixels];

end 

mean_RGB=mean(double(CenterPixelsArray));
cov_RGB=cov(double(CenterPixelsArray));


mu=transpose(mean_RGB); % to change from 1*3
sigma=cov_RGB ;


end

function[ImageName] =getImageName(DirectoryName, ImageName)
    ImageName=strcat(DirectoryName,ImageName);
    %formatSpec = strcat(DirectoryName,'/George_W_Bush_000%d.jpg');
    %ImageName = sprintf(formatSpec,ImageNumber)

end

