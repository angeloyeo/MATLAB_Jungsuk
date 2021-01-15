function res = main(v)
% merge sort�� ����
%
%
res = merge_sort(v);
end

function res = merge_sort(v)
if length(v) <= 1
    res = v;
else
    mid = floor(length(v) / 2);
    left_v = v(1:mid);
    right_v = v(mid+1:end);
    left_v = merge_sort(left_v);
    right_v = merge_sort(right_v);
    
    v = merge(left_v, right_v);
    res = v;
end


end

function res = merge(left, right)
res = []; % merge sort�� ������ ���� �߰� array�� �ʿ���.

while ~isempty(left) || ~isempty(right) % ���� Ȥ�� ������ ��Ŀ� �ϳ��� ���Ұ� �ִٸ� ��� ����
    
    if ~isempty(left) && ~isempty(right) %  ���� ��� ������ ��Ŀ� ��� ���Ұ� �ִ� ���
        
        if left(1) <= right(1) % ���� ����� ù��° ���ҿ� ������ ����� ù��° ���� ��
            res = [res left(1)];
            left(1) = [];
        else
            res = [res right(1)];
            right(1) = [];
        end
        
    elseif ~isempty(left) % ���� ��ĸ� ���Ұ� �ִ� ���
        res = [res left(1)];
        left(1) = [];
        
    elseif ~isempty(right) % ������ ��ĸ� ���Ұ� �ִ� ���
        res = [res right(1)];
        right(1) = [];
    end
end

end