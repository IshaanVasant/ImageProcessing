img=1-E;
figure;
imshow(img);
T=0.88;
for i=1:321
    for j=1:481
        if img(i,j)<T
            img(i,j)=0;
        else
            img(i,j)=1;
        end
    end
end
figure;       
imshow(img);