tic
clc;
clear;

f = fopen('pattern1.raw','r');
data = fread(f,'uint8=>uint8');
pat = reshape(data,375,375)';
figure
imshow(pat);

patsize=size(pat);

figure(1)
imshow(pat);

iteration =0;
it=1; 

for i=1:patsize(1)
    for j=1:patsize(2)
    if pat(i,j)<30 
       pat(i,j)=0; 
    else 
        pat(i,j)=255;
    end
    end
end



pat10=zeros(size(pat)+2);
pat10(2:patsize(1)+1,2:patsize(2)+1)=(pat(:,:))./255;

img=pat10;


v=load('kpatcon.mat', 'kpatterncon');

cond=table2array(v.kpatterncon);
sz=size(cond);
flag=true;

while flag
    F_hat=zeros(size(img));
for l=2:376
for m=2:376

    nb=1;
        neighbour=zeros(9,1);
        for p=(l-1):(l+1)
            for q=(m-1):(m+1)
                neighbour(nb)=img(p,q);
                nb=nb+1;
            end
        end
        
         for a=1:sz(2)
                if neighbour==cond(:,a)
                    F_hat(l,m)=1;
               end
          end
end
end

out=zeros(size(F_hat));

for j=2:376
for k=2:376
    
    if F_hat(j,k)==0
        out(j,k)=img(j,k);
    elseif F_hat(j,k)==1
        nb=1;
        window=zeros(9,1);
             
                for p=(j-1):(j+1)
                for q=(k-1):(k+1)
                
                window(nb)=F_hat(p,q);
                nb=nb+1;
                end
                
                end
        M=uncond_skel(window);
                if M==1
                    out(j,k)=img(j,k);
                end
    end
    
   
    
end
end

nb=1;
count=0;

for x=2:376
    for y=2:376
            if out(x,y)==1 
            if (out(x-1,y-1)==0&&out(x,y-1)==0&&out(x+1,y-1)==0&&out(x-1,y)==0&&out(x+1,y)==0&&out(x-1,y+1)==0&&out(x,y+1)==0&&out(x+1,y+1)==0)
                  count=count+1;

            end
            end
         
    end
end

       count_arr(it)=count;    
       count=0;   
       it=it+1;
       
        if img==out
            flag=false;
            break;
        
        else
          img=out;
          iteration=iteration+1;
          it=it+1;
        end
end
figure
imshow(out*255);
toc

function M = uncond_skel(a)

m1 = ~a(1)&&~a(2)&&~a(3)&&~a(4)&&~a(6)&&~a(7)&&~a(8)&&(a(9));
m2 = ~a(1)&&~a(2)&&~a(3)&&~a(4)&&~a(6)&& (a(7))&&~a(8)&&~a(9);
m3 = ~a(1)&&~a(2)&&(a(3))&&~a(4)&&~a(6)&&~a(7)&&~a(8)&&~a(9);
m4 = (a(1))&&~a(2)&&~a(3)&&~a(4)&&~a(6)&&~a(7)&&~a(8)&&~a(9);
m5 = ~a(1)&&~a(2)&&~a(3)&&~a(4)&&~a(6)&&~a(7)&&(a(8))&&~a(9);
m6 = ~a(1)&&~a(2)&&~a(3)&&~a(4)&&(a(6))&&~a(7)&&~a(8)&&~a(9);
m7 = ~a(1)&&~a(2)&&~a(3)&&(a(4))&&~a(6)&&~a(7)&&~a(8)&&~a(9);
m8 = ~a(1)&&(a(2))&&~a(3)&&~a(4)&&~a(6)&&~a(7)&&~a(8)&&~a(9);
m9  = ~a(1)&&(a(2))&&~a(3)&&~a(4)&&(a(6))&&~a(7)&&~a(8)&&~a(9);
m10 = ~a(1)&&(a(2))&&~a(3)&&(a(4))&&~a(6)&&~a(7)&&~a(8)&&~a(9);
m11 = ~a(1)&&~a(2)&&~a(3)&&~a(4)&&(a(6))&&~a(7)&&(a(8))&&~a(9);
m12 = ~a(1)&&~a(2)&&~a(3)&&(a(4))&&~a(6)&&~a(7)&&(a(8))&&~a(9);
m13 = (a(1))&&(a(2))&&(a(4));
m14 = (a(4))&&(a(8))&&(a(9));
m15 = (a(2))&&(a(4))&&(a(6));
m16 = (a(2))&&(a(4))&&(a(8));
m17 = (a(4))&&(a(6))&&(a(8));
m18 = (a(2))&&(a(6))&&(a(8));
m19 = (a(1))&&(a(3))&& (a(7)||a(8)||a(9));
m20 = (a(1))&&(a(7))&& (a(9)||a(6)||a(3));
m21 = (a(7))&&(a(9))&& (a(3)||a(2)||a(1));
m22 = (a(3))&&(a(9))&& (a(1)||a(4)||a(7));
m23 = (a(2))&&(a(6))&&(a(7))&&~a(3)&&~a(4)&&~a(8);
m24 = (a(2))&&(a(4))&&(a(9))&&~a(1)&&~a(6)&&~a(8);
m25 = (a(3))&&(a(4))&&(a(8))&&~a(2)&&~a(6)&&~a(7);
m26 = (a(1))&&(a(6))&&(a(8))&&~a(2)&&~a(4)&&~a(9);

M_1 = m1||m2||m3||m4||m5||m6||m7||m8||m9||m10||m11||m12||m13||m14||m15||m16||m17||m18||m19||m20||m21||m22||m23||m24||m25||m26;

if(M_1) 
    M = 1;
else
    M = 0;
end
end