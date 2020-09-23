clear;

% 1 mile = 5280 ft.
% �ٵ� �ü��̴ϱ� �ʼ����� �ٲ��־�� ��..


v0train = 54 * 5280 / 3600;
v0car = 28 * 5280 / 3600;
a_car = 4; %ft/s^2

t = 0:10;
y = -400 + v0train*t;
x = -200 + v0car*t + 1/2*a_car * t.^2;
d = sqrt(x.^2 + y.^2);
vcar = v0car + a_car * t;
vtrain = v0train;
vtc = sqrt(vcar.^2 + vtrain.^2);

[t; y;, x; d; vcar; vtc]'





