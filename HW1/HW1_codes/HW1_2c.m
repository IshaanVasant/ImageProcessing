f = fopen('pepper_dark.raw','r');
data = fread(f,'uint8=>uint8');
pepper_dark = reshape(data,256,256);
figure
imshow(pepper_dark)

f = fopen('pepper_dark_noise.raw','r');
data = fread(f,'uint8=>uint8');
pepper_dark_noise = reshape(data,256,256);
figure
imshow(pepper_dark_noise)

pep=pepper_dark_noise;
pep1=zeros(256,256);
for i=1:256
    for j=1:256
        pep1(i,j)=2*(sqrt(im2double(pep(i,j)+(3/8))));
    end
end

figure
imshow(pep1)

pep2=im2double(pep1);
pepn=padarray(pep2,[2 2],'symmetric');
pepdn=zeros(256,256);
for i=3:258
    for j=3:258
        a=(41/273)*pepn(i,j);
        b=(26/273)*pepn(i-1,j);
        c=(26/273)*pepn(i+1,j);
        d=(26/273)*pepn(i,j-1);
        e=(26/273)*pepn(i,j+1);
        f=(16/273)*pepn(i-1,j-1);
        g=(16/273)*pepn(i-1,j+1);
        h=(16/273)*pepn(i+1,j-1);
        k=(16/273)*pepn(i+1,j+1);
        l=(7/273)*pepn(i,j-2);
        m=(7/273)*pepn(i,j+2);
        n=(7/273)*pepn(i-2,j);
        o=(7/273)*pepn(i+2,j);
        p=(4/273)*pepn(i-1,j-2);
        q=(1/273)*pepn(i-2,j-2);
        r=(4/273)*pepn(i-2,j-1);
        s=(4/273)*pepn(i-2,j+1);
        t=(1/273)*pepn(i-2,j+2);
        u=(4/273)*pepn(i-1,j+2);
        v=(4/273)*pepn(i+1,j+2);
        w=(1/273)*pepn(i+2,j+2);
        x=(4/273)*pepn(i+2,j+1);
        y=(4/273)*pepn(i+2,j-1);
        z=(1/273)*pepn(i+2,j-2);
        z1=(4/273)*pepn(i+1,j-2);
        sum=a+b+c+d+e+f+g+h+k+l+m+n+o+p+q+r+s+t+u+v+w+x+y+z+z1;
        pepdn(i,j)=sum;
    end
end


pep_dn=pepdn(3:258,3:258);
pep_dn1=zeros(256,256);

for i=1:256
    for j=1:256
        pep_dn1(i,j)=(im2double(pep(i,j))/2)^2 + (3/8);
    end
end

figure
imshow(pep_dn1)
title('Denoised')
        