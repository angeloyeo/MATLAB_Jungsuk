clear; close all; clc;

[num,txt, rawdata] = xlsread('.\data\train.csv');

featnames = {'datetime','season','holiday','working day','temp','atemp','humidity','windspeed','casual','registered','count'};

%% 시간을 datenum(Year, Month, Day)이용해서 datenum으로 바꿔주어야 쓸 수 있음.
% 문제점: 엑셀과 MATLAB은 datenumber에 대한 기저값이 다르므로 기존 엑셀 파일에서 불러온 값에 대해 기저값을 더해주어야 함.

base_dif = datenum(2011, 1, 1) - num(1,1);

num(:,1) = num(:,1) + base_dif;

% 가령,
% datestr(num(2, 1)) --> 2011년 1월 1일 오전 1시가 제대로 출력되어야 함.

%% 시간 데이터에서 연, 월, 일, 시, 분, 초 feature 분리

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

%% 여러 시간 단위에 따른 대여량

figure('position',[680, 317, 1134, 661]);

subplot(2,2,1); % 연도별 대여량
idx_2011 = num(:,13) == 2011;
mn_2011 = mean(num(idx_2011, 12));
std_2011 = 2*std(num(idx_2011, 12))/sqrt(sum(idx_2011)); % 2 SEM을 이용해서 신뢰구간 표현 가능

idx_2012 = num(:,13) == 2012;
mn_2012 = mean(num(idx_2012, 12));
std_2012 = 2*std(num(idx_2012, 12))/sqrt(sum(idx_2012));

bar([2011, 2012], [mn_2011, mn_2012])
hold on;
errorbar([2011, 2012], [mn_2011, mn_2012], [std_2011, std_2012],'r.')
title('연도별 대여량');
xlabel('연도');

subplot(2,2,2); % 월별 대여량
clear mns CIs
for i_month = 1:12
    idx = num(:,14) == i_month;
    mn = mean(num(idx, 12));
    CI = 2 * std(num(idx, 12)) / sqrt(sum(idx));
    mns(i_month) = mn;
    CIs(i_month) = CI;
end
bar(1:12, mns);
hold on;
errorbar(1:12, mns, CIs,'r.');
xlim([0, 13])
title('월별 대여량');
xlabel('월');

subplot(2,2,3); % 일별 대여량
clear mns CIs
for i_day = 1:31
    idx = num(:,15) == i_day;
    mn = mean(num(idx, 12));
    CI = 2 * std(num(idx, 12)) / sqrt(sum(idx));
    mns(i_day) = mn;
    CIs(i_day) = CI;
end
bar(1:31, mns);
hold on;
errorbar(1:31, mns, CIs,'r.');
xlim([0, 32])
title('일별 대여량');
xlabel('일');

subplot(2,2,4); % 시간별 대여량
clear mns CIs
for i_hour = 0:23
    idx = num(:,16) == i_hour;
    mn = mean(num(idx, 12));
    CI = 2 * std(num(idx, 12)) / sqrt(sum(idx));
    mns(i_hour+1) = mn;
    CIs(i_hour+1) = CI;
end
bar(0:23, mns);
hold on;
errorbar(0:23, mns, CIs,'r.');
xlim([0, 23])
title('시간별 대여량');
xlabel('시간');

%% 5-1. 월별 카운트 표시

clear mns CIs
for i_hour = 0:23
    idx = num(:,16) == i_hour;
    mns(i_hour+1) = mean(num(idx,12));
    CIs(i_hour+1) = 1.96 * std(num(idx,12)) / sqrt(sum(idx));
end
figure('position',[680, 653, 1161, 325]);
errorbar(0:23, mns, CIs, 'ro-','markerfacecolor','r');
grid on;
xlabel('시');
ylabel('대여량');

%% 5-2. 시간 별 count를 working day 여부에 따라 표시
clear mns CIs
for i_working = 0:1
    for i_hour = 0:23
        idx = num(:,16) == i_hour & num(:,4) == i_working;
        mns(i_working+1, i_hour+1) = mean(num(idx,12));
        CIs(i_working+1, i_hour+1) = 1.96 * std(num(idx,12)) / sqrt(sum(idx));
    end
end

figure('position',[680, 653, 1161, 325]);
clear h
h(1) = errorbar(0:23, mns(1,:), CIs(1,:), 'bo-','markerfacecolor','b');
hold on;
h(2) = errorbar(0:23, mns(2,:), CIs(2,:), 'ro-','markerfacecolor','r');
grid on;
xlabel('시');
ylabel('대여량');
legend(h, 'Non-Working Day', 'Working Day');

%% 5-3. 시간 별 count를 요일에 따라 표시
clear mns CIs
for i_weekday = 1:7
    for i_hour = 0:23
        idx = num(:,16) == i_hour & num(:,19) == i_weekday;
        mns(i_weekday, i_hour+1) = mean(num(idx,12));
        CIs(i_weekday, i_hour+1) = 1.96 * std(num(idx,12)) / sqrt(sum(idx));
    end
end

figure('position',[680, 653, 1161, 325]);
clear h
my_color = lines(7);
for i_weekday = 1:7
    h(i_weekday) = errorbar(0:23, mns(i_weekday,:), CIs(i_weekday,:), 'o-','markerfacecolor',my_color(i_weekday,:),'color',my_color(i_weekday,:));
    hold on;
end
grid on;
xlabel('시');
ylabel('대여량');
legend(h, '일요일','월요일','화요일','수요일','목요일','금요일','토요일');


%% 5-4. 시간 별 count를 날씨에 따라 표시
clear mns CIs
for i_weather = 1:4
    for i_hour = 0:23
        idx = num(:,16) == i_hour & num(:,5) == i_weather;
        mns(i_weather, i_hour+1) = mean(num(idx,12));
        CIs(i_weather, i_hour+1) = 1.96 * std(num(idx,12)) / sqrt(sum(idx));
    end
end

figure('position',[680, 653, 1161, 325]);
clear h
my_color = lines(4);
for i_weather = 1:4
    h(i_weather) = errorbar(0:23, mns(i_weather,:), CIs(i_weather,:), 'o-','markerfacecolor',my_color(i_weather,:),'color',my_color(i_weather,:));
    hold on;
end
grid on;
xlabel('시');
ylabel('대여량');
legend(h, '맑은 날','안개','가벼운 눈','폭우')

%% 5-5. 시간 별 count를 계절에 따라 표시
clear mns CIs
for i_season = 1:4
    for i_hour = 0:23
        idx = num(:,16) == i_hour & num(:,2) == i_season;
        mns(i_season, i_hour+1) = mean(num(idx,12));
        CIs(i_season, i_hour+1) = 1.96 * std(num(idx,12)) / sqrt(sum(idx));
    end
end

figure('position',[680, 653, 1161, 325]);
clear h
my_color = lines(4);
for i_season = 1:4
    h(i_season) = errorbar(0:23, mns(i_season,:), CIs(i_season,:), 'o-','markerfacecolor',my_color(i_season,:),'color',my_color(i_season,:));
    hold on;
end
grid on;
xlabel('시');
ylabel('대여량');
legend(h, '겨울','봄','여름','가을')

