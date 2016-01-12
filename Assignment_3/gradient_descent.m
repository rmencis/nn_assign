clc
clear
close all
load('data3.mat')

%set parameters
learning_rate = 0.05;
p = 400; %number of points to train on
determine_error = true;
determine_generalization_error = true;

n_dimensions = size(xi,1);
n_datapoints = size(xi,2);

%initialize weights: independent random vectors with |w|^2 = 1
weight_1 = rand(n_dimensions,1);
weight_1 = weight_1/norm(weight_1); %correct?
weight_2 = rand(n_dimensions,1);
weight_2 = weight_2/norm(weight_2); %correct?


random_order = randperm(p);
iter = 1;
for n = random_order
    %determine error
    input = xi(:,n);
    predicted_label = tanh(dot(input, weight_1)) + tanh(dot(input, weight_2));
    actual_label = tau(n);
    error_contribution = ((predicted_label - actual_label)^2)/2;
    
    %update weights
    weight_1 = weight_1 - learning_rate .* weight_1 .* error_contribution;
    weight_2 = weight_2 - learning_rate .* weight_2 .* error_contribution;
    
    %determine overall error (cost-function)
    if determine_error == true        
        error(iter) = 0;
        for i = 1:p
            input = xi(:,i);
            predicted_label = tanh(dot(input, weight_1)) + tanh(dot(input, weight_2));
            actual_label = tau(i);
            error(iter) = error(iter) + (predicted_label - actual_label)^2;
        end    
        error(iter) = (1/p)*(1/2)*error(iter);
    end
    
    %generalization error
    if determine_generalization_error == true
        generalization_error(iter) = 0;
        Q = 100;
        for i = 1:p
            i = i + Q;
            input = xi(:,i);
            predicted_label = tanh(dot(input, weight_1)) + tanh(dot(input, weight_2));
            actual_label = tau(i);
            generalization_error(iter) = generalization_error(iter) + (predicted_label - actual_label)^2;
        end    
        generalization_error(iter) = (1/p)*(1/2)*generalization_error(iter);
    end
        
    iter = iter + 1;
    disp(iter);
end

if determine_error == true || determine_generalization_error == true
    plot(error);
    hold on
    plot(generalization_error, 'r');
    xlabel('iteration');
    ylabel('error');
    legend('error','generalization error');
end



