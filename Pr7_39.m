clear; close all; clc;

%% a)

[xr, yr] = rotation(6.5, 2.1, 25);

figure;
plot(6.5, 2.1,'o');
hold on;
plot(xr, yr,'o')

xlim([0,7])
ylim(xlim)

%% b)

x = linspace(5, 9, 100);
y = (x-7).^2 + 1.5;

[x_new, y_new] = rotation(x, y, 25);

figure;
plot(x, y,'linewidth',2);
hold on;
plot(x_new, y_new,'linewidth',2);
xlim([0, 10])
ylim(xlim)
grid on;
