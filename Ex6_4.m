clear; close all; clc;

Ein = input('변환할 에너지(일)의 값을 입력하시오: ');
EinUnits = input('현재 단위를 입력하시오(J, ft-lb, cal, or eV): ', 's');
EoutUnits = input('새 단위를 입력하시오(J, ft-lb, cal, or eV): ', 's');

error = 0;

switch EinUnits
    case 'J'
        EJ = Ein;
    case 'ft-lb'
        EJ = Ein/0.738;
    case 'cal'
        EJ = Ein/0.239;
    case 'eV'
        EJ = EIn/6.24e18;
    otherwise
        error = 1;
end

switch EoutUnits
    case 'J'
        Eout = EJ;
    case 'ft-lb'
        Eout = EJ * 0.738;
    case 'cal'
        Eout = EJ * 0.239;
    case 'eV'
        Eout = EJ * 6.24e18;
    otherwise
        error = 1;
end   

if error
    disp('ERROR current or new units are typed incorrectly');
else
    fprintf('E = %g %s', Eout, EoutUnits);
end
