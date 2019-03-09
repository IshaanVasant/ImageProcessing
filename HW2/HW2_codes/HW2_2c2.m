clear
f = fopen('bird.raw','r');
data = fread(f,500*375*3,'uint8=>uint8');
j=1;
for i=1:3:(500*375*3)-2
    R1(j)=data(i);
    j=j+1;
end
k=1;
for i=2:3:(500*375*3)-1
    G1(k)=data(i);
    k=k+1;
end
l=1;
for i=3:3:(500*375*3)
    B1(l)=data(i);
    l=l+1;
end

R2 = reshape(R1,500,375)';
G2 = reshape(G1,500,375)';
B2 = reshape(B1,500,375)';


original(:,:,1)=R2(:,:);
original(:,:,2)=G2(:,:);
original(:,:,3)=B2(:,:);

figure
imshow(original)

R=padarray(R2,[1 1],'symmetric');
G=padarray(G2,[1 1],'symmetric');
B=padarray(B2,[1 1],'symmetric');

FSmatrix=(1/16)*[0 0 0;0 0 7;3 5 1];
FSmatrix_flipped=(1/16)*[0 0 0;7 0 0;1 5 3];

% For R
outputR=R;
err=zeros(377,502);
v=zeros(1,3);

for i= 2:376
    if(mod(i,2)==0)
    for j = 2:501
%         if(R(i,j)>127)
%             img3(i,j)=255;
%         else
%             img3(i,j)=0;
%         end
        mbvq=getMBVQ(R(i,j),G(i,j),B(i,j));
        v = getNearestVertex(mbvq,R(i,j),G(i,j),B(i,j));
        
        err(i,j)=R(i,j)-v(1);
        diffusion=err(i,j)*FSmatrix;

        for k = -1:1
            for l = -1:1
               R(i+k,j+l)=R(i+k,j+l)+diffusion(k+2,l+2);
            end
        end
        outputR(i,j)=v(1);
    end
    else
    for j = 501:-1:2
%         if(R(i,j)>127)
%             img3(i,j)=255;
%         else
%             img3(i,j)=0;
%         end
        mbvq=getMBVQ(R(i,j),G(i,j),B(i,j));
        v = getNearestVertex(mbvq,R(i,j),G(i,j),B(i,j));
        
        err(i,j)=R(i,j)-v(1);
        diffusion=err(i,j)*FSmatrix_flipped;
        
        for k = -1:1
            for l = -1:1
               R(i+k,j+l)=R(i+k,j+l)+diffusion(k+2,l+2);
            end
        end
        outputR(i,j)=v(1);
    end
    end
    
end


img6=outputR(2:376,2:501);





% For G
outputG=G;
err=zeros(377,502);

for i= 2:376
    if(mod(i,2)==0)
    for j = 2:501
%         if(G(i,j)>127)
%             img4(i,j)=255;
%         else
%             img4(i,j)=0;
%         end
        mbvq=getMBVQ(R(i,j),G(i,j),B(i,j));
        v = getNearestVertex(mbvq,R(i,j),G(i,j),B(i,j));
       
        
        err(i,j)=G(i,j)-v(2);
        diffusion=err(i,j)*FSmatrix;

        for k = -1:1
            for l = -1:1
               G(i+k,j+l)=G(i+k,j+l)+diffusion(k+2,l+2);
            end
        end
        outputG(i,j)=v(2);
    end
    else
    for j = 501:-1:2
%         if(G(i,j)>127)
%             img4(i,j)=255;
%         else
%             img4(i,j)=0;
%         end
        mbvq=getMBVQ(R(i,j),G(i,j),B(i,j));
        v = getNearestVertex(mbvq,R(i,j),G(i,j),B(i,j));
        
        
        err(i,j)=G(i,j)-v(2);
        diffusion=err(i,j)*FSmatrix_flipped;
        
        for k = -1:1
            for l = -1:1
               G(i+k,j+l)=G(i+k,j+l)+diffusion(k+2,l+2);
            end
        end
        outputG(i,j)=v(2);
    end
    end
    
end



img7=outputG(2:376,2:501);




% For B
outputB=B;
err=zeros(377,502);

for i= 2:376
    if(mod(i,2)==0)
    for j = 2:501
%         if(B(i,j)>127)
%             img5(i,j)=255;
%         else
%             img5(i,j)=0;
%         end
        mbvq=getMBVQ(R(i,j),G(i,j),B(i,j));
        v = getNearestVertex(mbvq,R(i,j),G(i,j),B(i,j));
        
        
        err(i,j)=B(i,j)-v(3);
        diffusion=err(i,j)*FSmatrix;

        for k = -1:1
            for l = -1:1
               B(i+k,j+l)=B(i+k,j+l)+diffusion(k+2,l+2);
            end
        end
        outputB(i,j)=v(3);
    end
    else
    for j = 501:-1:2
%         if(B(i,j)>127)
%             img5(i,j)=255;
%         else
%             img5(i,j)=0;
%         end
        mbvq=getMBVQ(R(i,j),G(i,j),B(i,j));
        v = getNearestVertex(mbvq,R(i,j),G(i,j),B(i,j));
        
        
        err(i,j)=B(i,j)-v(3);
        diffusion=err(i,j)*FSmatrix_flipped;
        
        for k = -1:1
            for l = -1:1
               B(i+k,j+l)=B(i+k,j+l)+diffusion(k+2,l+2);
            end
        end
        outputB(i,j)=v(3);
    end
    end
    
end

img8=outputB(2:376,2:501);

img9(:,:,1)=img6(:,:);
img9(:,:,2)=img7(:,:);
img9(:,:,3)=img8(:,:);

figure
imshow(img9)

function mbvq=getMBVQ(R,G,B)
if ((R+G)>255)
    if ((G+B)>255)
        if ((R+B+G)>510)
            mbvq='CMYW';
        else
            mbvq='MYGC';
        end
    else
        mbvq='RGMY';
    end    
else
    if (~((G+B)>255))
        if (~((R+B+G)>255))
            mbvq='KRGB';
        else
            mbvq='RGBM';
        end
    else
        mbvq='CMGB';
    end
end
end

% function v=getVertexValue(vertex)
% 
% if vertex == 'white'
%     r=255;g=255;b=255;
% elseif vertex == 'yellow'
%         r=255;g=255;b=0;
% elseif vertex == 'cyan'
%         r=0;g=255;b=255;
% elseif vertex == 'green'
%         r=0;g=255;b=0;
% elseif vertex == 'magenta'
%         r=255;g=0;b=255;        
% elseif vertex == 'red'
%         r=255;g=0;b=0;
% elseif vertex == 'blue'
%         r=0;g=0;b=255;
% elseif vertex == 'black'
%         r=0;g=0;b=0;
% end
% 
% v=[r g b];
% 
% end
        
    
    
    