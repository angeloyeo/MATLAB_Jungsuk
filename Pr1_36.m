clear; close all; clc;

%% k�� ���
t = 1;
Ts = 20;
T0 = 26.4;
T = 25.5;

k = -1/t * log((T-Ts)/(T0-Ts));

%% ��� �� ��� �ð� ���

T0 = 37;
T = 26.4;

t_passed = -1/k * log((T-Ts)/(T0-Ts));

%% ��� �ð� ���

t_arrival = 9 + 18/60;
t_death = t_arrival - t_passed;

PM_hour_of_death = floor(t_death)
PM_min_of_death = round(60 * (t_death - floor(t_death)))

% solution�� �ִ� ����� ����� �ٸ�.