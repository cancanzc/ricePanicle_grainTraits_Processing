function visualScatterPlot(bw,fignum)   %L为bwlabeln产生的带类别标签的
[L,num]=bwlabeln(bw,6);
c=rand(num,3);
for index=1:num
    singleClass = ismember(L,index);
    indicts=find(singleClass==1);
    [xx,yy,zz]=ind2sub(size(singleClass),indicts);
    if(index==1)
        xyzlist(1:numel(xx),:)=[xx yy zz];
        cv(1:numel(xx),:)=repmat(c(index,:),numel(xx),1);
    else
        xyzlist((end+1):(end+numel(xx)),:)=[xx yy zz];
        cv((end+1):(end+numel(xx)),:)=repmat(c(index,:),numel(xx),1);
    end
end
figure(fignum)
scatter3(xyzlist(:,1),xyzlist(:,2),xyzlist(:,3),1,cv,'.');
grid off;
axis off;
view(3);
set(gcf, 'InvertHardCopy', 'off');
set(gcf,'color','w');
end