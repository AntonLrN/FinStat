function x = d1(s,r,K,t,sig)
    t=t;
    x = (log(s./K)+(r-sig.^2/2)*t)/(sig.*sqrt(t));
end