function rev = fun_insertion_sort2(v)
% 수업시간에 설명하면서 사용한 것

for i_round = 1:length(v)-1 % i_round: 몇 회전에 관한 것인가?
    
end


%% 1 회전
if v(2) < v(1)
    v = swap(v, 1, 2);
end

%% 2회전

if v(3) < v(2)
    v = swap(v, 2, 3);
end

if v(2) < v(1)
    v = swap(v, 1, 2);
end

%% 3회전

if v(4) < v(3)
    v = swap(v, 3, 4);
end

if v(3) < v(2)
    v = swap(v, 3, 2);
end

if v(2) < v(1)
    v = swap(v, 1, 2);
end

rev =v;

end

function res = swap(v, n1, n2)

    temp = v(n1);
    v(n1) = v(n2);
    v(n2) = temp;

    res = v;
end



