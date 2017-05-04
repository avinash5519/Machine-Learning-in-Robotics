load('data1.mat');
points=Data(2:3,:)' ;
k=4 ;
[mus,sigmas,pis,sizeOfClusters]=initialiseParameters(points,k);
mus 
sigmas
pis



%EStep
%Calculate Responsibilities

totalDataPoints=size(points,1) ;
responsMap=zeros(totalDataPoints,k);

diff=10.0^-3 ;
previousLogLikelihood=0 ;
currentloglikeli=1 ;

while(currentloglikeli > previousLogLikelihood && currentloglikeli-previousLogLikelihood > diff)   

for j=1:k
    for i=1:totalDataPoints
        sum1=0 ;
        for l=1:k
         a=pis(l) * pdfForMvg(mus(l,:),sigmas{l},points(i,:));  
         sum1=sum1+a ;
        end
        b=(pis(j) * pdfForMvg(mus(j,:),sigmas{j},points(i,:))) ;
        responsMap(i,j)=  b/sum1;
    end 
end 


for j=1:k
    %M-Step
    nk=sum(responsMap(:,j)) ;
    nk 
    s1=0 ;
    s2=[0,0; 0,0] ;
    for i=1:totalDataPoints
       s1=s1+responsMap(i,j)* points(i,:);
       s2=s2+responsMap(i,j)* (points(i,:) -  mus(j,:))' * (points(i,:) -  mus(j,:));
    end 
    
    mus(j,:)=(1/nk)*s1;
    sigmas{j}=(1/nk)*s2 ;
    pis(j)=nk/totalDataPoints ;
end 

%Calculate Likelihood


previousLogLikelihood=currentloglikeli ;
currentloglikeli=0 ;

for i=1:totalDataPoints   
    likeli=0 ;
    for j=1:k
      likeli=likeli+ pis(j)*pdfForMvg(mus(j,:),sigmas{j},points(i,:)) ;      
    end 
   currentloglikeli=currentloglikeli+log(likeli);
end 
   
%previousLikelihood
%currentlikeli

previousLogLikelihood
currentloglikeli

end 


mus
sigmas{1}
sigmas{2}
sigmas{3}
sigmas{4}
pis



