clc
clear
close all
load('data3.mat')

%set parameters
learning_rate = 0.05;
p = 500; %number of points to train on
Q = p;      %distance to determine generalization error
determine_error = true;
determine_generalization_error = true;
plot_weights = true;

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
    
    %determine gradient
    gradient_1 = (predicted_label - actual_label) * (1 - tanh(dot(input, weight_1)).^2) * input;
    gradient_2 = (predicted_label - actual_label) * (1 - tanh(dot(input, weight_2)).^2) * input;
    %update weights
    weight_1 = weight_1 - (learning_rate * gradient_1);
    weight_2 = weight_2 - (learning_rate * gradient_2);
    
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
        for i = (1+Q):(p+Q)
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
    figure();
    plot(error);
    title('cost function');
    hold on
    plot(generalization_error, 'r');
    xlabel('iteration');
    ylabel('error');
    legend('error','generalization error');
end

if plot_weights == true
    figure();
    bar(weight_1);
    xlim([0 n_dimensions+1]);
    title('Weight 1');
    xlabel('j');
    ylabel('\omega_j-value');
    figure();
    bar(weight_2);
    xlim([0 n_dimensions+1]);
    title('Weight 2');
    xlabel('j');
    ylabel('\omega_j-value');
end
