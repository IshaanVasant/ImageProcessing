function Y = submean(X)
A=mean(mean(X));
Y=zeros(128,128);
for i=1:128
    for j=1:128
        Y(i,j)=X(i,j)-A;
    end
end
end
