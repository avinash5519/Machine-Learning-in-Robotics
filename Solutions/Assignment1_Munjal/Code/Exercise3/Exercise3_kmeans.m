function [ output_args ] = Exercise3_kmeans( gestures_Data,InitialClusterLabels, NumberOfClusters )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


current_means=InitialClusterLabels;
previous_means=zeros(size(InitialClusterLabels,1),size(InitialClusterLabels,2));
zeroMatrix= zeros(size(InitialClusterLabels,1),size(InitialClusterLabels,2));

if(NumberOfClusters >7 )
    return ;    
end 
    
minErrorAllowed=10 ^ -6;
current_total_error=intmax  ;
noOfPositions=size(gestures_Data,1);
noOfgestures=size(gestures_Data,2);
current_distortion=0 ;

classMatrix =zeros(noOfPositions, noOfgestures);
minDistanceMatrx= zeros(noOfPositions,noOfgestures); 
count =0 ;



% while(isequal(current_means-previous_means,zeroMatrix) == 0)
while (current_total_error > minErrorAllowed)
    count=count+1 ;
    for i=1:noOfPositions       
        for j=1:noOfgestures
          val=gestures_Data(i,j,:) ;
          gesture_position=  reshape(val,1,3);
          dmin=intmax ;
          for k=1:NumberOfClusters         
              diff= gesture_position- current_means(k,:) ;
              d_current=norm(diff,2);
              if(d_current < dmin)
                 dmin=d_current ;  
                 classMatrix(i,j)= k ;
                 minDistanceMatrx(i,j)=dmin ; %only for debugging
             end         
          end           
        end       
   end
  previous_means=current_means ;
  current_means= updateMeans(classMatrix,NumberOfClusters,gestures_Data);
  
  if(count ~= 1)
    last_distortion=current_distortion ; 
  end 
  
  current_distortion=calculateTotalDistortion(classMatrix,current_means, gestures_Data,NumberOfClusters);      
  
  if(count ~= 1)
     current_total_error= abs(last_distortion-current_distortion) ;
  end
  
end
  display_string = ['Iteration: ',num2str(count),' Diff Distortion :',num2str(current_total_error)];
  disp(display_string);
  drawPlots(classMatrix,NumberOfClusters,gestures_Data,current_means);
  
end
  


 

function[]= drawPlots(classMatrix,NumberOfClusters,data,m)
   figure ;
   % hold on ;   
   colors=['b','k', 'r', 'g', 'm' 'y','c'] ;
            
 for i=1:NumberOfClusters
            [r,c]= find(classMatrix ==i); 
             X=[] ; Y=[] ; Z=[] ;
            for k=1:size(r,1)
                X=[X;data(r(k),c(k),1)];
                Y=[Y;data(r(k),c(k),2)];
                Z=[Z;data(r(k),c(k),3)];
            end 
            
              scatter(X,Y,colors(i),'filled'); hold on ;  
             
end

    
end 
 
function [New_Means]= updateMeans(classMatrix,NumberOfClusters,gestures_Data)      
    for k=1:NumberOfClusters
       [rows,columns]= find(classMatrix == k); %positons with ith cluster ;
       if(size(rows,1) == 0)
           continue ;
       end 
       X=[] ; Y=[] ;Z=[] ;
       for i=1:size(rows,1)
         X= [X;gestures_Data(rows(i),columns(i),1)];
         Y=[Y; gestures_Data(rows(i),columns(i),2)];
         Z=[Z;gestures_Data(rows(i),columns(i),3)];  
       end 
         New_Means(k,1)=mean(X) ;
         New_Means(k,2)=mean(Y);
         New_Means(k,3)=mean(Z);
      
    end

end  

function [TotalDistortion]= calculateTotalDistortion(classMatrix,current_means,gestures_Data,NumberOfClusters)
    TotalDistortion=0 ;
    for k=1:NumberOfClusters
       [r,c,p]= find(classMatrix == k); 
       X=[] ;Y=[] ;Z=[] ;
       
       for k=1:size(r,1)
          X=[X; gestures_Data(r(k),c(k),1)];
          Y=[Y; gestures_Data(r(k),c(k),2)];
          Z=[Z;gestures_Data(r(k),c(k),3)];
       end
       %m=[mean(X),mean(Y),mean(Z)];
       data=[X,Y,Z];
       diff=[X-mean(X), Y-mean(Y), Z-mean(Z)];
      
       for i=1:size(data,1)
           TotalDistortion=TotalDistortion+norm(diff(i,:)) ;
       end 
    
    end          
end 