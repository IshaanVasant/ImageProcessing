f = fopen('pepper.raw','r');
data = fread(f,'uint8=>uint8');
pepper = reshape(data,256,256)';
figure
imshow(pepper)

f = fopen('pepper_uni.raw','r');
data = fread(f,'uint8=>uint8');
pepper_uni = reshape(data,256,256)';
figure
imshow(pepper_uni)

pep2=im2double(pepper_uni);
pepn=padarray(pep2,[2 2],'symmetric');
pepdn=zeros(256,256);
for i=3:258
    for j=3:258
        a=pepn(i,j);
        b=pepn(i-1,j);
        c=pepn(i+1,j);
        d=pepn(i,j-1);
        e=pepn(i,j+1);
        f=pepn(i-1,j-1);
        g=pepn(i-1,j+1);
        h=pepn(i+1,j-1);
        k=pepn(i+1,j+1);
        sum=a+b+c+d+e+f+g+h+k;
        pepdn(i,j)=sum/9;
    end
end


pep_dn=pepdn(3:258,3:258);

figure
imshow(pep_dn)
title('Denoised')

sum1=0;
for i=1:256
    for j=1:256
        err=(im2double(pepper(i,j))-im2double(pep_dn(i,j)))^2;
        sum1=sum1+err;
    end
end
mse=sum1/(256*256);
mse
max=255;
psnr=10*log10((max^2)/mse);
psnr