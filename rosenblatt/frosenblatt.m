function [succes_rate] = frosenblatt(P, N, max_epochs, bias)
%FROSENBLATT Summary of this function goes here
%   Detailed explanation goes here

if bias == true
    weights = zeros(N + 1,1);
else
    weights = zeros(N,1);
end

learning_rate = 1/N;
runs = 1000;
successful_linear_separations = 0;

for run = 1:runs
    %create random data
    data = rand(P,N); %create P random datapoints with N dimensions
    labels = sign(rand(P,1)-0.5); %Create random binary labels [-1, 1]

    if bias == true
        data(:,N+1) = ones(P,1); % Add bias column of ones
    end
    
    for epoch = 1:max_epochs
        error_count = 0;
        for point = 1:P
            datapoint = data(point,:);
            label = labels(point);
            pred_label = sign(dot(datapoint,weights));
            E = dot(datapoint,weights)*label; 
            if E <= 0   %incorrect classification 
                weights = weights + learning_rate*datapoint'*label;
                error_count = error_count + 1;
            end         

        end
        if error_count == 0
            successful_linear_separations = successful_linear_separations + 1;
            break;  %no weights updated
        end

    end 

end
succes_rate = successful_linear_separations / runs;
fprintf('Ratio of successful linear separations = %f \n', succes_rate);

end

