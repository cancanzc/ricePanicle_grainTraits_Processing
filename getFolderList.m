function dirlist=getFolderList(rootPath)
dirlist=dir(rootPath);
Incorrect=zeros(numel(dirlist),1);
for i=1:numel(dirlist)
    if(~(dirlist(i).isdir)||(strcmp(dirlist(i).name,'.'))||(strcmp(dirlist(i).name,'..')))
        Incorrect(i)=1;
    end
end
dirlist=dirlist(~Incorrect,:);
end