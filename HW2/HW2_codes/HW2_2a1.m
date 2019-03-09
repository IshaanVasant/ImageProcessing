f = fopen('bridge.raw','r');
data = fread(f,'uint8=>uint8');
bridge1 = reshape(data,600,400)';
figure
imshow(bridge1)

bridge=bridge1;

for i=1:400
    for j=1:600
        if bridge(i,j)>randi([0 255])
            bridge(i,j)= 255;
        else
            bridge(i,j)=0;
        end
    end
end
        
figure
imshow(bridge)