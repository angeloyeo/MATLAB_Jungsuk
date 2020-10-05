clear; close all; clc;

x1 =10;
y1 = 5.4;

x2 = 2;
y2 = 8.6;

x3 = -4;
y3 = -7;

%%

A = 2 * [...
    (x1-x2), (y1-y2); 
    (x2-x3), (y2-y3)];
b = [(x1^2+y1^2)-(x2^2+y2^2); (x2^2 + y2^2)-(x3^2 +y3^2)];

c = A\b;

r = sqrt(sum(...
    (c-[x1; y1]).^2)...
    );

%% 체크
figure;
plot(x1, y1, 'ro'); hold on;
plot(x2, y2, 'ro');
plot(x3, y3, 'ro');

theta = linspace(0, 2*pi, 100);
x = r * cos(theta) + c(1);
y = r * sin(theta) + c(2);

plot(x, y)