clc;
clear;
f = fopen('texture1.raw','r'); data = fread(f,'uint8=>uint8'); tex1 = reshape(data,128,128)';
f = fopen('texture2.raw','r'); data = fread(f,'uint8=>uint8'); tex2 = reshape(data,128,128)';
f = fopen('texture3.raw','r'); data = fread(f,'uint8=>uint8'); tex3 = reshape(data,128,128)';
f = fopen('texture4.raw','r'); data = fread(f,'uint8=>uint8'); tex4 = reshape(data,128,128)';
f = fopen('texture5.raw','r'); data = fread(f,'uint8=>uint8'); tex5 = reshape(data,128,128)';
f = fopen('texture6.raw','r'); data = fread(f,'uint8=>uint8'); tex6 = reshape(data,128,128)';
f = fopen('texture7.raw','r'); data = fread(f,'uint8=>uint8'); tex7 = reshape(data,128,128)';
f = fopen('texture8.raw','r'); data = fread(f,'uint8=>uint8'); tex8 = reshape(data,128,128)';
f = fopen('texture9.raw','r'); data = fread(f,'uint8=>uint8'); tex9 = reshape(data,128,128)';
f = fopen('texture10.raw','r'); data = fread(f,'uint8=>uint8'); tex10 = reshape(data,128,128)';
f = fopen('texture11.raw','r'); data = fread(f,'uint8=>uint8'); tex11 = reshape(data,128,128)';
f = fopen('texture12.raw','r'); data = fread(f,'uint8=>uint8'); tex12 = reshape(data,128,128)';

text1=submean(tex1);
text2=submean(tex2);
text3=submean(tex3);
text4=submean(tex4);
text5=submean(tex5);
text6=submean(tex6);
text7=submean(tex7);
text8=submean(tex8);
text9=submean(tex9);
text10=submean(tex10);
text11=submean(tex11);
text12=submean(tex12);

texture1=padarray(text1,[2 2],'symmetric');
texture2=padarray(text2,[2 2],'symmetric');
texture3=padarray(text3,[2 2],'symmetric');
texture4=padarray(text4,[2 2],'symmetric');
texture5=padarray(text5,[2 2],'symmetric');
texture6=padarray(text6,[2 2],'symmetric');
texture7=padarray(text7,[2 2],'symmetric');
texture8=padarray(text8,[2 2],'symmetric');
texture9=padarray(text9,[2 2],'symmetric');
texture10=padarray(text10,[2 2],'symmetric');
texture11=padarray(text11,[2 2],'symmetric');
texture12=padarray(text12,[2 2],'symmetric');

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
    tex1feat(:,:,i)=feature_image(mask(:,:,i),texture1);
end

for i=1:25
    tex2feat(:,:,i)=feature_image(mask(:,:,i),texture2);
end

for i=1:25
    tex3feat(:,:,i)=feature_image(mask(:,:,i),texture3);
end

for i=1:25
    tex4feat(:,:,i)=feature_image(mask(:,:,i),texture4);
end

for i=1:25
    tex5feat(:,:,i)=feature_image(mask(:,:,i),texture5);
end

for i=1:25
    tex6feat(:,:,i)=feature_image(mask(:,:,i),texture6);
end

for i=1:25
    tex7feat(:,:,i)=feature_image(mask(:,:,i),texture7);
end

for i=1:25
    tex8feat(:,:,i)=feature_image(mask(:,:,i),texture8);
end

for i=1:25
    tex9feat(:,:,i)=feature_image(mask(:,:,i),texture9);
end

for i=1:25
    tex10feat(:,:,i)=feature_image(mask(:,:,i),texture10);
end

for i=1:25
    tex11feat(:,:,i)=feature_image(mask(:,:,i),texture11);
end

for i=1:25
    tex12feat(:,:,i)=feature_image(mask(:,:,i),texture12);
end

text1avg=average(tex1feat);
text2avg=average(tex2feat);
text3avg=average(tex3feat);
text4avg=average(tex4feat);
text5avg=average(tex5feat);
text6avg=average(tex6feat);
text7avg=average(tex7feat);
text8avg=average(tex8feat);
text9avg=average(tex9feat);
text10avg=average(tex10feat);
text11avg=average(tex11feat);
text12avg=average(tex12feat);

X=[text1avg'; text2avg'; text3avg'; text4avg'; text5avg'; text6avg'; text7avg'; text8avg'; text9avg'; text10avg'; text11avg'; text12avg'];

X1=(X(1,:)-mean(X(1,:)))/std(X(1,:));
X2=(X(2,:)-mean(X(2,:)))/std(X(2,:));
X3=(X(3,:)-mean(X(3,:)))/std(X(3,:));
X4=(X(4,:)-mean(X(4,:)))/std(X(4,:));
X5=(X(5,:)-mean(X(5,:)))/std(X(5,:));
X6=(X(6,:)-mean(X(6,:)))/std(X(6,:));
X7=(X(7,:)-mean(X(7,:)))/std(X(7,:));
X8=(X(8,:)-mean(X(8,:)))/std(X(8,:));
X9=(X(9,:)-mean(X(9,:)))/std(X(9,:));
X10=(X(10,:)-mean(X(10,:)))/std(X(10,:));
X11=(X(11,:)-mean(X(11,:)))/std(X(11,:));
X12=(X(12,:)-mean(X(12,:)))/std(X(12,:));

X_norm=[X1;X2;X3;X4;X5;X6;X7;X8;X9;X10;X11;X12];

[coeff,score]=pca(X_norm,'NumComponents',3);

cluster=kmeans(score,4)


figure;
scatter3(score(:,1),score(:,2),score(:,3));
title('3D feature vector in feature space');
xlabel('1st PC');
ylabel('2nd PC');
zlabel('3rd PC');

for i=1:25
    D(i)=mean(abs(X_norm(:,i)));
end
D
