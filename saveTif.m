function saveTif(A,filepath)   
slice=size(A,3);
for i=1:slice
    img=A(:,:,i);
% img=A;
    if(i==1)
        imwrite(img,filepath,'tif');
    else
        imwrite(img,filepath,'tif','WriteMode','Append');
    end
end
end