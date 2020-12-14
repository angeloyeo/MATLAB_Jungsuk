clear; close all; clc;

%% DEFINE
omega = 2500 / 60 * (2*pi); % 2500 rpm in rad/s
c = 0.02; % m
rho = 1.4;
Vc = 1; % m/s

dr = 0.08; % m
theta = deg2rad(linspace(65, 30, 5)); % will vary from 65 to 30 (in 5 levels), i.e., linspace(65, 30, 5)
r = linspace(dr, 5*dr, 5); %m (will vary from 1 to 5 times of dr)

num_of_blade = 4;

%%

alpha = linspace(0, pi/2, 100);
alpha_in_deg = rad2deg(alpha);

num = xlsread('Cl.csv');

x = num(:,1);
y = num(:,2);

xi = linspace(0, 90, 100);
C_L = interp1(x, y, xi);

my_dT = zeros(1, length(r)); % I want to get 5 dT's for each r

iter_num = cell(1, length(r));
iter_vi = cell(1, length(r));
iter_dT_aero = cell(1, length(r));
iter_dT_mon = cell(1, length(r));

for i = 1:length(r)
    
    Vi = 0.00001; % first guess
    iter_num{i} = [];
    iter_vi{i} = [];
    iter_dT_aero{i} = [];
    iter_dT_mon{i} = [];
    ii=1;
    while(1)
        phi = atan((Vi + Vc)/(omega * r(i)));
        alpha = rad2deg(theta(i) - phi);
        
        [~,idx] = min(abs(alpha_in_deg-alpha));
        C_L_of_now = C_L(idx);
        
        dT_aero = 1/2*rho*(omega * r(i))^2 * c * dr * C_L_of_now;
        dT_mon = 4 * pi * r(i) * dr * rho * Vi * (Vi + Vc);
        
        
        perc_for_a = abs(dT_aero - dT_mon) / dT_mon * 100;
        
        Vi = Vi + 0.01;
        iter_num{i} = [iter_num{i}, ii];
        iter_vi{i} = [iter_vi{i}, Vi];
        iter_dT_aero{i} = [iter_dT_aero{i}, dT_aero];
        iter_dT_mon{i} = [iter_dT_mon{i}, dT_mon];
        ii=ii+1; % for recording iteration number
        
        if perc_for_a < 1
            break
        end
    end
    
    my_dT(i) = dT_aero;
end

%%

sum(my_dT) * num_of_blade

for i=1:length(r)
    xlswrite('my_result.xlsx',{'iter', 'Vi', 'dT aero', 'dT momentum'},i)
    xlswrite('my_result.xlsx',[iter_num{i}', iter_vi{i}', iter_dT_aero{i}', iter_dT_mon{i}'],i,'A2')
end
