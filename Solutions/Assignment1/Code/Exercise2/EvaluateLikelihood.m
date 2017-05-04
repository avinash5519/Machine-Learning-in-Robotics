function [ LikValues ] = EvaluateLikelihood( Image, mu, sigma )
%EVALUATELIKELIHOOD Summary of this function goes here
%   Detailed explanation goes here
d= 3;
rows=size(Image,1) ;
columns=size(Image,2);
LikValues = zeros(rows,columns);
for i=1:rows
    for j=1:columns
        ImageRGB(1)=Image(i,j,1) ; 
        ImageRGB(2)=Image(i,j,2) ; 
        ImageRGB(3)=Image(i,j,3) ; 
        %transpose of ImageRGB is done to convert it to 3*1 vector
        LikValues(i,j) = getProbability(transpose(ImageRGB),mu,sigma,d);
    end

end


end 
function[P]=getProbability(X,mu,sigma,d)
    deno=sqrt(((2*pi)^d) * det(sigma));
    sigmaInv=inv(sigma);
    num=exp(-transpose(double(X)-mu)*sigmaInv*(double(X)-mu));
    P=num/deno ;
end 