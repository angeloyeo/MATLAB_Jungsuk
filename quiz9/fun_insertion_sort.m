function res = fun_insertion_sort(v)

v_ori = v;
n = length(v);

for i = 2:n
    k = i; % swap ���� �� index�� �ٲ��� �ϹǷ� �� �� �ʿ��� �ӽ� index �� ��ȣ
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