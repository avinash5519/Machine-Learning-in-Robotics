close all ;
clear ;

MotionData=load('gesture_dataset.mat');
NumberOfClusters=7 ;

%%Using K-Means
   InitialClusterLabels=MotionData.init_cluster_o;
   Gestures_Data=MotionData.gesture_o;
   Exercise3_kmeans(Gestures_Data,InitialClusterLabels, NumberOfClusters);
   
   InitialClusterLabels=MotionData.init_cluster_l;
   Gestures_Data=MotionData.gesture_l;
   Exercise3_kmeans(Gestures_Data,InitialClusterLabels, NumberOfClusters);
   
   InitialClusterLabels=MotionData.init_cluster_x;
   Gestures_Data=MotionData.gesture_x;
   Exercise3_kmeans(Gestures_Data,InitialClusterLabels, NumberOfClusters);


 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 %Using Non Uniform Binary Split 
   Gestures_Data=MotionData.gesture_o;
   Exercise3_nubs(Gestures_Data, NumberOfClusters);
   
   Gestures_Data=MotionData.gesture_l;
   Exercise3_nubs(Gestures_Data, NumberOfClusters);
    
   Gestures_Data=MotionData.gesture_x;
   Exercise3_nubs(Gestures_Data, NumberOfClusters);