clear; close all; clc;

[num,txt, rawdata] = xlsread('.\data\train.csv');

featnames = {'datetime','season','holiday','working day','temp','atemp','humidity','windspeed','casual','registered','count'};

%% �ð��� datenum(Year, Month, Day)�̿��ؼ� datenum���� �ٲ��־�� �� �� ����.
% ������: ������ MATLAB�� datenumber�� ���� �������� �ٸ��Ƿ� ���� ���� ���Ͽ��� �ҷ��� ���� ���� �������� �����־�� ��.

base_dif = datenum(2011, 1, 1) - num(1,1);

num(:,1) = num(:,1) + base_dif;

% ����,
% datestr(num(2, 1)) --> 2011�� 1�� 1�� ���� 1�ð� ����� ��µǾ�� ��.

%% �ð� �����Ϳ��� ��, ��, ��, ��, ��, �� feature �и�

for i = 1:size(num,1)
    t = datevec(datestr(num(i,1)));
    
    year = t(1);
    month = t(2);
    day = t(3);
    hour = t(4);
    minute = t(5);
    second = t(6);
    
    if minute == 59
        minute = 0;
        second = 0;
        hour = hour + 1;
    end
    
    num(i, 13) =year;
    num(i, 14) = month;
    num(i, 15) = day;
    num(i, 16) = hour;
    num(i, 17) = minute;
    num(i, 18) = second;
    
    [N,S] = weekday(num(i,1));
    num(i, 19) = N;

end

%%

% X = num(:, [2:11,13:end]);
% y = num(:, 12);
% 
% mvregress(X,y)