clear; close all; clc;

sigma = 12000;
h = 5;
b = 4;
a = 1.5;

K = sigma * sqrt(pi * a) * (...
    (1-a/(2*b) + 0.326 * (a/b)^2) / ...
    sqrt(1-a/b))