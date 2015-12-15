clear all
close all

bias = false;
N = 20;
max_epochs = 200;

n = 1; %index
for P = [5 10 15 20 25 30 35 40 45 50 55 60]
    fprintf('Number of datapoints: %d Number of dimensions: %d Alpha: %f \n', P, N, P/N);
    alpha_rate(n, 1) = P/N; %alpha (P/N)
    alpha_rate(n, 2) = frosenblatt(P, N, max_epochs, bias); %Linear seperation rate
    n = n + 1;
end

plot(alpha_rate(:,1), alpha_rate(:,2));
str = sprintf('N = %d , max-epochs = %d, bias = %d',N, max_epochs, bias);
title(str);
xlabel('alpha (P/N)')
ylabel('Q - succesfull linear seperation rate')

