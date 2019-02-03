f = fopen('rose_dark.raw','r');
data = fread(f,'uint8=>uint8');
r_dark = reshape(data,400,400)';
figure
imshow(r_dark)

f = fopen('rose_bright.raw','r');
data = fread(f,'uint8=>uint8');
r_bright = reshape(data,400,400)';
figure
imshow(r_bright)

f = fopen('rose_mix.raw','r');
data = fread(f,'uint8=>uint8');
r_mix = reshape(data,400,400)';
figure
imshow(r_mix)

histgram(r_dark)
equalize(r_dark)

histgram(r_bright)
equalize(r_bright)

histgram(r_mix)
equalize(r_mix)

function histgram(x)
xval=(0:255);
count=zeros(1,256);
for i=1:400
    for j=1:400
        for k=0:255
            if x(i,j)==k
                count(k+1)=count(k+1)+1;
            end
        end
    end
end
figure
bar(xval,count)
axis([0 255 0 3000])
xlabel('Intensity')
ylabel('No. of pixels')
end
function equalize(x)

count=zeros(1,256);
for i=1:400
    for j=1:400
        for k=0:255
            if x(i,j)==k
                count(k+1)=count(k+1)+1;
            end
        end
    end
end
count1=count/160000;
count_cdf=zeros(1,256);

sum=0;
for i=1:256
    count_cdf(i)=count1(i)+sum;
    sum=count_cdf(i);
end
count_cdf1=count_cdf*255;
count_cdf2=floor(count_cdf1);
figure
plot(count_cdf2)
title('Transfer Function')

eq=x;
for i=1:400
    for j=1:400
        for k=0:255
            if x(i,j)==k
                eq(i,j)=count_cdf2(k+1);
            end
        end
    end
end
figure
imshow(eq)
histgram(eq)
end