function [] = Exercise3_nubs( gesture_data, NumberOfClusters )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

current_means=zeros(NumberOfClusters,3);
if(NumberOfClusters >7 )
    return ;    
end 

%Mean of first cluster, classMatrix has value 1 for all points

current_means(1,:)=[mean2(gesture_data(:,:,1)), mean2(gesture_data(:,:,2)), mean2(gesture_data(:,:,3))];
classMatrix=ones(size(gesture_data,1),size(gesture_data,2));
currentNumberOfClasses= 1 ;

distortionMatrix=calculateDistortion(gesture_data,current_means,classMatrix,currentNumberOfClasses);


for i=1:NumberOfClusters-1
   [r,c]= find (distortionMatrix == max(distortionMatrix));
   classWithHighestDistortion=r;
   [classMatrix]=  binaryDivisionOfClass(classWithHighestDistortion,classMatrix,gesture_data,current_means,currentNumberOfClasses);
   currentNumberOfClasses=currentNumberOfClasses+1 ;
   %Calculate new means
   current_means= updateMeans(classMatrix,currentNumberOfClasses,gesture_data) ;
   
   distortionMatrix=calculateDistortion(gesture_data,current_means,classMatrix,currentNumberOfClasses);
   %drawPlots(classMatrix,currentNumberOfClasses,gesture_data);
end

drawPlots(classMatrix,currentNumberOfClasses,gesture_data);


end 

function[classMatrix] = binaryDivisionOfClass(classNumber,classMatrix,gesture_data,current_means,currentNumberOfClasses)
   
   [rows,columns] = find(classMatrix == classNumber);
   X=[] ;Y=[] ; Z=[] ;
   for i=1:size(rows)
       X=[X;gesture_data(rows(i),columns(i),1)];
       Y=[Y;gesture_data(rows(i),columns(i),2)];
       Z=[Z;gesture_data(rows(i),columns(i),3)];           
   end
   
   data_of_classNumber=[X,Y,Z];
   
   %Calculate eigen vectors of covariance matrix 
   covMatrix=cov(data_of_classNumber);
   [V,D]= eigs(covMatrix,1);
   p_eig_vector = V(:,1)';
     
   c_means=current_means(classNumber,:); 
   center1 = c_means-p_eig_vector;
   center2= c_means+p_eig_vector;
   
   for i=1:size(rows)
       positionNo=rows(i);
       gestureNo=columns(i);
      
       point= [gesture_data(positionNo,gestureNo,1),gesture_data(positionNo,gestureNo,2),gesture_data(positionNo,gestureNo,3)];
       
       dist1=norm((point-center1),2);
       dist2=norm((point-center2),2);
       
       if(dist1 < dist2)
         classMatrix(positionNo,gestureNo)=currentNumberOfClasses+1 ; 
       end 
   end   
   
   
 
      
end 



function[distortionMatrix]= calculateDistortion(gesture_data,current_means,classMatrix,currentNumberOfClasses)

distortionMatrix=zeros(size(current_means,1),1);
for k=1:currentNumberOfClasses  
    [rows,columns] = find(classMatrix == k);
    X=[] ;Y=[] ; Z=[] ;
    for i=1:size(rows)
       X=[X;gesture_data(rows(i),columns(i),1)];
       Y=[Y;gesture_data(rows(i),columns(i),2)];
       Z=[Z;gesture_data(rows(i),columns(i),3)];           
    end
    val=0 ;
    data=[X-current_means(k,1),Y-current_means(k,2),Z-current_means(k,3)];
    for j=1:size(rows)
        val=val+sqrt(data(j,1)*data(j,1)+data(j,2)*data(j,2)+data(j,3)*data(j,3)) ;
    end 
   distortionMatrix(k,1)=val/size(rows,1) ;
end 
        
end   
    
function[]= drawPlots(classMatrix,NumberOfClusters,data)
     figure ;
     colors=['b','k', 'r', 'g', 'm' 'y','c'];
            
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
 


