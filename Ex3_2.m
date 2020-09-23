clear;

F1M = 400; F2M = 500; F3M = 700;

Th1 = -20; Th2 = 30; Th3 = 143;

F1 = F1M * [cosd(Th1), sind(Th1)];
F2 = F2M * [cosd(Th2), sind(Th2)];
F3 = F3M * [cosd(Th3), sind(Th3)];

Ftot = F1 + F2 + F3;

FtotM = sqrt(Ftot(1)^2 + Ftot(2) ^2)
Th = atand(Ftot(2)/Ftot(1))