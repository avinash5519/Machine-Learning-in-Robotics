%[testing_data_input,testing_data_output,training_data_input,training_data_output]
function[pos,ori,weight]  = splitData(input,output,valuek,n,degree)
%n is the number of columns i.e 20,000
%valuek is no n/k i.e for 5 splits 4000 etc
pos = [];
ori = [];
posreal = [];
for i = 1:valuek:n
    
    
    testing_data_input =  input(:,i:i+valuek-1);
    testing_data_output = output(:,i:i+valuek-1);
    training_data_input = input(:,i+valuek:n);
    training_data_output =output(:,i+valuek:n);
    
    if i~=1
        training_data_input = [input(:,1:i-1),training_data_input];
        training_data_output =  [output(:,1:i-1),training_data_output];
    end
    
    
    
    
[p,o,weight]=    predict(testing_data_input,testing_data_output,training_data_input,training_data_output,degree);


pos = [pos,p];
ori = [ori,o];   
  
end    
   
   

 
    
    
    
    
    
    
    
end
