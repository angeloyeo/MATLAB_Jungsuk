function res = fun_selection_sort(v)
n = length(v);

for i = 1:n
    [~, my_min_idx] = fun_findmin(v(i:n));
    
    temp1 = v(i);
    temp2 = v(my_min_idx+i-1);
    
    v(i) = temp2;
    v(my_min_idx+i-1) = temp1;
end

res = v;

end


function [my_min, my_min_idx] = fun_findmin(v2)
% 최솟값 찾아주는 함수
my_min = inf;

for i = 1:length(v2)
    if v2(i) < my_min
        my_min = v2(i);
        my_min_idx = i;
    end
end

end