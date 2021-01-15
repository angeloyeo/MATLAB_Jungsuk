function res = main(v)
% merge sort를 구현
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
res = []; % merge sort는 복사해 넣을 추가 array가 필요함.

while ~isempty(left) || ~isempty(right) % 왼쪽 혹은 오른쪽 행렬에 하나라도 원소가 있다면 계속 수행
    
    if ~isempty(left) && ~isempty(right) %  왼쪽 행렬 오른쪽 행렬에 모두 원소가 있는 경우
        
        if left(1) <= right(1) % 왼쪽 행렬의 첫번째 원소와 오른쪽 행렬의 첫번째 원소 비교
            res = [res left(1)];
            left(1) = [];
        else
            res = [res right(1)];
            right(1) = [];
        end
        
    elseif ~isempty(left) % 왼쪽 행렬만 원소가 있는 경우
        res = [res left(1)];
        left(1) = [];
        
    elseif ~isempty(right) % 오른쪽 행렬만 원소가 있는 경우
        res = [res right(1)];
        right(1) = [];
    end
end

end