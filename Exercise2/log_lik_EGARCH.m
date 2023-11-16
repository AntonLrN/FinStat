function [l] = log_lik_EGARCH(params, data)
    w = params(1);
    a = params(2);
    b = params(3);
    c = params(4);
    mu = params(5)
    data = data';
    %Create a starting value 
    log_sigma_2 = zeros(length(data),1);
    %Just some starting value, unsure if important. 
    %Since rt = mu + w_t * sigma*t, we can basically just solve for wt, starting with 
    % subtracting mu from our data:
    data_n = data - mu;
    for i = 2:length(log_sigma_2);
        %We need to start off with calculating the resid
        z = data_n(i-1)/sqrt(exp(log_sigma_2(i-1)));
        log_sigma_2(i) = w + b*log_sigma_2(i-1) + a*(abs(z)-c*z);
    end
    sigma_2 = exp(log_sigma_2);
    l = -0.5*(log(2*pi) + (data_n).^2./(sigma_2) + log(sigma_2));

end