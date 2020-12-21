function res = fun_bubble_sort(v)

%
% v = randperm(10)
% v = [7, 4, 5, 1, 3];

for i = length(v)-1:-1:1
    for j = 1:i
        if v(j) > v(j+1)
            temp1 = v(j);
            temp2 = v(j+1);
            v(j) = temp2;
            v(j+1) = temp1;
        end
        
    end
end
res = v;