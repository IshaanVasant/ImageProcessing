clear
clc
f = fopen('lighthouse.raw','r');
data = fread(f,'uint8=>uint8');
liho = reshape(data,512,512)';
figure
imshow(liho)

f = fopen('lighthouse1.raw','r');
data = fread(f,'uint8=>uint8');
liho1 = reshape(data,256,256)';
figure
imshow(liho1)

f = fopen('lighthouse2.raw','r');
data = fread(f,'uint8=>uint8');
liho2 = reshape(data,256,256)';
figure
imshow(liho2)

f = fopen('lighthouse3.raw','r');
data = fread(f,'uint8=>uint8');
liho3 = reshape(data,256,256)';
figure
imshow(liho3)
flag=0;
for x=1:256
    for y=1:256
        if liho1(x,y)~=255
            x1=x;
            y1=y;
            X1=x1+0.5;
            Y1=256-y1-0.5;
            flag=1;
        end
        if(flag==1)
            break;
        end
    end
    if(flag==1)
        break;
    end
end

flag=0;
for x=256:-1:1
    for y=256:-1:1
        if liho1(x,y)~=255
            x2=x;
            y2=y;
            X2=x2+0.5;
            Y2=256-y2-0.5;
            flag=1;
        end
        if(flag==1)
            break;
        end
    end
    if(flag==1)
        break;
    end
end

flag=0;
for y=1:256
    for x=1:256
        if liho1(x,y)~=255
            x3=x;
            y3=y;
            X3=x3+0.5;
            Y3=256-y3-0.5;
            flag=1;
        end
        if(flag==1)
            break;
        end
    end
    if(flag==1)
        break;
    end
end

flag=0;
for y=256:-1:1
    for x=256:-1:1
        if liho1(x,y)~=255
            x4=x;
            y4=y;
            X4=x4+0.5;
            Y4=256-y4-0.5;
            flag=1;
        end
        if(flag==1)
            break;
        end
    end
    if(flag==1)
        break;
    end
end

theta1=atand((X4-X2)/(Y4-Y2));
Xc=round((X3+X4)/2);
Yc=round((Y3+Y4)/2);
width=round(sqrt((X1-X3)^2 + (Y1-Y3)^2));
height=round(sqrt((X1-X4)^2 + (Y1-Y4)^2));

output=zeros(height,width);


out=imrotate(liho1,-theta1,'bilinear');
out1=out(138:249,95:206);
imshow(out1)

out2=imresize(out1,164/112);
imshow(out2)

flag=0;
for y=1:256
    for x=1:256
        if liho(x,y)==255
            x5=x;
            y5=y;
%             X1=x1+0.5;
%             Y1=256-y1-0.5;
            flag=1;
        end
        if(flag==1)
            break;
        end
    end
    if(flag==1)
        break;
    end
end
lihouse=liho;
lihouse(x5:x5+159,y5:y5+159)=out2(3:162,3:162);
imshow(lihouse)






flag=0;
for x=1:256
    for y=1:256
        if liho2(x,y)~=255
            x1=x;
            y1=y;
            X1=x1+0.5;
            Y1=256-y1-0.5;
            flag=1;
        end
        if(flag==1)
            break;
        end
    end
    if(flag==1)
        break;
    end
end

flag=0;
for x=256:-1:1
    for y=256:-1:1
        if liho2(x,y)~=255
            x2=x;
            y2=y;
            X2=x2+0.5;
            Y2=256-y2-0.5;
            flag=1;
        end
        if(flag==1)
            break;
        end
    end
    if(flag==1)
        break;
    end
end

flag=0;
for y=1:256
    for x=1:256
        if liho2(x,y)~=255
            x3=x;
            y3=y;
            X3=x3+0.5;
            Y3=256-y3-0.5;
            flag=1;
        end
        if(flag==1)
            break;
        end
    end
    if(flag==1)
        break;
    end
end

flag=0;
for y=256:-1:1
    for x=256:-1:1
        if liho2(x,y)~=255
            x4=x;
            y4=y;
            X4=x4+0.5;
            Y4=256-y4-0.5;
            flag=1;
        end
        if(flag==1)
            break;
        end
    end
    if(flag==1)
        break;
    end
end

theta2=atand((X4-X2)/(Y4-Y2));
Xc=round((X3+X4)/2);
Yc=round((Y3+Y4)/2);
width=round(sqrt((X1-X3)^2 + (Y1-Y3)^2));
height=round(sqrt((X1-X4)^2 + (Y1-Y4)^2));

output=zeros(height,width);

out=imrotate(liho2,-theta2-90,'bilinear');

imshow(out)


out1=out(111:257,129:275);

out2=imresize(out1,164/146);
imshow(out2)

flag=0;
for x=1:512
    for y=1:512
        if liho(x,y)==255
            x6=x;
            y6=y;
%             X1=x1+0.5;
%             Y1=256-y1-0.5;
            flag=1;
        end
        if(flag==1)
            break;
        end
    end
    if(flag==1)
        break;
    end
end
lihouse2=lihouse;
lihouse2(x6:x6+159,y6:y6+159)=out2(4:163,3:162);
imshow(lihouse2)







flag=0;
for x=1:256
    for y=1:256
        if liho3(x,y)~=255
            x1=x;
            y1=y;
            X1=x1+0.5;
            Y1=256-y1-0.5;
            flag=1;
        end
        if(flag==1)
            break;
        end
    end
    if(flag==1)
        break;
    end
end

flag=0;
for x=256:-1:1
    for y=256:-1:1
        if liho3(x,y)~=255
            x2=x;
            y2=y;
            X2=x2+0.5;
            Y2=256-y2-0.5;
            flag=1;
        end
        if(flag==1)
            break;
        end
    end
    if(flag==1)
        break;
    end
end

flag=0;
for y=1:256
    for x=1:256
        if liho3(x,y)~=255
            x3=x;
            y3=y;
            X3=x3+0.5;
            Y3=256-y3-0.5;
            flag=1;
        end
        if(flag==1)
            break;
        end
    end
    if(flag==1)
        break;
    end
end

flag=0;
for y=256:-1:1
    for x=256:-1:1
        if liho3(x,y)~=255
            x4=x;
            y4=y;
            X4=x4+0.5;
            Y4=256-y4-0.5;
            flag=1;
        end
        if(flag==1)
            break;
        end
    end
    if(flag==1)
        break;
    end
end

theta3=atand((X4-X2)/(Y4-Y2));
Xc=round((X3+X4)/2);
Yc=round((Y3+Y4)/2);
width=round(sqrt((X1-X3)^2 + (Y1-Y3)^2));
height=round(sqrt((X1-X4)^2 + (Y1-Y4)^2));

output=zeros(height,width);

out=imrotate(liho3,-theta3-270,'bilinear');

imshow(out)



out1=out(42:256,42:256);
imshow(out1)


out2=imresize(out1,164/214);
imshow(out2)

flag=0;
for x=512:-1:256
    for y=512:-1:256
        if liho(x,y)==255
            x7=x;
            y7=y;
%             X1=x1+0.5;
%             Y1=256-y1-0.5;
            flag=1;
        end
        if(flag==1)
            break;
        end
    end
    if(flag==1)
        break;
    end
end
lihouse3=lihouse2;
lihouse3(x7-159:x7-159+159,y7-159:y7-159+159)=out2(4:163,4:163);
imshow(lihouse3)

