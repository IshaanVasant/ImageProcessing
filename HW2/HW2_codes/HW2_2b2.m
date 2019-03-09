f = fopen('bridge.raw','r');
data = fread(f,'uint8=>uint8');
img = reshape(data,600,400)';

JJNmatrix=(1/48)*[0 0 0 0 0;0 0 0 0 0;0 0 0 7 5;3 5 7 5 3;1 3 5 3 1];
JJNmatrix_flipped=(1/48)*[0 0 0 0 0;0 0 0 0 0;5 7 0 0 0;3 5 7 5 3;1 3 5 3 1];

img2=padarray(img,[2 2],'symmetric');
img3=img2;
err=zeros(404,604);

for i= 3:402
    if(mod(i,2)==1)
    for j = 3:602
        if(img2(i,j)>127)
            img3(i,j)=255;
        else
            img3(i,j)=0;
        end
        err(i,j)=img2(i,j)-img3(i,j);
        diffusion=err(i,j)*JJNmatrix;

        for k = -2:2
            for l = -2:2
               img2(i+k,j+l)=img2(i+k,j+l)+diffusion(k+3,l+3);
            end
        end
    end
    else
    for j = 602:-1:3
        if(img2(i,j)>127)
            img3(i,j)=255;
        else
            img3(i,j)=0;
        end
        err(i,j)=img2(i,j)-img3(i,j);
        diffusion=err(i,j)*JJNmatrix_flipped;
        
        for k = -2:2
            for l = -2:2
               img2(i+k,j+l)=img2(i+k,j+l)+diffusion(k+3,l+3);
            end
        end
    end
    end
    
end

img4=img3(3:402,3:602);

figure;
imshow(img4);