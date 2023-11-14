% Example how to use MLmax

% Estimate parameters in a Gaussian distribution

N=100;
X=2+3*randn(N,1);  % 100 observations, with mean = 2, std dev =3

[xout,lOut,CovM]=MLmax(@lnL,[1 1],X)