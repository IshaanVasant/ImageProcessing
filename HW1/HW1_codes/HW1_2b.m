f = fopen('rose_color.raw','r');
data = fread(f,256*256*3,'uint8=>uint8');
j=1;
for i=1:3:196606
    R(j)=data(i);
    j=j+1;
end
k=1;
for i=2:3:196607
    G(k)=data(i);
    k=k+1;
end
l=1;
for i=3:3:196608
    B(l)=data(i);
    l=l+1;
end

rose_r = reshape(R,256,256)';
rose_b = reshape(B,256,256)';
rose_g = reshape(G,256,256)';

img(:,:,1)=rose_r(:,:);
img(:,:,2)=rose_b(:,:);
img(:,:,3)=rose_g(:,:);
figure
imshow(img)

f = fopen('rose_color_noise.raw','r');
data1 = fread(f,256*256*3,'uint8=>uint8');
j=1;
for i=1:3:196606
    R1(j)=data1(i);
    j=j+1;
end
k=1;
for i=2:3:196607
    G1(k)=data1(i);
    k=k+1;
end
l=1;
for i=3:3:196608
    B1(l)=data1(i);
    l=l+1;
end

rose_r1 = reshape(R1,256,256)';
rose_b1 = reshape(B1,256,256)';
rose_g1 = reshape(G1,256,256)';

img1(:,:,1)=rose_r1(:,:);
img1(:,:,2)=rose_b1(:,:);
img1(:,:,3)=rose_g1(:,:);
figure
imshow(img1)

% % % % % % % % % % 

rosered=im2double(rose_r1);
roseredn=padarray(rosered,[2 2],'symmetric');
rosereddn=zeros(256,256);
for i=3:258
    for j=3:258
        a=roseredn(i,j);
        b=roseredn(i-1,j);
        c=roseredn(i+1,j);
        d=roseredn(i,j-1);
        e=roseredn(i,j+1);
        f=roseredn(i-1,j-1);
        g=roseredn(i-1,j+1);
        h=roseredn(i+1,j-1);
        k=roseredn(i+1,j+1);
        sum=a+b+c+d+e+f+g+h+k;
        rosereddn(i,j)=sum/9;
    end
end

rosered_dn=rosereddn(3:258,3:258);

rosered1=im2double(rosered_dn);
roseredn1=padarray(rosered1,[2 2],'symmetric');
rosereddn1=zeros(256,256);
for i=3:258
    for j=3:258
        a=roseredn1(i,j);
        b=roseredn1(i-1,j);
        c=roseredn1(i+1,j);
        d=roseredn1(i,j-1);
        e=roseredn1(i,j+1);
        f=roseredn1(i-1,j-1);
        g=roseredn1(i-1,j+1);
        h=roseredn1(i+1,j-1);
        k=roseredn1(i+1,j+1);
        X=sort([a b c d e f g h k]);
        rosereddn1(i,j)=X(5);
    end
end

rosered_dn1=rosereddn1(3:258,3:258);

% % % % % % % % % % % % % 

roseblue=im2double(rose_b1);
rosebluen=padarray(roseblue,[2 2],'symmetric');
rosebluedn=zeros(256,256);
for i=3:258
    for j=3:258
        a=rosebluen(i,j);
        b=rosebluen(i-1,j);
        c=rosebluen(i+1,j);
        d=rosebluen(i,j-1);
        e=rosebluen(i,j+1);
        f=rosebluen(i-1,j-1);
        g=rosebluen(i-1,j+1);
        h=rosebluen(i+1,j-1);
        k=rosebluen(i+1,j+1);
        sum=a+b+c+d+e+f+g+h+k;
        rosebluedn(i,j)=sum/9;
    end
end
roseblue_dn=rosebluedn(3:258,3:258);

roseblue1=im2double(roseblue_dn);
rosebluen1=padarray(roseblue1,[2 2],'symmetric');
rosebluedn1=zeros(256,256);
for i=3:258
    for j=3:258
        a=rosebluen1(i,j);
        b=rosebluen1(i-1,j);
        c=rosebluen1(i+1,j);
        d=rosebluen1(i,j-1);
        e=rosebluen1(i,j+1);
        f=rosebluen1(i-1,j-1);
        g=rosebluen1(i-1,j+1);
        h=rosebluen1(i+1,j-1);
        k=rosebluen1(i+1,j+1);
        Y=sort([a b c d e f g h k]);
        rosebluedn1(i,j)=Y(5);
    end
end
roseblue_dn1=rosebluedn1(3:258,3:258);

% % % % % % % % % % % % % % % 

roseg=im2double(rose_g1);
rosegn=padarray(roseg,[2 2],'symmetric');
rosegdn=zeros(256,256);
for i=3:258
    for j=3:258
        a=rosegn(i,j);
        b=rosegn(i-1,j);
        c=rosegn(i+1,j);
        d=rosegn(i,j-1);
        e=rosegn(i,j+1);
        f=rosegn(i-1,j-1);
        g=rosegn(i-1,j+1);
        h=rosegn(i+1,j-1);
        k=rosegn(i+1,j+1);
        sum=a+b+c+d+e+f+g+h+k;
        rosegdn(i,j)=sum/9;
    end
end
roseg_dn=rosegn(3:258,3:258);

roseg1=im2double(roseg_dn);
rosegn1=padarray(roseg1,[2 2],'symmetric');
rosegdn1=zeros(256,256);
for i=3:258
    for j=3:258
        a=rosegn1(i,j);
        b=rosegn1(i-1,j);
        c=rosegn1(i+1,j);
        d=rosegn1(i,j-1);
        e=rosegn1(i,j+1);
        f=rosegn1(i-1,j-1);
        g=rosegn1(i-1,j+1);
        h=rosegn1(i+1,j-1);
        k=rosegn1(i+1,j+1);
        Z=sort([a b c d e f g h k]);
        rosegdn1(i,j)=Z(5);
    end
end
roseg_dn1=rosegn1(3:258,3:258);

% % % % % % % % % % % % % % % 

img2(:,:,1)=rosered_dn(:,:);
img2(:,:,2)=roseblue_dn(:,:);
img2(:,:,3)=roseg_dn(:,:);

figure
imshow(img2)
title('Denoised - After Averaging Filter');

img3(:,:,1)=rosered_dn1(:,:);
img3(:,:,2)=roseblue_dn1(:,:);
img3(:,:,3)=roseg_dn1(:,:);

figure
imshow(img3)
title('Denoised - After Averaging and Median Filter');
