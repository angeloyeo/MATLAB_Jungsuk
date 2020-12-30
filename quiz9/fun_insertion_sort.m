function res = fun_insertion_sort(v)

v_ori = v;
n = length(v);

for i = 2:n
    k = i; % swap 했을 때 index도 바뀌어야 하므로 그 때 필요한 임시 index 용 번호
    for j = (i-1):-1:1
        if v(j) > v(k)
            temp1 = v(k);
            temp2 = v(j);
            
            v(k) = temp2;
            v(j) = temp1;
            k = j;
        end
    end
end

res = v;