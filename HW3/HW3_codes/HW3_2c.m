clear
f = fopen('rice.raw','r');
data = fread(f,690*500*3,'uint8=>uint8');
j=1;
for i=1:3:(690*500*3)-2
    R(j)=data(i);
    j=j+1;
end
k=1;
for i=2:3:(690*500*3)-1
    G(k)=data(i);
    k=k+1;
end
l=1;
for i=3:3:(690*500*3)
    B(l)=data(i);
    l=l+1;
end

rice_r = reshape(R,690,500)';
rice_g = reshape(G,690,500)';
rice_b = reshape(B,690,500)';


og(:,:,1)=rice_r(:,:);
og(:,:,2)=rice_g(:,:);
og(:,:,3)=rice_b(:,:);

figure
imshow(og)

grayscale = rgb2gray(og);

binary = edge(grayscale,'canny', 0.1);
figure;
imshow(binary)

se90 = strel('line', 2, 90);
se0 = strel('line', 2, 0);
binary2 = imdilate(binary,[se90 se0]);
binary2(203,89)=1;
binary2(203,90)=1;
binary2(203,91)=1;
fill = imfill(binary2,'holes');
fill(353,602)=0;
fill(354,603)=0;
fill(355,604)=0;
fill(356,604)=0;
fill(357,604)=0;
fill(353,601)=0;
fill(354,602)=0;
fill(355,603)=0;
tocount=bwmorph(fill,'shrink',Inf);
count=0;
for p=1:500
    for q=1:690
        if tocount(p,q)==1
            count=count+1;
        end
    end
end
count
        
seDia = strel('diamond',3);
imgfinal = imerode(fill,seDia);

info = regionprops(imgfinal,{'Area','Centroid'});
info = struct2table(info);

figure;
imshow(og)
hold on
for j = 1:height(info)
  text(info.Centroid(j,1), info.Centroid(j,2), num2str(info.Area(j)))
end
type1=zeros(1,5);
type2=zeros(1,5);
type3=zeros(1,5);
type4=zeros(1,5);
type5=zeros(1,5);
type6=zeros(1,5);
type7=zeros(1,5);
type8=zeros(1,5);
type9=zeros(1,5);
type10=zeros(1,5);
type11=zeros(1,5);
v1=1;
v2=1;
v3=1;
v4=1;
v5=1;
v6=1;
v7=1;
v8=1;
v9=1;
v10=1;
v11=1;

for j = 1:height(info)
    if info.Centroid(j,1)<250 && info.Centroid(j,2)<150
        type1(v1)=info.Area(j);
        v1=v1+1;
    elseif info.Centroid(j,1)>250 && info.Centroid(j,1)<500 && info.Centroid(j,2)<150
        type2(v2)=info.Area(j);
        v2=v2+1;
    elseif info.Centroid(j,1)>500 && info.Centroid(j,2)<150
        type3(v3)=info.Area(j);
        v3=v3+1;
    elseif info.Centroid(j,1)<250 && info.Centroid(j,2)>150 && info.Centroid(j,2)<275
        type4(v4)=info.Area(j);
        v4=v4+1;    
    elseif info.Centroid(j,1)>250 && info.Centroid(j,1)<500 && info.Centroid(j,2)>150 && info.Centroid(j,2)<275
        type5(v5)=info.Area(j);
        v5=v5+1; 
    elseif info.Centroid(j,1)>500 && info.Centroid(j,2)>150 && info.Centroid(j,2)<275
        type6(v6)=info.Area(j);
        v6=v6+1; 
    elseif info.Centroid(j,1)<250 && info.Centroid(j,2)>275 && info.Centroid(j,2)<390
        type7(v7)=info.Area(j);
        v7=v7+1;
    elseif info.Centroid(j,1)>250 && info.Centroid(j,1)<500 && info.Centroid(j,2)>275 && info.Centroid(j,2)<390
        type8(v8)=info.Area(j);
        v8=v8+1;   
    elseif info.Centroid(j,1)>500 && info.Centroid(j,2)>275 && info.Centroid(j,2)<390
        type9(v9)=info.Area(j);
        v9=v9+1;   
    elseif info.Centroid(j,1)<350 && info.Centroid(j,2)>390
        type10(v10)=info.Area(j);
        v10=v10+1;  
    elseif info.Centroid(j,1)>350 && info.Centroid(j,2)>390
        type11(v11)=info.Area(j);
        v11=v11+1; 
    end
end

avg=zeros(11,1);
avg(1,1)=mean(type1);
avg(2,1)=mean(type2);
avg(3,1)=mean(type3);
avg(4,1)=mean(type4);
avg(5,1)=mean(type5);
avg(6,1)=mean(type6);
avg(7,1)=mean(type7);
avg(8,1)=mean(type8);
avg(9,1)=mean(type9);
avg(10,1)=mean(type10);
avg(11,1)=mean(type11);

A=zeros(11,2);
for i=1:11
    A(i,1)=i;
    A(i,2)=avg(i,1);
end

sorted=sortrows(A,2);
final=array2table(sorted,'VariableNames',{'Type','Average_Size'});
final