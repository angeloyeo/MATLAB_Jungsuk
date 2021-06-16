function res = fun_bubble_sort(v)
% Bubble Sort �˰��� ���� 
% [�Է�] v: ����. v�� dimension�� 1 x n ��. 
% [���] res : ����. res�� ������������ ���ĵ� ������ ǥ����. dimension�� 1xn.
% ����
% v = randperm(10)
% v = [7, 4, 5, 1, 3];
% res -> [1, 3, 4, 5, 7]
%
% 2021�� 1�� 4�� ������ �ۼ�

for i = length(v)-1:-1:1 % ������ sorting ���� ���ΰ�?
    for j = 1:i % 1���� i�� ���� sorting ���ְ��� ��.
        if v(j) > v(j+1) % j�� ���ҿ� j+1�� ���Ҹ� ������ ��, ���� ���� ũ�ٸ�
            
            % �� ���Ҹ� �ٲ��ش�.
            temp1 = v(j);
            temp2 = v(j+1);
            v(j) = temp2;
            v(j+1) = temp1;
        end
        
    end
end
res = v; % Bubble sort �˰��� ��.