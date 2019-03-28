tic
clc;
clear all;

f = fopen('comb.raw','r'); data = fread(f,'uint8=>uint8'); comb1 = reshape(data,510,510)';
figure
imshow(comb1);

comb2=submean1(comb1);
comb=padarray(comb2,[2 2],'symmetric');

L5=[1 4 6 4 1];
E5=[-1 -2 0 2 1];
S5=[-1 0 2 0 -1];
W5=[-1 2 0 -2 1];
R5=[1 -4 6 -4 1];

L5L5= (L5')*(L5);
L5E5= (L5')*(E5);
L5S5= (L5')*(S5);
L5W5= (L5')*(W5);
L5R5= (L5')*(R5);

E5L5= (E5')*(L5);
E5E5= (E5')*(E5);
E5S5= (E5')*(S5);
E5W5= (E5')*(W5);
E5R5= (E5')*(R5);

S5L5= (S5')*(L5);
S5E5= (S5')*(E5);
S5S5= (S5')*(S5);
S5W5= (S5')*(W5);
S5R5= (S5')*(R5);

W5L5= (W5')*(L5);
W5S5= (W5')*(S5);
W5E5= (W5')*(E5);
W5W5= (W5')*(W5);
W5R5= (W5')*(R5);

R5L5= (R5')*(L5);
R5E5= (R5')*(S5);
R5S5= (R5')*(E5);
R5W5= (R5')*(W5);
R5R5= (R5')*(R5);

mask(:,:,1)=L5L5;
mask(:,:,2)=L5E5;
mask(:,:,3)=L5S5;
mask(:,:,4)=L5W5;
mask(:,:,5)=L5R5;
mask(:,:,6)=E5L5;
mask(:,:,7)=E5E5;
mask(:,:,8)=E5S5;
mask(:,:,9)=E5W5;
mask(:,:,10)=E5R5;
mask(:,:,11)=S5L5;
mask(:,:,12)=S5E5;
mask(:,:,13)=S5S5;
mask(:,:,14)=S5W5;
mask(:,:,15)=S5R5;
mask(:,:,16)=W5L5;
mask(:,:,17)=W5E5;
mask(:,:,18)=W5S5;
mask(:,:,19)=W5W5;
mask(:,:,20)=W5R5;
mask(:,:,21)=R5L5;
mask(:,:,22)=R5E5;
mask(:,:,23)=R5S5;
mask(:,:,24)=R5W5;
mask(:,:,25)=R5R5;

for i=1:25
    texfeat(:,:,i)=feature_image1(mask(:,:,i),comb);    
end

for i=1:25
feat_im(:,:,i)=extend(texfeat(:,:,i),26);
end


for i=1:25
energy_computed(:,:,i)=en_compute(feat_im(:,:,i),26);
end


energy_computed(:,:,1)=energy_computed(:,:,1)./energy_computed(:,:,1);
energy_computed(:,:,2)=energy_computed(:,:,2)./energy_computed(:,:,1);
energy_computed(:,:,3)=energy_computed(:,:,3)./energy_computed(:,:,1);
energy_computed(:,:,4)=energy_computed(:,:,4)./energy_computed(:,:,1);
energy_computed(:,:,5)=energy_computed(:,:,5)./energy_computed(:,:,1);
energy_computed(:,:,6)=energy_computed(:,:,6)./energy_computed(:,:,1);
energy_computed(:,:,7)=energy_computed(:,:,7)./energy_computed(:,:,1);
energy_computed(:,:,8)=energy_computed(:,:,8)./energy_computed(:,:,1);
energy_computed(:,:,9)=energy_computed(:,:,9)./energy_computed(:,:,1);
energy_computed(:,:,10)=energy_computed(:,:,10)./energy_computed(:,:,1);
energy_computed(:,:,11)=energy_computed(:,:,11)./energy_computed(:,:,1);
energy_computed(:,:,12)=energy_computed(:,:,12)./energy_computed(:,:,1);
energy_computed(:,:,13)=energy_computed(:,:,13)./energy_computed(:,:,1);
energy_computed(:,:,14)=energy_computed(:,:,14)./energy_computed(:,:,1);
energy_computed(:,:,15)=energy_computed(:,:,15)./energy_computed(:,:,1);
energy_computed(:,:,16)=energy_computed(:,:,16)./energy_computed(:,:,1);
energy_computed(:,:,17)=energy_computed(:,:,17)./energy_computed(:,:,1);
energy_computed(:,:,18)=energy_computed(:,:,18)./energy_computed(:,:,1);
energy_computed(:,:,19)=energy_computed(:,:,19)./energy_computed(:,:,1);
energy_computed(:,:,20)=energy_computed(:,:,20)./energy_computed(:,:,1);
energy_computed(:,:,21)=energy_computed(:,:,21)./energy_computed(:,:,1);
energy_computed(:,:,22)=energy_computed(:,:,22)./energy_computed(:,:,1);
energy_computed(:,:,23)=energy_computed(:,:,23)./energy_computed(:,:,1);
energy_computed(:,:,24)=energy_computed(:,:,24)./energy_computed(:,:,1);
energy_computed(:,:,25)=energy_computed(:,:,25)./energy_computed(:,:,1);
size(energy_computed,1)
size(energy_computed,2)


var=1;
for i=1:size(energy_computed,1)
    for j=1:size(energy_computed,2)
        
        k_means_matrix(var,:)=energy_computed(i,j,:);
        var=var+1;
    end
end

[coeff,score]=pca(k_means_matrix,'NumComponents',3);
cluster=kmeans(score,7,'replicates',20);

var=1;
for i=1:510
    for j=1:510
        output_m(i,j)=cluster(var,1);
        var=var+1;
    end
end

for i=1:510
    for j=1:510

        if output_m(i,j)==1
            output_m(i,j)=0;
        elseif output_m(i,j)==2
             output_m(i,j)=42;
        elseif output_m(i,j)==3
            output_m(i,j)=84;
        elseif output_m(i,j)==4
            output_m(i,j)=126;
        elseif output_m(i,j)==5
            output_m(i,j)=168; 
        elseif output_m(i,j)==6
           output_m(i,j)=210;
        elseif output_m(i,j)==7
            output_m(i,j)=255;
            
        end
    end
end

out=uint8(output_m); 

se90 = strel('line', 2, 90);
se0 = strel('line', 2, 0);
out2 = imdilate(out,[se90 se0]);
fill = imfill(out2,'holes');
figure;
imshow(fill)

toc