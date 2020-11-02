clc;
clear;
close all;
hw4 = xlsread('hw4.xlsx');

TAT_TIME = hw4(10:end,2);
TAT = hw4(10:end, 3);
SAT_TIME = hw4(10:end,5);
SAT = hw4(10:end, 6);
PT_TIME = hw4(10:end, 8);
PT = hw4(10:end, 9);
PSA_TIME = hw4(10:end, 11);
PSA = hw4(10:end, 12);
TAS_TIME = hw4(10:end, 14);
TAS = hw4(10:end, 15);
MACH_TIME = hw4(10:end, 17);
MACH =hw4(10:end, 18);

%% data pruning
TAT_TIME(isnan(TAT_TIME)) = [];
TAT(isnan(TAT)) = [];

SAT_TIME(isnan(SAT_TIME)) = [];
SAT(isnan(SAT)) = [];

PT_TIME(isnan(PT_TIME)) = [];
PT(isnan(PT)) = [];

PSA_TIME(isnan(PSA_TIME)) = [];
PSA(isnan(PSA)) = [];

TAS_TIME(isnan(TAS_TIME)) = [];
TAS(isnan(TAS)) = [];

MACH_TIME(isnan(MACH_TIME)) = [];
MACH(isnan(MACH)) = [];

%% interpl
SAT = interp1(SAT_TIME, SAT, TAS_TIME);
TAT = interp1(TAT_TIME, TAT, TAS_TIME);
PT = interp1(PT_TIME, PT, TAS_TIME);
PSA = interp1(PSA_TIME, PSA, TAS_TIME);
MACH = interp1(MACH_TIME, MACH, TAS_TIME);

%% plot graph
figure;
plot(TAS_TIME,TAT)
hold on 
plot(TAS_TIME,SAT)
title('Temperature')
legend('Total','Static')

%% Calculation the Mach number of the airplane
figure 
gamma = 1.4;

MACH_calculated_with_pressure = real(sqrt(...
    2/(gamma-1)*((PT./PSA).^((gamma-1)/gamma)-1)));
plot(TAS_TIME, MACH)
hold on
plot(TAS_TIME, MACH_calculated_with_pressure)
title('Mach number calculated with Pressure')
legend('recorded Mach number','calculated Mach number')
xlabel('time(min)');
ylabel('Mach number');

%% Based on SAT, calculate the speed of sound a.
gamma = 1.4;
R = 287;
T = (SAT+273.15);
a = sqrt(gamma*T*R);

%% calculate the Mach number and air speed
a2 = a * 1.944;
TAS_calculated = MACH_calculated_with_pressure .* a2;
figure;
plot(TAS_TIME, TAS);
hold on;
plot(TAS_TIME, TAS_calculated);

legend('Recorded TAS','Calculated TAS')
xlabel('time (min)');
ylabel('spped (m/s)');
title('Comparing recorded TAS and Calculated TAS');

%% Calculating the Mach number using temperature
figure 
gamma = 1.4;

MACH_calculated_with_temp = sqrt(((TAT+273.15)./(SAT+273.15)-1) * 2 / (gamma-1));
plot(TAS_TIME, MACH)
hold on
plot(TAS_TIME, MACH_calculated_with_temp)
title('Mach number calculated with Temperature')
legend('recorded Mach number','Mach number with temp','location','best')
xlabel('time(min)');
ylabel('Mach number');

