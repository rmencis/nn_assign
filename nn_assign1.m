clear all;

% Control data (for non-homogenous case):
% http://www.cems.uvm.edu/~rsnapp/teaching/cs256/lectures/capacity.pdf

% Parameters:
n = 20; % Dimensions
p = 3*n; % Number of data points
bias_x = 0; % Include bias column
max_epochs = 1000; % nmax
learning_rate = 1/n;
runs = 1000; % nD
alpha = p / n;

disp(sprintf('alpha = %f',alpha));

successful_linear_separations = 0;
for run = 1:runs
    % Generate data
    data = randn(p,n);
    if bias_x == 1
        data(:,n+1) = ones(p,1); % Add bias column of ones
    end
    labels = sign(rand(p,1)-0.5);

    % Test data
    %data = [1 3; 0 1; 1 0; 0 -2; 2 -2];
    %labels = [-1 -1 1 1 1]';
    %data = [-1 4; -1 -4; 1 4; 1 -4; 0 1];
    %labels = [-1 -1 1 1 1]';

    % Init weights
    weights = zeros(n+bias_x,1);

    % Find weights
    for epoch = 1:max_epochs
        error_count = 0;
        for t = 1:size(data,1)
            data_item = data(t,:)';
            label = labels(t,1);
            weight_sum = weights' * data_item;
            predicted_label = sign(weight_sum);
            if (label ~= predicted_label)
                error_count = error_count + 1;
                weights = weights + (learning_rate * data_item * label);
            end
        end
        if error_count == 0
            successful_linear_separations = successful_linear_separations + 1;
            break;
        end
    end
end

disp(sprintf('Empirical ratio of successful linear separations = %f',successful_linear_separations / runs)); % Q
disp(sprintf('Theoretical ratio of successful linear separations = %f',lin_sep_count(p,n) / 2^p)); % C(P+1,N) = C(P,N)+C(P,N-1)

