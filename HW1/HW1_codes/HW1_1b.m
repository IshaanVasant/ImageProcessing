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

alpha=1/2;
beta=5/8;
gamma=3/4;

for i=3:302
    for j=3:392
        if rem(i,2)~=0 && rem(j,2)==0 %Red location
            B(i,j)=0.25*(B(i-1,j-1)+B(i-1,j+1)+B(i+1,j-1)+B(i+1,j+1)) + gamma*(R(i,j)-0.25*(R(i-2,j)+R(i+2,j)+R(i,j-2)+R(i,j+2))); %Estimating B
            G(i,j)=0.25*(G(i,j-1)+G(i,j+1)+G(i-1,j)+G(i+1,j)) + alpha*(R(i,j)-0.25*(R(i-2,j)+R(i+2,j)+R(i,j-2)+R(i,j+2)));%Estimating G
        elseif rem(i,2)==0 && rem(j,2)~=0 %Blue location
            R(i,j)=0.25*(R(i-1,j-1)+R(i-1,j+1)+R(i+1,j-1)+R(i+1,j+1)) + gamma*(B(i,j)-0.25*(B(i-2,j)+B(i+2,j)+B(i,j-2)+B(i,j+2)));%Estimating R
            G(i,j)=0.25*(G(i,j-1)+G(i,j+1)+G(i-1,j)+G(i+1,j)) + alpha*(B(i,j)-0.25*(B(i-2,j)+B(i+2,j)+B(i,j-2)+B(i,j+2)));%Estimating G
        else %Green location
            if rem(i,2)~=0 %R row, B col
                R(i,j)=0.5*(R(i,j-1)+R(i,j+1)) + beta*(G(i,j)-0.2*(G(i,j-2)+G(i,j+2)+G(i-1,j-1)+G(i-1,j+1)+G(i+1,j-1)+G(i+1,j+1))+0.1*(G(i-2,j)+G(i+2,j)));%Estimating R
                B(i,j)=0.5*(B(i-1,j)+B(i+1,j)) + beta*(G(i,j)-0.2*(G(i-2,j)+G(i+2,j)+G(i-1,j-1)+G(i-1,j+1)+G(i+1,j-1)+G(i+1,j+1))+0.1*(G(i,j-2)+G(i,j+2)));%Estimating B
            else %B row, R col
                R(i,j)=0.5*(R(i,j-1)+R(i,j+1)) + beta*(G(i,j)-0.2*(G(i-2,j)+G(i+2,j)+G(i-1,j-1)+G(i-1,j+1)+G(i+1,j-1)+G(i+1,j+1))+0.1*(G(i,j-2)+G(i,j+2)));%Estimating R
                B(i,j)=0.5*(B(i-1,j)+B(i+1,j)) + beta*(G(i,j)-0.2*(G(i,j-2)+G(i,j+2)+G(i-1,j-1)+G(i-1,j+1)+G(i+1,j-1)+G(i+1,j+1))+0.1*(G(i-2,j)+G(i+2,j)));%Estimating B
            end
        end
    end
end
R_MHC=R(3:302,3:392);
G_MHC=G(3:302,3:392);
B_MHC=B(3:302,3:392);

img2=img;
img2(:,:,1)=R_MHC(:,:);
img2(:,:,2)=G_MHC(:,:);
img2(:,:,3)=B_MHC(:,:);
figure
imshow(img2);
