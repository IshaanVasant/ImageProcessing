f = fopen('bridge.raw','r');
data = fread(f,'uint8=>uint8');
bridge = reshape(data,600,400)';
figure
imshow(bridge)

bridge1=bridge;

N=2;
I=[1 2;3 0];
T=(I+0.5)*(255/(N^2));

for i=1:400
    for j=1:600
        if bridge1(i,j)>T(mod(i,N)+1,mod(j,N)+1)
            bridge1(i,j)=255;
        else
            bridge1(i,j)=0;
        end
    end
end
        
figure
imshow(bridge1)

N=8;
I4 = [(4*I+1) (4*I+2);(4*I+3) (4*I)];
I8 = [(4*I4+1) (4*I4+2);(4*I4+3) (4*I4)];

T8=(I8+0.5)*(255/(N^2));

bridge2=bridge;

for i=1:400
    for j=1:600
        if bridge2(i,j)>T8(mod(i,N)+1,mod(j,N)+1)
            bridge2(i,j)=255;
        else
            bridge2(i,j)=0;
        end
    end
end

figure
imshow(bridge2)


N=32;
I16 = [(4*I8+1) (4*I8+2);(4*I8+3) (4*I8)];
I32 = [(4*I16+1) (4*I16+2);(4*I16+3) (4*I16)];

T32=(I32+0.5)*(255/(N^2));

bridge3=bridge;

for i=1:400
    for j=1:600
        if bridge3(i,j)>T32(mod(i,N)+1,mod(j,N)+1)
            bridge3(i,j)=255;
        else
            bridge3(i,j)=0;
        end
    end
end

figure
imshow(bridge3)
