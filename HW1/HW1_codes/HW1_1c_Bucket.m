f = fopen('rose_dark.raw','r');
data = fread(f,'uint8=>uint8');
r_dark = reshape(data,400,400)';
figure
imshow(r_dark)
title('Original image')

f = fopen('rose_bright.raw','r');
data = fread(f,'uint8=>uint8');
r_bright = reshape(data,400,400)';
figure
imshow(r_bright)
title('Original image')

f = fopen('rose_mix.raw','r');
data = fread(f,'uint8=>uint8');
r_mix = reshape(data,400,400)';
figure
imshow(r_mix)
title('Original image')

bucket(r_dark)
bucket(r_bright)
bucket(r_mix)

function bucket(x)
loc=zeros(2,160000);
m=1;
count=zeros(1,256);
for k=0:255
    for i=1:400
        for j=1:400
            if x(i,j)==k
                count(k+1)=count(k+1)+1;
                loc(1,m)=i;
                loc(2,m)=j;
                m=m+1;
            end
        end
    end
end


arr=zeros(1,160000);
for q=1:256
    for p=((q-1)*625)+1:q*625
        arr(p)=q-1;
    end
end

loc(3,:)=arr;

output_x=x;
for n=1:160000
    output_x(loc(1,n),loc(2,n))=loc(3,n);  
end

figure
imshow(output_x)
title('Enhanced image');

histgram(output_x)
end
    
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
axis([-50 300 0 1000])
xlabel('Intensity')
ylabel('No. of pixels')
end

