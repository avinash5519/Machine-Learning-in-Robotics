function [ par ] = Exercise1( k )
%To run this function run the main file in the same folder and change the
%value of k from there 


degree=6 ;
data=load('Data.mat');
%output
Output=transpose(data.Output) ;
Input=transpose(data.Input) ;
n=20000 ;

minPositionValidationError=intmax ;
minOrientationValidationError=intmax ;

%Train this set for all polynomial values
for i=1:degree       

    average_position_validation_error=0 ;
    average_orientation_validation_error=0 ;     

    %training is done k times for each polynomial value

    for K=1:k
    
        part_start=1 + (K - 1) * n/k ;
        part_end =   K*n/k ;
    
        %1 of the k sets is used for testing In_test and Out_test
        In_test= Input(part_start:part_end,:);
        Out_test= Output(part_start:part_end,:);
    
        %Other sets are used  for training..Combining all other sets in In_train_total and Out_train_total
        %In_train_after and In_train_before contains data sets after and before training sets
        if(part_end == n)
            
            In_train_after=[] ;
            Out_train_after=[] ;
        else  
            In_train_after= Input(part_end+1:n,:);
            Out_train_after= Output(part_end+1:n,:);
        end

          if(part_start == 1)
            In_train_total=In_train_after;
            Out_train_total= Out_train_after;     
          else
            %set for training before testing set
            In_train_before= Input(1:part_start-1,:);
            Out_train_before= Output(1:part_start-1,:);

            In_train_total=[In_train_before; In_train_after];
            Out_train_total=[Out_train_before; Out_train_after];
          end 

          % training set preapred in In_train_total and Out_train_total
          
        Y= Out_train_total  ;
        v= In_train_total(:,1) ;
        w= In_train_total(:,2) ;
        vw=In_train_total(:,1).*In_train_total(:,2);
        X=[] ;
       
        for l=1:i
            X= [X,v.^l, w.^l, vw.^l] ;
        end 
       X=[ones(size(In_train_total,1),1), X];
       q= X' * Y ;
       r=inv(X' * X) ;
       
       %Weight matrix calculated
       weightMatrix = r*q ;
       
       %Training is done. Validation will start now 
          
       v= In_test(:,1) ;
       w= In_test(:,2) ;
       vw=In_test(:,1).*In_test(:,2);
       X_validation=[];
       for l=1:i
            X_validation=[X_validation, v.^l, w.^l, vw.^l] ;
       end 
       X_validation=[ones(size(In_test,1),1), X_validation] ;
       Y_predicted= X_validation*weightMatrix ;
       no_of_samples_for_testing=size(X_validation,1);
       
       %Total k validation errors will be there for each polynomial value
       position_error_validation=  sum(sqrt((Y_predicted(:,1) - Out_test(:,1)).^2+(Y_predicted(:,2) - Out_test(:,2)).^2 ))/no_of_samples_for_testing ;
       orientation_error_validation= sum(sqrt((Y_predicted(:,3) - Out_test(:,3)).^2))/no_of_samples_for_testing ;
       
       
        %Average validation error for this polynomial
        %Avergae is changed inside the loop. avg_new = (avg_old*(K-1)+new_value)/K)
       average_position_validation_error=(average_position_validation_error*(K-1)+position_error_validation)/K ;
       average_orientation_validation_error=(average_orientation_validation_error*(K-1)+orientation_error_validation)/K ;
    end 
    
   
   %Setting minimum validation position error for this polynomial value
    if(average_position_validation_error < minPositionValidationError)
        minPositionValidationError=average_position_validation_error ;
        selected_position_polynomial=i ; %p1 
        
    end 
    
    %Setting minimum validation orientation error for this polynomial value    
    if(average_orientation_validation_error < minOrientationValidationError)
        minOrientationValidationError=average_orientation_validation_error ;
        selected_orientation_polynomial=i ; %p2   
        
    end 
       
end

        
%Re-estimate model parameters for selected_position_polynomial and selected_orientation_polynomial using entire data set
        v= Input(:,1) ;
        w= Input(:,2) ;
        vw=Input(:,1).*Input(:,2);
        Y=Output ;
        
        X1=[] ;
       
        for l=1:selected_position_polynomial
            X1= [X1,v.^l, w.^l, vw.^l] ;
        end 
        X1=[ones(size(Input,1),1), X1];
       q= X1' * Y ;
       r=inv(X1' * X1) ;
       %Weight matrix calculated using whole data set for polynomial : selected_position_polynomial
       weightMatrixForPosition = r*q ;
              
        disp('Selected Position Polynomial');
        disp(selected_position_polynomial);
        disp('Selected Position Error');
        disp(average_position_validation_error);
        disp('Position Weight Matrix');
        disp(weightMatrixForPosition);
    
       
       %Now calculating Weight matrix using whole data set for polynomial : selected_orientation_polynomial
       
       X2=[] ;
       
       for l=1:selected_orientation_polynomial
            X2= [X2,v.^l, w.^l, vw.^l] ;
        end 
       X2=[ones(size(Input,1),1), X2];
       q= X2' * Y ;
       r=inv(X2' * X2) ;
       weightMatrixForOrientation = r*q ;
       disp('Selected Orientation Polynomial');
       disp(selected_orientation_polynomial);
       disp('Selected Orientation Error');
       disp(average_orientation_validation_error);
       disp('Orientation Weight Matrix');
       disp(weightMatrixForOrientation);
        
        par{1} = weightMatrixForPosition(:,1);
        par{2} = weightMatrixForPosition(:,2);
        par{3} = weightMatrixForOrientation(:,3);
        save('params','par')
end
