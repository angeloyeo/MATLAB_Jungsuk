clear; close all; clc;

[num,txt, rawdata] = xlsread('.\data\train.csv');

featnames = {'datetime','season','holiday','working day','temp','atemp','humidity','windspeed','casual','registered','count'};

%% 시간을 datenum(Year, Month, Day)이용해서 datenum으로 바꿔주어야 쓸 수 있음.
% 문제점: 엑셀과 MATLAB은 datenumber에 대한 기저값이 다르므로 기존 엑셀 파일에서 불러온 값에 대해 기저값을 더해주어야 함.

base_dif = datenum(2011, 1, 1) - num(1,1);

num(:,1) = num(:,1) + base_dif;

% 가령,
% datestr(num(2, 1)) --> 2011년 1월 1일 오전 1시가 제대로 출력되어야 함.