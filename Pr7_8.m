clear; close all; clc;

fun_W = @(r, d, t, g) g * pi^2 * (2*r +d) * d * t;

W = fun_W(0.35, 0.12, 0.002, 0.696)