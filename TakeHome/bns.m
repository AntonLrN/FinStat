function x = bns(s,r,K,t,sig)
    % Give s, r, K, t, sig.
    % s and K can be vectors. 
    t=t;

    x1 = s.*normcdf(d1(s,r,K,t,sig) + sig.*sqrt(t));
    x2 = -exp(-r*t)*K.*normcdf(d1(s,r,K,t,sig));
    x = x1 + x2;
end