
 row     = 145; col     = 145; bandnum = 220;
im1     = multibandread('92AV3C.lan',[145,145,bandnum],'uint16',128,'BIL','ieee-le');
im1 (:,:,220)    = []; 
im1(:,:,150:163) = []; 
im1(:,:,104:108) = []; 
bandnum = 200;
im     = im1;

imGIS = multibandread('92AV3GT.GIS',[145,145,1],'uint8',128,'BSQ','ieee-le');
imshow(imGIS);
figure;imshow(label2rgb(imGIS));
img1=im(:,:,20)/max(max(max(im)));
img2=im(:,:,80)/max(max(max(im)));
img3=im(:,:,170)/max(max(max(im)));
figure;
imshow((img1+img2+img3)/3);

clsNum = 16; 
clsAll = [];
posAll = [];

for i = 1 : clsNum                  
    [x,y] = find (imGIS == i);  
    Class_num(i) = size(x,1);
end

choose_index  = 1:1:16;

for i = 1 : size(choose_index,2)  
    [x,y] = find (imGIS == choose_index(i));  
    Class_num1(i) = size(x,1);
    pos{i} = [x,y];  
    for j=1:length(pos{i})
        cls{i}(:,j)  = im(x(j),y(j),:); 
    end
    clsAll = [clsAll cls{i}];  
    posAll = [posAll pos{i}];   
end
   
data.fet = clsAll;   
save datafet.mat;
label = [];
for i = 1 : size(choose_index,2)  
    label = [label, repmat(i,[1, Class_num1(i)])];
end

data.lab = label;  
save datalab.mat