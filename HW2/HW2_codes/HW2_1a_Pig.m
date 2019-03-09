img=imread('pig.jpg');
figure
imshow(img);

img2=rgb2gray(img);
figure
imshow(img2);

img3=double(img2);
pig=padarray(img3,[1 1],'symmetric');

for i=2:322
    for j=2:482
        sobel_y= 0.25*(-2*pig(i,j-1) + 2*pig(i,j+1) + -1*pig(i-1,j-1) + pig(i-1,j+1) + -1*pig(i+1,j-1) + pig(i+1,j+1));       
        sobel_x= 0.25*(-1*pig(i-1,j-1) + -2*pig(i-1,j) + -1*pig(i-1,j+1) + pig(i+1,j-1) + 2*pig(i+1,j) + pig(i+1,j+1));       
        total(i,j)=sqrt(sobel_x^2+sobel_y^2);
    end
end 

output=total(2:322,2:482);

figure
imshow(output);

threshold = 255*(20/100);
output1 = max(output,threshold);
output1(output1==round(threshold))=0;
output2=~output1;

figure
imshow(output2);

