function value = get_nn_output( weights, data_value )
    value = sum(tanh(weights*data_value'));
    %value = tanh(weights(1)*data_value) + tanh(weights(2)*data_value);
end

