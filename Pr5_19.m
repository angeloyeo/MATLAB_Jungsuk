clear; close all; clc;

e = 0.885 * 10^(-12);
Q = 9.4 * 10^(-6);
q = 2.4 * 10^(-5);
R = 0.1;

z = linspace(0, 0.3, 100);

F = Q*q*z./(2 * e) .* (1 - z./(sqrt(z.^2 + R^2)));

figure;
plot(z, F);

%%

[~, max_ind] = max(F);
z(max_ind) % F가 max일 때의 거리