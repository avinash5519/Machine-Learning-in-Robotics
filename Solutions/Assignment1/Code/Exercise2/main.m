close all ;
clear ;

%Uncomment the below line for SampleImage.jpg
%TestImage=imread('SampleImage.jpg');

TestImage=imread('SampleImage2.jpg');

%Learning Skin model
Directory1='lfw/George_W_Bush/';
%The specifies n should be less than or equal to the total images present in the directory
%n=0 means all files from the directory are taken..
n1=20 ;
p1=0.2 ;

[SkinModelMu,SkinModelSigma]=LearnModelParameters(Directory1,n1,p1);
disp('Learned Skin model parameters are');
disp(SkinModelMu);
disp(SkinModelSigma);
disp('End');
LikValuesSkinModel=EvaluateLikelihood(TestImage,SkinModelMu,SkinModelSigma);
figure ;
title('Skin Model')
NormalisedLikValuesSkinModel=LikValuesSkinModel/max(max(LikValuesSkinModel)) ;
imshow(NormalisedLikValuesSkinModel);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Learning Background model

BackgroundDirectory='BackgroundImages/';
%All files from the directory are taken
n= 0 ;
p=1 ;    
[BackgroundMu,BackgroundSigma]=LearnModelParameters(BackgroundDirectory,n,p);

disp('Learned Background model parameters are');
disp(BackgroundMu);
disp(BackgroundSigma);
disp('End');

LikValuesBackgroundModel=EvaluateLikelihood(TestImage,BackgroundMu,BackgroundSigma);
figure ;
NormalisedLikValuesBackgroundModel=LikValuesBackgroundModel/max(max(LikValuesBackgroundModel));
title('Background Model');
imshow(NormalisedLikValuesBackgroundModel);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Likelihood ratio and binary Image
LikelihoodRatio=LikValuesSkinModel ./ LikValuesBackgroundModel ;

binaryImage=zeros(size(LikelihoodRatio,1),size(LikelihoodRatio,2));
[rows,colums]=find(LikelihoodRatio >=1);

for i=1:size(rows,1)    
        binaryImage(rows(i),colums(i)) = 1;
    
end 

imshow(binaryImage);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Face recognition
figure ;
[x,y]=FindBiggestComp(binaryImage);

%Adding first cordinate in the end again so that plot forms a closed
%polygon
x=[x,x(1)];
y=[y,y(1)];
imshow(TestImage);
impixelinfo ;
hold on ;
plot(x,y);







