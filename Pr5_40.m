clear; close all; clc;
N = 100;
x = linspace(-2*pi, 2*pi, N);

my_taylor = zeros(3, N);

ns = [2, 4, 6];

for i = 1:length(ns)
    n = ns(i);
    for k = 0:n-1
        my_taylor(i,:) = my_taylor(i,:) + (-1)^(k)*x.^(2*k)/factorial(2*k);
    end
end

figure;
hold on;
clear h
for i = 1:length(ns)
    h(i) = plot(x, my_taylor(i,:));
end

h(4) = plot(x, cos(x));

ylim([-2, 2]);
grid on;
legend(h, 'Two terms','Four terms','Six terms','cos(x)');
