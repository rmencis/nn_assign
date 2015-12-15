clear all;

% Parameters:
n = 5; % Dimensions
p = 100*n; % Number of data points
learning_rate = 1/n;
alpha = p / n;
max_epochs = 10000; % nmax

% Generate random data, teacher weights and calculate labels
data = randn(p,n);
teacher_w = randn(1,n);
labels = sign(teacher_w * data');

% Initialize random student weights
student_w = randn(1,n);

prev_student_w = student_w;
for epoch = 1:max_epochs
    % Calculate stabilities for all data points (distances from decision plane)
    stabilities = ((student_w * data') .* labels) / norm(student_w);
    % Find minimum stability example (closest to decision plane)
    [min_stability_value, min_stability_index] = min(stabilities);
    min_stability_example = data(min_stability_index,:);
    min_stability_label = labels(min_stability_index);
    % Update weights
    delta_w = learning_rate * min_stability_example * min_stability_label;
    prev_student_w = student_w;
    student_w = student_w + delta_w;
    % Make prediction and calculate accuracy
    predicted_labels = sign(student_w * data');
    accuracy = sum(predicted_labels == labels) / p;
    % Has student weights changed much?
    cos_similarity = (prev_student_w*student_w')/(norm(prev_student_w)*norm(student_w));
    disp(sprintf('Epoch %d, accuracy %f, min stability %f, prev. weight similarity %f',epoch,accuracy,min_stability_value,cos_similarity));
    if accuracy == 1 & cos_similarity > 0.9999
        break;
    end
end
