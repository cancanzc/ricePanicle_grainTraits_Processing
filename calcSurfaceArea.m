function surfaceArea=calcSurfaceArea(volume)
surfaceData=isosurface(smooth3(volume),0);%���ȶԶ�ȡ�����ݽ���ƽ������Ȼ����ȡ��ֵ�棬�õ�������Ƭ�йص�һϵ������
totalArea=0;%��������������
for i=1:size(surfaceData.faces,1)%���ú��׹�ʽ����
    a=surfaceData.vertices(surfaceData.faces(i,1),:);
    b=surfaceData.vertices(surfaceData.faces(i,2),:);
    c=surfaceData.vertices(surfaceData.faces(i,3),:);
    ab=sqrt((a(1)-b(1))^2+(a(2)-b(2))^2+(a(3)-b(3))^2);
    ac=sqrt((a(1)-c(1))^2+(a(2)-c(2))^2+(a(3)-c(3))^2);
    bc=sqrt((c(1)-b(1))^2+(c(2)-b(2))^2+(c(3)-b(3))^2);
    p=(ab+ac+bc)/2;
    totalArea=totalArea+sqrt(p*(p-ab)*(p-bc)*(p-ac));
end
surfaceArea=totalArea; %���������ݶ�Ӧʵ�ʳߴ磬�õ���ʵ�ı������ֵ
end