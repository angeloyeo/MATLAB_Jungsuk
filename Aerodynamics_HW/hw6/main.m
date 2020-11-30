clear; close all; clc;

%% DEFINE
theta = deg2rad(45);
omega = 628.318; % 6000 rpm in rad/s
c = 0.02; % m
Vinf = 7; % m/s
dr = 0.01; % m
r = 0.03; %m
rho = 1.4;
%% getting C_L and C_D from the reference paper

alpha = linspace(0, pi/2, 100);
alpha_in_deg = rad2deg(alpha);
num = xlsread('Cl.csv');

x = num(:,1);
y = num(:,2);

xi = linspace(0, 90, 100);
C_L = interp1(x, y, xi);

num = xlsread('Cd.csv');

x = sort(num(:,1));
x(81) = []; % accidently has an overlapping number
y = sort(num(:,2));
y(81) = [];

xi = linspace(0, 90, 100);
C_D = interp1(x, y, xi);


figure;
h1 = plot(alpha_in_deg, C_D);
hold on;
h2 = plot(alpha_in_deg, C_L);
% xlim([17, 90])
ylim([0, 1.5])
xlabel('angle of attack (\theta)');
ylabel('C_L or C_D');
legend([h1, h2],'C_D','C_L','location','best');
grid on;
%%
a = 0.001; % first guess
b = 0.001; % first guess
%% Change a until dT_a is within 5% of dT_m

while(1)
    V_disc = Vinf + Vinf * a;
    V2 = r * omega * (1 - b);
    
    V1 = sqrt(V_disc^2 + V2^2);
    phi = atan(V_disc/V2);
    
    alpha2 = rad2deg(theta - phi);
    
    
    [~, idx_theta_in_use] = min(abs(alpha_in_deg - alpha2));
    
    C_L_in_use = C_L(idx_theta_in_use);
    C_D_in_use = C_D(idx_theta_in_use);
    
    dT_a = 1/2*(V1^2)*rho*c*(C_L_in_use * cos(phi) - C_D_in_use * sin(phi)) * dr;
    dT_m = 4 * pi * r * dr * rho * Vinf^2 * a * (1 + a);
    
    perc_for_a = abs(dT_a - dT_m) / dT_m * 100;
    
    if perc_for_a < 5
        break
    end
    
    a = a + 0.001;
end


%% Change b until dQ_a is within 10% of dQ_m

while(1)
    V_disc = Vinf + Vinf * a;
    V2 = r * omega * (1 - b);
    
    V1 = sqrt(V_disc^2 + V2^2);
    phi = atan(V_disc/V2);
    
    alpha2 = rad2deg(theta - phi);
    
    
    [~, idx_theta_in_use] = min(abs(alpha_in_deg - alpha2));
    
    C_L_in_use = C_L(idx_theta_in_use);
    C_D_in_use = C_D(idx_theta_in_use);
    
    dQ_a = 1/2 *(V1^2) * rho * c * (C_L_in_use * sin(phi) + C_D_in_use * cos(phi)) * dr * r;
    dQ_m = rho * 4 * pi * r^3 * Vinf * (1+a) * b * omega * dr;
    
    perc_for_b = abs(dQ_a - dQ_m) / dQ_m * 100;
    
    if perc_for_b < 10
        break
    end
    
    b = b + 0.001;
end

%% final result

disp(['a should be: ',num2str(a),' and b should be: ',num2str(b)]);
