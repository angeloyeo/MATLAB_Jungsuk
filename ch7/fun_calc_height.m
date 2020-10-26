function height = fun_calc_height(v0)
% v0를 넣으면 높이를 출력해주는 함수입니다.
% input: v0. v0 는 속도를 의미합니다.
% output: height. height는 최대 높이를 의미함.

g = 9.81;
height = v0^2/(2*g);

