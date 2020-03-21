function volume=readTif(filepath)  %.tif文件路径
Info=imfinfo(filepath);  
tif='tif';
format=Info.Format;
if(strcmp(format ,tif)==0)
    disp('载入的不是tif图像，请确认载入的数据');                  %%确保载入的图像是tif图像
end
Slice=size(Info,1);                                            %%获取图片z向帧数
Width=Info.Width;
Height=Info.Height;
volume=zeros(Height,Width,Slice);
for i=1:Slice
    img=imread(filepath,i);                                  %%一层一层的读入图像
    volume(:,:,i)=img;
end
if( isa(img,'uint16'))
    volume=uint8(volume/(max(volume(:))/255));
else
    volume=uint8(volume);
end
end