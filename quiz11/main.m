function res = main(v)
% merge sort¸¦ ±¸Çö
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
res = [];
while ~isempty(left) || ~isempty(right)
    if ~isempty(left) && ~isempty(right)
        if left(1) <= right(1)
            res = [res left(1)];
            left(1) = [];
        else
            res = [res right(1)];
            right(1) = [];
        end
    elseif ~isempty(left)
        res = [res left(1)];
        left(1) = [];
    elseif ~isempty(right)
        res = [res right(1)];
        right(1) = [];
    end
end

end