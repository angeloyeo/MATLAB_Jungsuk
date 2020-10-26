clear; close all; clc;

theta=  linspace(-3*pi/2, 3*pi/2, 100);
cp = 1-4*sin(theta).^2;

plot(theta, cp);

set(gca,'xtick',-3*pi/2:pi/2:3*pi/2)
set(gca,'xticklabel',{'-^{3\pi}/_{2}','-\pi','-^{\pi}/_{2}','0','^{\pi}/_{2}','\pi','^{3\pi}/_{2}'})
set(gca,'fontsize',15)
grid on;