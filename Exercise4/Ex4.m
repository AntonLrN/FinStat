%prep are chap 8.1, 12, 14 and hand outs. Also look at equation 11.98 and
%11.99
load CIRstruct2.mat
% CIR Model Parameters
r = cir.data
kappa = cir.a % Speed of mean reversion
theta = cir.b; % Long-term mean
sigma = cir.s % Volatility
ONV = var(r)
% Time step (assumed constant for simplicity)
dt = 1/12;

% Initialize the state estimate and error covariance matrix
x_est = r(1); % Initial state estimate (could be the first observation)
P_est = 1;    % Initial error covariance

% Number of observations
N = length(r);

% Allocate memory for storing estimates
x_estimates = zeros(N, 1);

% Kalman Filter Implementation
for i = 1:N
    % Prediction Step
    x_pred = x_est + kappa * (theta - x_est) * dt;
    P_pred = P_est + sigma^2 * x_est * dt; % Approximate process noise

    % Update Step
    K = P_pred / (P_pred + ONV); % Kalman gain (assuming observation noise variance = 1)
    x_est = x_pred + K * (r(i) - x_pred);
    P_est = (1 - K) * P_pred;

    % Store the estimate
    x_estimates(i) = x_est;
end

% Plotting the results
plot(1:N, r, 'b', 1:N, x_estimates, 'r');
legend('Observed', 'Estimated');
xlabel('Time Step');
ylabel('Short Rate');
title('Kalman Filter Estimation of Short Rate');
%%
Y3 = 0.25 *(log(A(x_estimates, kappa, theta, sigma))-B(x_estimates, kappa, sigma)*x_estimates);

%%
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

