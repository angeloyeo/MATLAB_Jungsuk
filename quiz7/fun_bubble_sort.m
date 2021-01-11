function res = fun_bubble_sort(v)
% Bubble Sort 알고리즘 구현 
% [입력] v: 벡터. v의 dimension은 1 x n 임. 
% [출력] res : 벡터. res는 오름차순으로 정렬된 순열을 표현함. dimension은 1xn.
% 예시
% v = randperm(10)
% v = [7, 4, 5, 1, 3];
% res -> [1, 3, 4, 5, 7]
%
% 2021년 1월 4일 여동훈 작성

for i = length(v)-1:-1:1 % 어디까지 sorting 해줄 것인가?
    for j = 1:i % 1부터 i번 까지 sorting 해주고자 함.
        if v(j) > v(j+1) % j번 원소와 j+1번 원소를 비교했을 때, 앞의 것이 크다면
            
            % 두 원소를 바꿔준다.
            temp1 = v(j);
            temp2 = v(j+1);
            v(j) = temp2;
            v(j+1) = temp1;
        end
        
    end
end
res = v; % Bubble sort 알고리즘 끝.