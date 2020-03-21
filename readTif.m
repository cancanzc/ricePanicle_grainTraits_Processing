function volume=readTif(filepath)  %.tif�ļ�·��
Info=imfinfo(filepath);  
tif='tif';
format=Info.Format;
if(strcmp(format ,tif)==0)
    disp('����Ĳ���tifͼ����ȷ�����������');                  %%ȷ�������ͼ����tifͼ��
end
Slice=size(Info,1);                                            %%��ȡͼƬz��֡��
Width=Info.Width;
Height=Info.Height;
volume=zeros(Height,Width,Slice);
for i=1:Slice
    img=imread(filepath,i);                                  %%һ��һ��Ķ���ͼ��
    volume(:,:,i)=img;
end
if( isa(img,'uint16'))
    volume=uint8(volume/(max(volume(:))/255));
else
    volume=uint8(volume);
end
end