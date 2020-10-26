clear; close all; clc;

% my_height = fun_calc_height(15);

g = 9.81;
fun_hhh = @(v0) v0^2/(2*g); % 함수를 정의해주는 부분

fun_hhh(15) % 함수를 이용하는 부분
