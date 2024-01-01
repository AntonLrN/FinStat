function [MSE] = AR1(params, data)
global X_est
rng(0)
y_ask = {data.Callask};
y_bid = {data.Callbid};
s_ask = {data.Sask};
s_bid = {data.Sbid};
r = {data.rf};
tau = {data.tau};
K = {data.K};
y_mid = cell(length(y_bid),1);
s_mid = cell(length(y_bid),1);
for i =1:length(y_ask)
    spread = abs(y_ask{:,i} - y_bid{:,i});
    spreads =abs(s_ask{:,i} - s_bid{:,i});
    y_mid{i} = (y_ask{:,i} + y_bid{:,i})/2 +randn([ length(K{i}) 1])'.*spread./4 ;
    s_mid{i} = (s_ask{:,i} + s_bid{:,i})/2 +randn*spreads./4;
end
N=length(tau);
y_mid_mat =  horzcat(y_mid{:});
var_obs=var(y_mid_mat);

obs = y_mid;
s = s_mid;


% disp("The alpha is now:")
alpha = params(1);
process_noise_variance = 0.1; % Process noise variance %Around 2 perhaps
measurement_noise_variance = 0.01;
P = 0.1;
X_est = zeros(1, N);
X=0.1;
total_error = 0;
for t = 1:N
    % Prediction step
    X_pred = alpha * X; % AR(1) state transition
    F = alpha; % Jacobian of the state transition
    P_pred = F * P * F' + process_noise_variance;

    % Update step
    d = length(K{t}); % Number of observations at time t
    Z = y_mid{t}'; % Observations (option prices)
    Z_pred = bns(s{t}, r{t}, K{t}, tau{t}, X_pred)'; % Predicted observations
    H = dbns(s{t}, r{t}, K{t}, tau{t}, X_pred)'; % Jacobian
    R = measurement_noise_variance * eye(d); % Measurement noise covariance

    Y = Z - Z_pred; % Innovation
    S = H * P_pred * H' + R; % Innovation covariance
    Kt = P_pred * H' / S; % Kalman Gain
    X = X_pred + Kt * Y; % Update state
    P = (1 - Kt * H) * P_pred; % Update covariance

    % Store estimates
    X_est(t) = X;
    
    estimated_prices = bns(s{t}, r{t}, K{t}, tau{t}, X_est(t))';
    real_prices = y_mid{t}';
    total_error = total_error + sum((real_prices - estimated_prices).^2);
    
    
end
MSE = total_error/N;
figure(1)
subplot(221)
plot(X_est)
subplot(222)
plot(cell2mat(s))
subplot(223)
plot(cell2mat(tau))

end
