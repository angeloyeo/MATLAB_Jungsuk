function main(v)
res = quicksort(v, 1, length(v));
disp(res)
end

function res = quicksort(v, idx_start, idx_end)

% 원소가 1개인 경우 그대로 두기
if idx_start >= idx_end
    res = v;
else
    idx_pivot = idx_start;
    i = idx_pivot + 1; j = idx_end;
    
    while(i <= j) % 엇갈릴 때 까지 반복
        while(i <= idx_end && v(i) <= v(idx_pivot))
            i = i + 1;
        end
        
        while(j > idx_start && v(j) >= v(idx_pivot))
            j = j - 1;
        end
        
        if i > j
            v = swap(v, j, idx_pivot);
        else
            v = swap(v, i, j);
        end
        
    end
    
    v = quicksort(v, idx_start, j-1);
    v = quicksort(v, j+1, idx_end);
    
    res = v;
end
end

function res = swap(v, n1, n2)
temp = v(n2);
v(n2) = v(n1);
v(n1) = temp;

res = v;
end