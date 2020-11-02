clear; close all; clc;

%% 

A = [1, 2];
B = [10, 3];
C = [6, 11];

cirtriangle(A, B, C)

plot(A(1), A(2),'o');
hold on;
plot(B(1), B(2),'o');
plot(C(1), C(2),'o');

%%

A = [-1.5, -4.2, -3];
B = [-5.1, 6.3, 2];
C = [12.1, 0. -0.5];

cirtriangle(A,  B, C)