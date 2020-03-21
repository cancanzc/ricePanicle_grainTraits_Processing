function traitsSummary(root)
dirlist=getFolderList(root);
num=numel(dirlist);
%% 创建结果文件夹
for currentN=1:num
    subdir=dirlist(currentN).name;
    readPath=fullfile(root,subdir);
    %% 读取数据
    panicleTraits_path=fullfile(readPath,'panicleTraits.csv');
    panicleTraits=csvread(panicleTraits_path);
    
    traits.Serial_Number=subdir;
    
    traits.GN=panicleTraits(1);
    
    traits.MGL=panicleTraits(2);
    traits.SGL=panicleTraits(3);
    
    traits.MGW=panicleTraits(4);
    traits.SGW=panicleTraits(5);
    
    traits.MLWR=panicleTraits(6);
    traits.SLWR=panicleTraits(7);
    
    traits.MGT=panicleTraits(8);
    traits.SGT=panicleTraits(9);
    
    traits.MWTR=panicleTraits(10);
    traits.SWTR=panicleTraits(11);
    
    traits.TGS=panicleTraits(12);
    traits.MGS=panicleTraits(13);
    traits.SGS=panicleTraits(14);
    
    traits.TGV=panicleTraits(15);
    traits.MGV=panicleTraits(16);
    traits.SGV=panicleTraits(17);
    
    traits.MCHV=panicleTraits(18);
    traits.SCHV=panicleTraits(19);
    
    traits.MED=panicleTraits(20);
    
    traits.MS=panicleTraits(21);
    
    traits.MGG=panicleTraits(22);
    
    featureSummay(currentN,1)=traits;
end

file_traits_path=fullfile(root,'totalTraits.csv');
writetable(struct2table(featureSummay),file_traits_path);
end