function re=createMask(bw)
result=uint8(ones(size(bw)));
SE=strel('disk',60);
pindicts=[];
cnt=0;
se1=strel('disk',10);
se2=strel('disk',3);
index=[1:1:261 262:1:268];
% index=1:size(bw,3);
for i=1:numel(index)
    m=index(i);
    img=bw(:,:,m);
%     if(i>220)
%     figure(1)
%     imshow(img*255);
%     end
    [B,l,N] = bwboundaries(img);
    bnum=length(B);
    if(N<bnum)
        innerboundary=B((N+1):bnum);
        [edgesize,~]=cellfun(@size,innerboundary);
        [value]=find(edgesize>600);
        if(numel(value)>=1)
            if(numel(value)==1)
                indict=value;
            else
                stats=regionprops(l,'Area');
                area=[stats.Area];
                [~,indict]=max(area((N+1):bnum));
            end  
%                 if(i>220)
%             saveas(1,['D:\result_20191214\daosui_1-2_null_20190723130907\holdermask\slice\' num2str(i,'%d.png')])
%             
%             for j=1:(bnum-N)
%                boundary=innerboundary{j}; 
%                hold on;
%                plot(boundary(:,2), boundary(:,1), 'r','LineWidth',1);
%             end
%             saveas(1,['D:\result_20191214\daosui_1-2_null_20190723130907\holdermask\alledge\' num2str(i,'%d.png')])
%             
%             figure(1)
%             imshow(img*255);
%             boundary=innerboundary{indict};
%             hold on;
%             plot(boundary(:,2), boundary(:,1),'b','LineWidth',1);
%             saveas(1,['D:\result_20191214\daosui_1-2_null_20190723130907\holdermask\edgebefore\' num2str(i,'%d.png')])
%                 end
            
            filledimg=ismember(l,indict+N);
%                 if(i>220)
%             figure(1)
%             imshow(uint8(imfill(filledimg,'holes'))*255);
%             saveas(1,['D:\result_20191214\daosui_1-2_null_20190723130907\holdermask\filled\' num2str(i,'%d.png')])
%                 end
            
            filledmak=imclose(filledimg,SE);
%                 if(i>220)
%             figure(1)
%             imshow(uint8(filledmak)*255);
%             saveas(1,['D:\result_20191214\daosui_1-2_null_20190723130907\holdermask\edgeafter\' num2str(i,'%d.png')])
%                 end
            
            result(:,:,m)=uint8(filledmak);
            cnt=cnt+1;
            pindicts(cnt)=m;   
        end     
    end
end
if(numel(pindicts))
%bottom
lowindex=1;
upindex=pindicts(1);
mask=result(:,:,upindex);
mask=uint8(imerode(mask,se2));
if(lowindex<upindex)
    result(:,:,lowindex:(upindex-1))=repmat(mask,1,1,upindex-lowindex);
end
% middle
for m=1:(numel(pindicts)-1)
    lowindex=pindicts(m);
    upindex=pindicts(m+1)-1;
    if(upindex>lowindex)
        result(:,:,(lowindex+1):upindex)=repmat(result(:,:,lowindex),1,1,upindex-lowindex);      
    end
end
% top
lowindex=pindicts(end);
upindex=270;
filledmak=result(:,:,lowindex);
mask=uint8(imdilate(filledmak,se1))-uint8(imerode(filledmak,se2));
for i=lowindex+1:upindex
    img=bw(:,:,i);
    overmarit=uint8(and(img,mask));
    overlap=sum(overmarit(:));
    if(overlap>200)
        result(:,:,i)=uint8(img)-mask;
    else
        break;
    end
end
end
re=result;
end