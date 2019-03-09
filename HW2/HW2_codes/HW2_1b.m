img=imread('tiger.jpg');
% figure
% imshow(img);

img2=rgb2gray(img);
% figure
% imshow(img2);

img3=edge(img2,'canny',[0.5 0.6]);
img4=~img3;
figure
imshow(img4);



