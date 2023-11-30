function result = A(T,t, a, b, sigma)
    x=T-t
    gamma = sqrt(a^2 + 2*sigma^2);
    numerator = (2 * gamma * exp((a + gamma) * (x/ 2)));
    denom =  ((gamma + a) * (exp(gamma * x) - 1) + 2 * gamma);
    exponent = (2 * a * b) / (sigma^2);
    result = (numerator./denom).^exponent;
end
