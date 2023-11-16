 load garchdata.mat
 %% Seems to have some mean. So we assume r_t = mean + sigma_t*z_t
 % This means that the dist of r_t is, (assuming standard_normal z_t)
 % N(mean, sigma_t^2)
 %a = log_lik_GARCH(0.1,0.1,0.1,8,garchdata);
 start_par = [0.1 0.1 0.1 6]
 MLmax(@log_lik_GARCH, start_par, garchdata);

 %% ARMAX 
 arma_data = garchdata.^2 - mean(garchdata.^2)
 data_ts = iddata(arma_data', [], 1);
 %% How do i estimate the arma params with the w and mu?
 armax(data_ts,[1 1])


 %% EGARCH(1,1)
 start_par = [0 0 0 0 0 ]
 MLmax(@log_lik_EGARCH, start_par, egarchdata);


 %% Extra
 