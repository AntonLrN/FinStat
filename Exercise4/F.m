function result = F(T,t, r, a, b, s)
   result = A(T-t, a, b, s)*exp(-B(T-t,a ,s)*r(t))
end