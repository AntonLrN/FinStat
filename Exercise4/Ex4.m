
%%
kappa0 = -2;
kappa1 = 0.7;
tau = 1;
eta = -(log(2) + 0.5772);
variance = pi^2 / 2;



% ladda data
load('StochVol.mat'); 
data = Z

n = length(data);
log_sigma2 = zeros(n, 1); % log(sigma^2)
log_sigma2(1) = kappa0; % init cond

%  kal init
Q = tau^2; % process noise variance
R = variance; % meas noise variance
P = 1; % init estimate of state covariance

for t = 2:n
    % pred step
    log_sigma2_pred = kappa0 + kappa1 * log_sigma2(t-1);
    P_pred = kappa1^2 * P + Q; %

    % update step
    z_t = data(t); % measurement at time t
    log_z2_t = log(z_t^2); % log(z^2_t)
    y = log_z2_t - log_sigma2_pred; % meas innov
    S = P_pred + R; % innov cov
    K = P_pred / S; % Kal gain
    log_sigma2(t) = log_sigma2_pred + K * (y-eta); % updated state estimate
    P = (1 - K) * P_pred; % updated estimate of state covariance
end
mean(log_z2_t)
% 
plot(log_sigma2);
hold on
plot(V)
hold off
xlabel('time');
ylabel('log(sigma^2)');
title('estimated volatility process');
