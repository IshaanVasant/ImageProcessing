clear
f = fopen('bird.raw','r');
data = fread(f,500*375*3,'uint8=>uint8');
j=1;
for i=1:3:(500*375*3)-2
    R(j)=data(i);
    C(j)=255-R(j);
    j=j+1;
end
k=1;
for i=2:3:(500*375*3)-1
    G(k)=data(i);
    M(k)=255-G(k);
    k=k+1;
end
l=1;
for i=3:3:(500*375*3)
    B(l)=data(i);
    Y(l)=255-B(l);
    l=l+1;
end

bird_r = reshape(R,500,375)';
bird_g = reshape(G,500,375)';
bird_b = reshape(B,500,375)';


original(:,:,1)=bird_r(:,:);
original(:,:,2)=bird_g(:,:);
original(:,:,3)=bird_b(:,:);

figure
imshow(original)

bird_c = reshape(C,500,375)';
bird_m = reshape(M,500,375)';
bird_y = reshape(Y,500,375)';

img1(:,:,1)=bird_c(:,:);
img1(:,:,2)=bird_m(:,:);
img1(:,:,3)=bird_y(:,:);
figure
imshow(img1)

bird_c_ed=error_diffusion(bird_c);
bird_m_ed=error_diffusion(bird_m);
bird_y_ed=error_diffusion(bird_y);

final(:,:,1)=bird_c_ed(:,:);
final(:,:,2)=bird_m_ed(:,:);
final(:,:,3)=bird_y_ed(:,:);
% figure
% imshow(final)

bird_r_ed=zeros(375,500);
bird_g_ed=zeros(375,500);
bird_b_ed=zeros(375,500);

for i=1:375
    for j=1:500
        bird_r_ed(i,j)=255-bird_c_ed(i,j);
        bird_g_ed(i,j)=255-bird_m_ed(i,j);
        bird_b_ed(i,j)=255-bird_y_ed(i,j);
    end
end

% bird_r_ed=error_diffusion(bird_r);
% bird_g_ed=error_diffusion(bird_g);
% bird_b_ed=error_diffusion(bird_b);

final1(:,:,1)=bird_r_ed(:,:);
final1(:,:,2)=bird_g_ed(:,:);
final1(:,:,3)=bird_b_ed(:,:);
figure
imshow(final1)

function img4= error_diffusion(img)

FSmatrix=(1/16)*[0 0 0;0 0 7;3 5 1];
FSmatrix_flipped=(1/16)*[0 0 0;7 0 0;1 5 3];

img2=padarray(img,[1 1],'symmetric');
img3=img2;
err=zeros(377,502);

for i= 2:376
    if(mod(i,2)==0)
    for j = 2:501
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
    for j = 501:-1:2
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

img4=img3(2:376,2:501);

end
