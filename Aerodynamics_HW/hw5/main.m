clear; close all; clc;

%% DEFINE

%{
In this report, I want to define the angle of stall as 17 degree.
Since it is known that the stalling angle is typically around 15' - 20' for
many airfoils.

Ref: https://en.wikipedia.org/wiki/Angle_of_attack
%}

alpha_stall = deg2rad(20);
theta = deg2rad(45);
omega = 628.318; % 6000 rpm in rad/s
c = 0.02; % m
Vinf = 7; % m/s
dr = 0.01; % m
r = 0.03; %m
AR = 14; % from the reference paper
B1 = 1.11 + 0.018 * AR;
C_D_max = B1;

C_D_stall = 0.1; % What is this value?
C_L_stall = 0.1; % What is this value exactly?

B2 = (C_D_stall - C_D_max * sin(alpha_stall)^2)/cos(alpha_stall);
A1 = B1/2;
A2 = (C_L_stall - C_D_max*sin(alpha_stall)*cos(alpha_stall)) * sin(alpha_stall) / (cos(alpha_stall)^2);
rho = 1.4;
%%

alpha = linspace(0, pi/2, 100);
alpha_in_deg = rad2deg(alpha);
C_D = zeros(1, length(alpha));
C_L = zeros(1, length(alpha));
for i = 1:length(alpha)
    C_D(i) = B1 * sin(alpha(i))^2 + B2 * cos(alpha(i));
    C_L(i) = A1 * sin(2*alpha(i)) + A2 * cos(alpha(i))^2 / sin(alpha(i));
end

figure; plot(alpha_in_deg, C_D)
hold on;
plot(alpha_in_deg, C_L);
% xlim([17, 90])
ylim([0, 1.5])

a = linspace(0, 1, 1000); % for every single a from 0 to 1 ... 

for i = 1:length(a)
    V2 = r * omega;
    
    V_disc = 7 + 7 * a(i);
    V1 = sqrt(V_disc^2 + V2^2);
    phi = atan(V_disc/V2);
    
    alpha2 = theta - phi;
    
    [~,alpha_idx] = min(abs(alpha-alpha2));
    
    dT_prime(i) = 1/2 * rho * V1^2 * c * (C_L(alpha_idx)*cos(phi) - C_D(alpha_idx)* sin(phi)) * dr;
    dT(i) = 4 * pi * r * dr * rho * Vinf^2 * a(i) * (1+a(i));
end


[~, dT_min_idx] = min(abs(dT_prime - dT));

a(dT_min_idx)

dT_prime(dT_min_idx)
dT(dT_min_idx)

%% result

disp(['a should be ',num2str(a(dT_min_idx))]);