function Quick_sort_fun(v)
res = quicksort(v, 1, length(v));
disp(res)
end

function res = quicksort(v, idx_start, idx_end)

% 원소가 1개인 경우 그대로 두기
if idx_start >= idx_end
    res = v;
else
    idx_pivot = idx_start;
    i = idx_pivot+1;
    j = idx_end;
    
    while (i <= j)
        
        while (v(i)<=v(idx_pivot) && i <= idx_end)
            i = i+1;
        end
        
        while (v(j)>=v(idx_pivot) && j > idx_start)
            j = j-1;
            
        end
        if i >j
            
            v = swap(v, idx_pivot, j);
            
        else
            v = swap(v, i, j);
        end
        
        
    end
    v = quicksort(v, idx_start,j-1);
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