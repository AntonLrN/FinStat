function [l] = log_lik_GARCH(params, data)
    a0 = params(1);
    a1 = params(2);
    b1 = params(3);
    mu = params(4);
    data = data';
    %Create a starting value 
    sigma_2 = zeros(length(data),1);
    sigma_2(1) = 0.2;
    for i = 2:length(sigma_2);
        sigma_2(i) = a0 + a1*(data(i-1)-mu)^2 + b1*sigma_2(i-1);
    end
    l = -0.5*(log(2*pi) + (data - mu).^2./(sigma_2) + log(sigma_2));

end
