function surfaceArea=calcSurfaceArea(volume)
surfaceData=isosurface(smooth3(volume),0);%首先对读取的数据进行平滑处理，然后提取等值面，得到三角面片有关的一系列数据
totalArea=0;%定义体表面积变量
for i=1:size(surfaceData.faces,1)%利用海伦公式计算
    a=surfaceData.vertices(surfaceData.faces(i,1),:);
    b=surfaceData.vertices(surfaceData.faces(i,2),:);
    c=surfaceData.vertices(surfaceData.faces(i,3),:);
    ab=sqrt((a(1)-b(1))^2+(a(2)-b(2))^2+(a(3)-b(3))^2);
    ac=sqrt((a(1)-c(1))^2+(a(2)-c(2))^2+(a(3)-c(3))^2);
    bc=sqrt((c(1)-b(1))^2+(c(2)-b(2))^2+(c(3)-b(3))^2);
    p=(ab+ac+bc)/2;
    totalArea=totalArea+sqrt(p*(p-ab)*(p-bc)*(p-ac));
end
surfaceArea=totalArea; %依据体数据对应实际尺寸，得到真实的表面积数值
end