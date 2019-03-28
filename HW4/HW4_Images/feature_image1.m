%%%%%%%%%%%%%%%%%%%%%FILTERING ACTION%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function fi=feature_image1(mask,picture)

filter_window=mask;
image_layer=picture;

output_image=zeros(size(image_layer));

sum=0;

Size=size(output_image);

x=1;
y=1;

for i=3:Size(1)-2
    for j=3:Size(2)-2
         
            for l=1:5
                for m=1:5
                 sum=sum + image_layer(i+x-3,j+y-3)*filter_window(l,m); 
                 y=y+1;
                end
                 y=1;
                 x=x+1;
            end
                 x=1;
            
output_image(i,j)=sum; %replacing the pixels with the average of the neighbourhood pixels in window 
sum=0;
    end
end

fi=output_image(3:Size(1)-2,3:Size(2)-2);


end 
