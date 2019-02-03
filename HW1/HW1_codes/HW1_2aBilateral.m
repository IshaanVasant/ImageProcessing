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
wsum=0;
numsum=0;
sigc=3;
sigs=50;
for i=3:258
    for j=3:258
        for k=i-1:i+1
            for l=j-1:j+1
                w=exp(-((((i-k)^2)+((j-l)^2))/(2*sigc*sigc))-(((pepn(i,j)-pepn(k,l))^2)/(2*sigs*sigs)));
                wsum=wsum+w;
                numsum=numsum+(pepn(k,l)*w);
            end
        end
        pepdn(i,j)=numsum/wsum;
    end
end


pep_dn=pepdn(3:258,3:258);

figure
imshow(pep_dn)

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