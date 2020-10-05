clear; close all; clc;

t = linspace(0, 20, 1000);

r = 25 +  30*(1-exp(sin(0.07 * t)));
theta = 2*pi*(1-exp(-0.2*t));

polarplot(theta, r)