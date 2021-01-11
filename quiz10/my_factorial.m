function res = my_factorial(n)

if n<=1
    res = 1;
else
    res = n * my_factorial(n-1);
end
