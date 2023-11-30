%prep are chap 8.1, 12, 14 and hand outs. Also look at equation 11.98 and
%11.99
load CIRstruct2.mat
% CIR Model Parameters
r = cir.data'
kappa = cir.a % a
theta = cir.b; % b
sigma = cir.s % sigma
ONV = var(r) % obs noise var, good choice?
% dt, monthly
dt = 1/12;

% init state and cov. 
x_est = r(1); % init state est
P_est = 1;    % error cov

N = length(r);

x_estimates = zeros(N, 1);

% Kalman Filter Implementation
for i = 1:N
    % pred step
    x_pred = x_est + kappa * (theta - x_est) * dt;
    P_pred = P_est + sigma^2 * x_est * dt; 

    % update step
    K = P_pred / (P_pred + ONV); % the gain
    x_est = x_pred + K * (r(i) - x_pred);
    P_est = (1 - K) * P_pred;
    x_estimates(i) = x_est;
end

% plot the stuff
plot(1:N, r, 'b', 1:N, x_estimates, 'r');
legend('Observed', 'Estimated');
xlabel('Time Step');
ylabel('Short Rate');
title('Kalman Filter Estimation of Short Rate');
%%
a= kappa
b=theta
s=sigma
T=1/4
Y = -1/T*(log(A(T,[1:N]', kappa, theta, sigma))-B(T,[1:N]', kappa, sigma).*x_estimates);

%%
plot(1:N, yhat(:,3), 'b', 1:N, Y, 'r');
legend('Observed', 'Estimated');
xlabel('Time Step');
ylabel('Short Rate');
title('Kalman Filter Estimation of Short Rate');

%%
load StochVol.mat
% Model Parameters
kappa0 = -2;
kappa1 = 0.7;
tau = 1;
V=Z
% Observation data (log of squared volatility)
logV2 = log(V.^2);

% Number of data points
N = length(logV2);

% Initialize the state estimate and error covariance
logSigma2_est = 0.1; % Initial state estimate
P_est = 1;    % Initial error covariance

% Allocate memory for storing estimates
logSigma2_estimates = zeros(N, 1);

% Kalman Filter Implementation
for i = 2:N
    % Prediction Step
    logSigma2_pred = kappa0 + kappa1 * logSigma2_est;
    P_pred = P_est + tau^2; % Process noise variance

    % Observation model - Gaussian approximation of noise
    eta = -1.2704
    R = pi^2 / 2; % Observation noise variance

    % Update Step
    K = P_pred / (P_pred + R); % Kalman gain
    logSigma2_est = logSigma2_pred + K * (logV2(i) - logSigma2_pred - eta);
    P_est = (1 - K) * P_pred;

    % Store the estimate
    logSigma2_estimates(i) = logSigma2_est;
end

% Convert log volatility back to volatility for comparison
Sigma2_estimates = exp(logSigma2_estimates);

% Plotting the results
plot(1:N, V.^2, 'b', 1:N, Sigma2_estimates, 'r');
legend('Observed Volatility', 'Estimated Volatility');
xlim([2 1000])
xlabel('Time Step');
ylabel('Volatility');
title('Kalman Filter Estimation of Volatility Process');

