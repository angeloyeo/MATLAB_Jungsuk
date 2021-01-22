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

%% ���� �ð� ������ ���� �뿩��

figure('position',[680, 317, 1134, 661]);

subplot(2,2,1); % ������ �뿩��
idx_2011 = num(:,13) == 2011;
mn_2011 = mean(num(idx_2011, 12));
std_2011 = 2*std(num(idx_2011, 12))/sqrt(sum(idx_2011)); % 2 SEM�� �̿��ؼ� �ŷڱ��� ǥ�� ����

idx_2012 = num(:,13) == 2012;
mn_2012 = mean(num(idx_2012, 12));
std_2012 = 2*std(num(idx_2012, 12))/sqrt(sum(idx_2012));

bar([2011, 2012], [mn_2011, mn_2012])
hold on;
errorbar([2011, 2012], [mn_2011, mn_2012], [std_2011, std_2012],'r.')
title('������ �뿩��');
xlabel('����');

subplot(2,2,2); % ���� �뿩��
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
title('���� �뿩��');
xlabel('��');

subplot(2,2,3); % �Ϻ� �뿩��
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
title('�Ϻ� �뿩��');
xlabel('��');

subplot(2,2,4); % �ð��� �뿩��
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
title('�ð��� �뿩��');
xlabel('�ð�');

%% 5-1. ���� ī��Ʈ ǥ��

clear mns CIs
for i_hour = 0:23
    idx = num(:,16) == i_hour;
    mns(i_hour+1) = mean(num(idx,12));
    CIs(i_hour+1) = 1.96 * std(num(idx,12)) / sqrt(sum(idx));
end
figure('position',[680, 653, 1161, 325]);
errorbar(0:23, mns, CIs, 'ro-','markerfacecolor','r');
grid on;
xlabel('��');
ylabel('�뿩��');

%% 5-2. �ð� �� count�� working day ���ο� ���� ǥ��
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
xlabel('��');
ylabel('�뿩��');
legend(h, 'Non-Working Day', 'Working Day');

%% 5-3. �ð� �� count�� ���Ͽ� ���� ǥ��
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
xlabel('��');
ylabel('�뿩��');
legend(h, '�Ͽ���','������','ȭ����','������','�����','�ݿ���','�����');


%% 5-4. �ð� �� count�� ������ ���� ǥ��
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
xlabel('��');
ylabel('�뿩��');
legend(h, '���� ��','�Ȱ�','������ ��','����')

%% 5-5. �ð� �� count�� ������ ���� ǥ��
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
xlabel('��');
ylabel('�뿩��');
legend(h, '�ܿ�','��','����','����')

