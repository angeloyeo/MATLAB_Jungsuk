function [cr] = cirtriangle(A, B, C)

fun_dist = @(X, Y) sqrt(sum((X-Y).^2));

cr = fun_dist(A,B) + fun_dist(B,C) + fun_dist(C,A);