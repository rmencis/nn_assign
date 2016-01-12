clear all;

learning_rate = 0.05;
data_count = 100; % p - number of rows in dataset
dimensions = 3; % N - number of columns in dataset
hidden_unit_count = 2; % w1,w2

% Generate data
data = randn(data_count,dimensions);
teacher_weights = randn(hidden_unit_count,dimensions);
labels = get_nn_output(teacher_weights,data)';

% Set initial student weights to random values
student_weights = randn(hidden_unit_count,dimensions);

t_max = 100;
for i = 1:t_max * data_count
    % Choose random row from data and corresponding label
    data_index = randi(length(data));
    data_value = data(data_index,:);
    target_label = labels(data_index);
    
    % Calculate gradient
    cost_gradient = get_nn_analytic_gradient(student_weights,data_value,target_label);
    %cost_gradient = get_nn_numeric_gradient(student_weights,data_value,target_label);
    
    % Update student weights by going against gradient
    student_weights = student_weights - (learning_rate * cost_gradient);
    total_cost = get_nn_cost(student_weights,data,labels)
end;
