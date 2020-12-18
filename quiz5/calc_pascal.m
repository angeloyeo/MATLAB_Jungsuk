clear; close all; clc;
%{
Quiz 5번에 해당하는 Solution임.

2020년 12월 18일 여동훈
%}

%%

n = 5;

pascal = zeros(n,n);
pascal(1,:) = 1;
pascal(:,1) = 1;
for i = 2:n
    for j = 2:n
        pascal(i,j) = pascal(i,j-1) + pascal(i-1, j);
    end
end





