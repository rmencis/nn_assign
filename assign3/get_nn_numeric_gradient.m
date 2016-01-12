% Calculate gradient numerically by changing each weight a little bit
function gradient = get_nn_numeric_gradient( weights,data_value,target_label )
    delta = 0.00001;
    gradient = zeros(size(weights));
    for i = 1:numel(weights)
        weights_tmp = weights;
        cost0 = get_nn_cost(weights_tmp,data_value,target_label);
        weights_tmp(i) = weights_tmp(i) + delta; % Change i-th weight
        cost1 = get_nn_cost(weights_tmp,data_value,target_label);
        cost_delta = cost1 - cost0;
        gradient(i) = cost_delta / delta;
    end
end

