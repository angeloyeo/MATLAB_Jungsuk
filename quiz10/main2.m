function res = main2(v)
% MATLAB�� ����ȭ ����� �̿��� quicksort 
if length(v) <= 1
    res = v;
else
    pivot = v(1);
    res = [main2(v(v<pivot)), pivot, main2(v(v>pivot))];
end
end