function [x] = dbns(s,r,K,t,sig)


    x1 = d1(s,r,K,t,sig) + sig.*sqrt(t);
    x = s*normpdf(x1)*sqrt(t);
    % x = -s/sqrt(2*pi)*exp(-0.5*x1.^2).*x1*sqrt(t);
    % x=normpdfnorm
end