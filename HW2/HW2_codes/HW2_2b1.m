f = fopen('bridge.raw','r');
data = fread(f,'uint8=>uint8');
img = reshape(data,600,400)';

FSmatrix=(1/16)*[0 0 0;0 0 7;3 5 1];
FSmatrix_flipped=(1/16)*[0 0 0;7 0 0;1 5 3];

img2=padarray(img,[1 1],'symmetric');
img3=img2;
err=zeros(402,602);

for i= 2:401
    if(mod(i,2)==0)
    for j = 2:601
        if(img2(i,j)>127)
            img3(i,j)=255;
        else
            img3(i,j)=0;
        end
        err(i,j)=img2(i,j)-img3(i,j);
        diffusion=err(i,j)*FSmatrix;

        for k = -1:1
            for l = -1:1
               img2(i+k,j+l)=img2(i+k,j+l)+diffusion(k+2,l+2);
            end
        end
    end
    else
    for j = 601:-1:2
        if(img2(i,j)>127)
            img3(i,j)=255;
        else
            img3(i,j)=0;
        end
        err(i,j)=img2(i,j)-img3(i,j);
        diffusion=err(i,j)*FSmatrix_flipped;
        
        for k = -1:1
            for l = -1:1
               img2(i+k,j+l)=img2(i+k,j+l)+diffusion(k+2,l+2);
            end
        end
    end
    end
    
end

img4=img3(2:401,2:601);

figure;
imshow(img4);