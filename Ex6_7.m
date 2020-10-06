clear; close all; clc;

rate = 0.05;
inf_rate = 0.02;

clear W AB year

year(1) = 0;
W(1) = 0;
AB(1) = 300000;
Wnext = 25000;
ABnext = 300000 * (1 + rate);
n = 2;

while ABnext>Wnext
    year(n) = n - 1;
    W(n) = Wnext;
    AB(n) = ABnext - W(n);
    ABnext = AB(n) * (1 + rate);
    Wnext = W(n) * (1+ inf_rate);
    n = n+1;
end

disp(['������ �ܰ�� ',num2str(year(n-1)),'�� ���� �����ȴ�.']);