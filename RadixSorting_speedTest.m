%speed test of RadixSorting
timesum = 0;

%아래를 반복하면서 시간의 평균을 구해야한다.
%아래가 무작위 벡터

%Quick Sorting 이랑 비교해서 약 3배정도 느리다.
%함수를 해제해주고 하나의 함수를 실행하면 
%속도가 약 20배정도 향상된다.

for i = 1:1:1000
    %시계시작
    t=clock;

    X = randi(10,1,100);
    N = length(X);
    %아래가 정렬 알고리즘 1000회 실행하는 코드
    radixSorting(X,N);

    %사이시간반환
    timesum = timesum + etime(clock,t);

end
avrageTime = timesum/10000;
disp("time average : "+avrageTime);