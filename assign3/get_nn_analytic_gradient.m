function gradient = get_nn_analytic_gradient( weights,data_value,target_label )
    output = get_nn_output(weights,data_value);
    gradient = (output - target_label) * (1 - tanh(weights*data_value').^2) * data_value;
end

