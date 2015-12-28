clear all;

% Parameters:
n = 10; % Dimensions
learning_rate = 1 / n;
max_epochs = 10000; % nmax
runs = 30; % nD

alphas = 0.1:0.1:5;
avg_generalization_errors = zeros(1,size(alphas,2));
for counter = 1:size(alphas,2)
    alpha = alphas(counter);
    p = round(alpha * n); % Number of data points
    
    generalization_error_sum = 0;
    for run = 1:runs
        % Generate random data, teacher weights and calculate labels
        data = randn(p,n);
        teacher_w = randn(1,n);
        labels = sign(teacher_w * data');

        % Initialize random student weights
        student_w = randn(1,n);

        for epoch = 1:max_epochs
            % Calculate stabilities for all data points (distances from decision plane)
            stabilities = ((student_w * data') .* labels) / norm(student_w);
            % Find minimum stability example (closest to decision plane)
            [min_stability_value, min_stability_index] = min(stabilities);
            min_stability_example = data(min_stability_index,:);
            min_stability_label = labels(min_stability_index);
            % Update weights
            delta_w = learning_rate * min_stability_example * min_stability_label;
            student_w = student_w + delta_w;
        end
        % Determines the so-called learning curve, i.e. the generalization error
        generalization_error = (1/pi) * acos((student_w*teacher_w') / (norm(student_w)*norm(teacher_w)));
        generalization_error_sum = generalization_error_sum + generalization_error;
    end
    avg_generalization_error = generalization_error_sum / runs;
    avg_generalization_errors(counter) = avg_generalization_error;
    disp(sprintf('Alpha %f, data points %d, average generalization error %f',alpha,p,avg_generalization_error));
end

% Plot learning curve

plot(alphas,avg_generalization_errors);
xlabel('Alpha (P/N)')
ylabel('Generalization error')
