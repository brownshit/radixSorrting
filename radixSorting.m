function X_end = radixSorting(X,N)
%기수정렬
    %요소들이 10의 몇 제곱수인지
    %X =[2   5   6   9   8   7  76   5   2   3  10]
    %Y= [134   123   543   253   774   812   989   433]
    %Y에 대해서는 잘 실행되지만, X의 경우에서 오류를 발견했다.
    %22.11.19 이번 주말까지 해서 완벽하게 고쳐놓기. 실행속도도 빠르게.
    numof10 = 0;
    for i = 1:1:N
        numof = log10(X(i));
        inner_numof = floor(numof);
        if(inner_numof > numof10)
            numof10 = inner_numof;
        end
    end
    %numof10 = 가장 큰 수의 요소가 10의 몇 제곱수인지.

    %같은 방식으로 소수점 n자리의 수도 이런식으로 가능하다!
    %과제로 소수점도 하는게 나오면 variable [  numof01  ] 을 사용해서 \
    %log10의 음수 비교를 통해 자릿수를 도출해낼수가 있다. 
        %10보다 작은수의 log10값은 음수인 점을 이용.
    
    
    %Y에는 일의자리수의 요소가 저장이 되어야 한다...
    
    for l = 1:1:numof10+1 
        Y = X;      %Y에 X를 다 넣어서 그다음에 출력한다
        %index기능이 없기 때문에 새로운 배열을 만들어서 서로의 index관계를 만들어 줘야 한다.
        
                %disp("=========="+l+"번째 실행");
        %+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
 
        if l == numof10+1
            % this area has another method to get Y.
            % this Y is deal with MSB side.
            for X_index = 1:1:N
                Y(X_index) = Y(X_index)./(10^(l-1));
                Y(X_index) = floor(Y(X_index));
                %소수점 아래로는 날려주기.
            end
        else
            for j = 1:1:N
                Y(j) = Y(j)./10^l;
                floorinteger = floor(Y(j));
                Y(j) = Y(j) - floorinteger;
                %Y(j)는 소수부분만 남는다.
                Y(j) = Y(j).*10^l;
                %위의 과정을 통해서 비교하려는 해당 자리수를 제외한 자리의 수들을 모두 제거.

                    %disp(Y);
                    %disp(Y(j));
            end
            
            
            %{
            disp("Y는  : ");
            disp(Y);
            for c = 1:1:N
                disp(Y(c));
            end
            %}
            


            %위의 코드들은 해당 l(엘)자리수 위의 수들을 날려주고
    
            %여기서는 위에서 가져온 10의 n자리 까지의 수중에서 
            %n자리에 어떤수가 있는지를 판별하는. 
    
    
            %this code causes problems!!_221104
                %solve_ it was caused by .* not *;
            for i = 1:1:N
                while Y(i) > 0
                    Y(i)  = Y(i) - 10^l;
                end
                if Y(i)<0
                    k = (Y(i) +10^l)./10^(l-1);
                    Y(i) = floor(k);
                        %disp("this is Y : "+Y(i));
                end
            end
            
        end
        %해당 자리수까지만의 연산을 위한 방법
        
        %+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
        %disp(Y);
        %위의 과정들은 가장 큰 자리수만 빼준다. 그 아래 자리수도 빼줘야 한다
            %clear
    
        %{
            여기부터는 2N개의 size를 갖는 배열을 만들어서 
            해당 배열을 정렬할 예정이다.
            X, Y를 배열  Z에 넣어준다.
        X   기존배열
        Y   일의자리 수 배열
        Z   둘다 들어있는 배열
        %}
    
        Z = zeros(1,2*N);
        %Z는 X요소 Y요소 
        for q =1:2:2*N-1 
            Z(q) = X((q+1)/2);
                %disp(Z(q));
            Z(q+1) = Y((q+1)/2);
                    %여기서는 Z를 만들어준다.
                %disp(Z(q+1));
        end
        %{
        disp("+-+-+-+-+-+-+-+-Z출력+-+-+-+-+-+-+-+-");
        disp(Z);
        %}


        %{
        bucket에 들어가있는 요소들은 행단위로 구분이 되어야 한다.
            만들어진 xyz 배열을 통해서 버킷에 담아주는 일련의 과정 진행
                Bucket = zeros(10,10);
        %}
        %X = Bucket(Z,2*N);
        %여기에 버킷의 실행부분을 삽입하고 시간이단축되는지 확인해보기
        %기존 : rand 100에 1.4e-05 s
        %변경후 : rand 100에 7e-06 s


%here is Bucket func is start. (I put in one file.)
        n = floor(N);
        registerVector = zeros(1,n); %vector for temp repos
        %we should define lower matrix to collect sorted numbers
        bucketMatrix = zeros(10,n);
        
        for i = 2:2:2*N
            %inner for. we should rotate 'the' Bucket's index
            for bucketIndexNum = 1:1:10
                %in here we'll use bucketIndexNum - 1
                    %actual index to compare successfully
                if (bucketIndexNum -1) == Z(i)
                    %inner if, we should line up what we collected in matrix
                    for low = 1:1:n
                        if bucketMatrix(bucketIndexNum,low) == 0
                            bucketMatrix(bucketIndexNum,low) = Z(i-1);
                            break;
                        end
                    end
                end
            end
        
        end
        %is that upper code makes bucketMatrix completely...??
        
        %more code matrix to vector.
        
        %under this paragraph's for is aimming...
        %should change to vector 
            %collect not_0 factor into vector
        
        k = 1;
        for i = 1:1:10
            for j = 1:1:n
                %[i,j] in matrix
                if bucketMatrix(i,j) ~= 0
                    registerVector(k) = bucketMatrix(i,j);
                    k = k+1;
                end
            end
        end
        X = registerVector;% temporary stored
                
%end of Bucket func...

            %위의 부분이 버킷을 싱행하는 부분,
            
            %disp("this is X :"+X);

        %this code causes problems!!_221104
            %bucket should have its own componant
        %changed into function.

    end

    X_end = X; %this is result.
        %disp(X_end);
    %위의 과정들이 실행되면 X의 10^0 자리 수들이 Y에 남는다.
    
    %현재 Y의 일의 자리들은 다 정렬이 되어있는 상태이다.
    %근데 이거랑 x랑 연관이 없다.
end