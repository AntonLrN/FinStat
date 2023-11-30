function result = B(T,t, a, sigma)
    x=T-t
    gamma = sqrt(a^2 + 2*sigma^2)
    numerator = 2 * (exp(gamma * x) - 1);
    denominator = (gamma + a) * (exp(gamma * x) - 1) + 2 * gamma;
    result = numerator ./ denominator;
end