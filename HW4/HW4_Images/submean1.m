function Y = submean1(X)
A=mean(mean(X));
Y=zeros(510,510);
for i=1:510
    for j=1:510
        Y(i,j)=X(i,j)-A;
    end
end
end