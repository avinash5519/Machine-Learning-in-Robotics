function [ mus,sigmas,pis,sizeOfClusters ] = initialiseParameters( input,k )
%INITIALISEPARAMETERS Summary of this function goes here
%   Detailed explanation goes here

total_data=size(input,1);
idx=kmeans(input,k);
mus=zeros(k,2);
sigmas={};
sizeOfClusters=zeros(k,1);
pis=zeros(k,1);

figure ;
colors = ['o', '+', '*', 's'];
hold on ;
for i=1:k
   [indexes_in_ith_clusters]= find(idx == i);
   X=input(indexes_in_ith_clusters,:);
   mus(i,:)=mean(X);
   sigmas{i}=cov(X);
   total_elements_ith_cluster=size(indexes_in_ith_clusters,1);
   sizeOfClusters(i,1)=total_elements_ith_cluster ;
   pis(i)=(total_elements_ith_cluster/total_data); 
   scatter(X(:,1),X(:,2),colors(i));
   
end 


end

