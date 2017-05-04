A = load('Data.mat')
input = A.Input;
output = A.Output;
degree = 6;
par  = {}
[m,n] = size(input);
k=5;
valuek =n/k;
final_position = [];
final_orientation = [];
pos1 = [];
for g = 1:degree
[pos,ori,weight] = splitData(input,output,valuek,n,g);
final_position = [final_position;pos];
final_orientation = [final_orientation;ori];

weight;
final_position_sum(g)  = sum(final_position(g,:))/degree;
final_orientation_sum(g) = sum(final_orientation(g,:))/degree;
 
% for display
if g == degree
    final_position;
    final_orientation;
    final_position_sum
    final_orientation_sum
end
end

display(sprintf('Minimum position error at degree %d',find(final_position_sum == min(final_position_sum))  ))
display(sprintf('Minimum orientation error at degree %d',find(final_orientation_sum == min(final_orientation_sum))  ))

[pos,ori,weight] = splitData(input,output,valuek,n,find(final_position_sum == min(final_position_sum)));
fw=weight
fps=sum(pos)/find(final_position_sum == min(final_position_sum))
fp0=sum(ori)/find(final_orientation_sum == min(final_orientation_sum))
par{1} = weight(:,1);
%par{1} = par{1}'
par{2} = weight(:,2);
%par{2} = par{2}'
par{3} = weight(:,3);
%par{3} = par{3}'
save('params','par')

%Simulate_robot(0.5, -0.03);
Simulate_robot(0,0.05);

Simulate_robot(1,0);

Simulate_robot(1,0.05);

Simulate_robot(-1,-0.05);
%testing_data_input
%testing_data_output
%training_data_input
%training_data_output
