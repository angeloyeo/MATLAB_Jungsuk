clear; close all; clc;

N = 10000;
theta = linspace(-20,20,N);

%%
a = [10, 5, 1];
relative_luminance = zeros(3, N);
for i = 1:3
    my_alpha = pi*a(i)*sind(theta);
    relative_luminance(i,:) = (sin(my_alpha)./my_alpha).^2;
end

figure;
clear h
for i =1:3
    hold on;
    h(i) = plot(theta, relative_luminance(i,:));
end

legend(h, 'a=10\lambda', 'a=5\lambda', 'a=\lambda');
