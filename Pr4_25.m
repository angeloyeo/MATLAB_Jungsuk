clear; close all; clc;

x = [0.15, 0.35, 0.5, 0.7, 0.85];

x = x';

A = [sqrt(x) x x.^2 x.^3 x.^4];
b = [0.08909; 0.09914; 0.08823; 0.06107; 0.03421];

a = A\b;

xx = linspace(0,1,100);
yy1 = a(1) * sqrt(xx) + a(2) * xx + a(3) * xx.^2 + a(4) * xx.^3 + a(5) * xx.^4;

h1 = plot(xx, yy1);
hold on;
h2 = plot(xx, -yy1);
h3 = plot(xx, -2 * yy1);

legend([h1, h3],'1번 그래프','3번 그래프')
