clear; close all; clc;

r = 3;
c = 5;

%% 기초 설명
A = zeros(r,c);
ii = 1;
for i = 1:r
    for j =1:c
        A(i,j) = ii;
        ii=ii+1;
        disp(['현재 i = ',num2str(i), '/ 현재 j = ',num2str(j)])
        disp(A)
    end
end

%% 문제 풀이
A = zeros(r,c);
for i = 1:r
    for j = 1:c
        A(i,j) = i^j/(i+j);
    end
end
