clear; close all; clc;

[num,txt, rawdata] = xlsread('.\data\train.csv');

featnames = {'datetime','season','holiday','working day','temp','atemp','humidity','windspeed','casual','registered','count'};

%% �ð��� datenum(Year, Month, Day)�̿��ؼ� datenum���� �ٲ��־�� �� �� ����.
% ������: ������ MATLAB�� datenumber�� ���� �������� �ٸ��Ƿ� ���� ���� ���Ͽ��� �ҷ��� ���� ���� �������� �����־�� ��.

base_dif = datenum(2011, 1, 1) - num(1,1);

num(:,1) = num(:,1) + base_dif;

% ����,
% datestr(num(2, 1)) --> 2011�� 1�� 1�� ���� 1�ð� ����� ��µǾ�� ��.