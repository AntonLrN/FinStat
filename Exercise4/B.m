function result = B(x, a, sigma)
    gamma = sqrt(a^2 + 2*sigma^2)
    numerator = 2 * (exp(gamma * x) - 1);
    denominator = (gamma + a) * (exp(gamma * x) - 1) + 2 * gamma;
    result = numerator / denominator;
end