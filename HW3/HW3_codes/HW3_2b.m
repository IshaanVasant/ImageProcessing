f = fopen('deer.raw','r');
data = fread(f,'uint8=>uint8');
deer = reshape(data,550,691)';

img=padarray(deer,[1 1],'symmetric');
window=[255;255;255;255;0;255;255;255;255];
z=1;

for i=2:692
    for j=2:551
        k=1;
        mat=zeros(9,1);
        for l=(i-1):(i+1)
            for m=(j-1):(j+1)
                mat(k)=img(l,m);
                k=k+1;
            end
        end
        
        if mat==window
            loc(z,1)=i;
            loc(z,2)=j;
            z=z+1;
        end
    end
end
figure
imshow(img)

for k=1:5
i=loc(k,2);
j=loc(k,1);
r=7;
hold on
th = 0:pi/50:2*pi;
xunit = r * cos(th) + i;
yunit = r * sin(th) + j;
h = plot(xunit, yunit,'b-','LineWidth',2);
hold off
end


for i=2:692
    for j=2:551
        k=1;
        mat=zeros(9,1);
        for l=(i-1):(i+1)
            for m=(j-1):(j+1)
                mat(k)=img(l,m);
                k=k+1;
            end
        end
        
        if mat==window
            loc(z,1)=i;
            loc(z,2)=j;
            z=z+1;
            img(i,j)=255;
        end
    end
end
figure
imshow(img)