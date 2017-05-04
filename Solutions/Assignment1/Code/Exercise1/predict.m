function[position_error,orientation_error,weight] = predict(testing_data_input,testing_data_output,training_data_input,training_data_output,degree)
%training data

v_training_input = training_data_input(1,:);
w_training_input = training_data_input(2,:);

v_testing_input = testing_data_input(1,:);
w_testing_input = testing_data_input(2,:);
[m,n] = size(training_data_input);
v_training_input = v_training_input.';
w_training_input = w_training_input.';
inp = [v_training_input,w_training_input];
out = training_data_output;
out = out.';
z = [];
for j = 1:degree
    
    z = [z,v_training_input.^j,w_training_input.^j,v_training_input.^j.*w_training_input.^j];

end

z = [ones(n,1),z];
beta = inv(z.'*z)*z.';
value = beta * out;
weight = value;

% testing
[m1,n1] = size(testing_data_input);
z1 = [];
v_testing_input = v_testing_input.';
w_testing_input = w_testing_input.';
for j = 1:degree
 z1 = [z1,v_testing_input.^j,w_testing_input.^j,v_testing_input.^j.*w_testing_input.^j];

end

z1 = [ones(n1,1),z1];



predicted_value = weight.'*z1.';





my_x = (testing_data_output(1,:) - predicted_value(1,:)).^2;
my_y = (testing_data_output(2,:) - predicted_value(2,:)).^2;
my_theta = (testing_data_output(3,:) - predicted_value(3,:)).^2;
position_error = sqrt((my_x)+(my_y));
position_error = sum(position_error);
position_error = position_error/n1;
orientation_error = sum(sqrt(my_theta))/n1;






end