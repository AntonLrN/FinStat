function [l] = log_lik_GARCH(params, data)
    a0 = params(1);
    a1 = params(2);
    b1 = params(3);
    mu = params(4);
    data = data';
    %Create a starting value 
    sigma = zeros(length(data),1);
    sigma(1) = 0.2;
    for i = 2:length(sigma);
        sigma(i) = a0 + a1*(data(i-1)-mu)^2 + b1*sigma(i-1);
    end
    l = -log(sqrt(2*pi)) - (data - mu).^2./(2*sigma) - 0.5*log(sigma);

end
