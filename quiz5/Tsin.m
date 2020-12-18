function res = Tsin(x, n)

x = deg2rad(x);

temp = 0;
for k = 0:n
    
    temp = temp+(-1)^k*x^(2*k+1)/factorial(2*k+1);
end

res = temp;