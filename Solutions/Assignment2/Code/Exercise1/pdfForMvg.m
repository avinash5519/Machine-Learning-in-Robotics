function [ prob ] = pdfForMvg( mean, covariance, X)
%PDFFORMVG Summary of this function goes here
%   Detailed explanation goes here
prob=exp(-1/2*(X-mean)* inv(covariance)*(X-mean)')/sqrt((2*pi)^2*det(covariance)) ;
end

