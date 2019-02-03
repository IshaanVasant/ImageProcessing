f = fopen('cat.raw','r');
data = fread(f,'uint8=>uint8');
img = reshape(data,390,300)';
figure
imshow(img);

R1=zeros(300,390,'uint8');
G1=zeros(300,390,'uint8');
B1=zeros(300,390,'uint8');

for i=1:300
    for j=1:390
        if rem(i,2)~=0 && rem(j,2)==0 %Red location
            R1(i,j)=img(i,j);
        elseif rem(i,2)==0 && rem(j,2)~=0 %Blue location
            B1(i,j)=img(i,j);
        else %Green location
            G1(i,j)=img(i,j);
        end
    end
end

R=padarray(R1,[2 2],'symmetric');
G=padarray(G1,[2 2],'symmetric');
B=padarray(B1,[2 2],'symmetric');

for i=3:302
    for j=3:392
        if rem(i,2)~=0 && rem(j,2)==0 %Red location
            B(i,j)=0.25*(B(i-1,j-1)+B(i-1,j+1)+B(i+1,j-1)+B(i+1,j+1)); %Estimating B
            G(i,j)=0.25*(G(i,j-1)+G(i,j+1)+G(i-1,j)+G(i+1,j)); %Estimating G
        elseif rem(i,2)==0 && rem(j,2)~=0 %Blue location
            R(i,j)=0.25*(R(i-1,j-1)+R(i-1,j+1)+R(i+1,j-1)+R(i+1,j+1)); %Estimating R
            G(i,j)=0.25*(G(i,j-1)+G(i,j+1)+G(i-1,j)+G(i+1,j)); %Estimating G
        else %Green location
            R(i,j)=0.5*(R(i,j-1)+R(i,j+1)); %Estimating R
            B(i,j)=0.5*(B(i-1,j)+B(i+1,j)); %Estimating B
        end
    end
end
R_est=R(3:302,3:392);
G_est=G(3:302,3:392);
B_est=B(3:302,3:392);

img1=img;
img1(:,:,1)=R_est(:,:);
img1(:,:,2)=G_est(:,:);
img1(:,:,3)=B_est(:,:);
figure
imshow(img1);
