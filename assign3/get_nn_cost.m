function cost = get_nn_cost( weights,data,target_labels )
    predicted_label = get_nn_output(weights,data)';
    cost = mean(1/2 * (predicted_label - target_labels).^2);
end

