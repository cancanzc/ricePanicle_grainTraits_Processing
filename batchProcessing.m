function batchProcessing(root,dst,sampleNum,isSaveImage)
dirlist=getFolderList(root);
dirnum=numel(dirlist);
if(sampleNum<=0||sampleNum>dirnum)
    sampleNum=dirnum;
end
dirlist=dirlist(1:sampleNum,:);
dirnum=numel(dirlist);
for currentN=1:dirnum
    dirDicom=dirlist(currentN).name;
    disp([num2str(currentN,'processing %d') num2str(dirnum,'/%d:') dirDicom]);
    %% %path for saving result
    savePath=fullfile(dst,dirDicom);
    if(~exist(savePath,'dir'))
        mkdir(savePath);
    end
    
    %% %loading 3D volume
    tic
    disp('loading volume...');
    readPath=fullfile(root,dirDicom);
    [volume,~]=volumeCreate(readPath);
    if( isa(volume,'uint16'))
        scale=max(volume(:))/255;
        volume=uint8(volume/scale);
    else
        volume=uint8(volume);
    end
    toc
%     if(isSaveImage)
%         saveTif(volume,fullfile(savePath,'src.tif'));
%     end
    
    %% binarization
    tic
    disp('image binarizing...');
    level=multithresh(volume,2);
    bw=(volume>=level(2));
    toc
    
    %% remove holder for extracting ROIregion
    tic
    disp('holder clearing...');
    potmask=createMask(bw);
    SE=strel('sphere',1);
    potmask=uint8(imerode(potmask,SE));
    toc
    
    %% extracting ROIregion
    tic
    disp('panicle image extracting...');
    paniclebw=potmask.*uint8(bw);
%     if(isSaveImage)
%         saveTif(uint8(paniclebw)*255,fullfile(savePath,'paniclebw.tif'));
%     end
    paniclegray=volume.*paniclebw;
    toc
    
    %% fillgrain extract
    tic
    disp('grain image extracting...');
    level = graythresh(paniclegray(logical(paniclebw)));
    filledgrainbw=imbinarize(paniclegray,level);
    % Whether to apply separation algorithm and method specified by method
    applyWatershed=0;
    if(applyWatershed)
    filledgrainbw=applySplit(filledgrainbw,1);
    end
    toc
    
    %% filledgrain traits extract
    tic
    disp('Traits extracting...');
    [grainTraits,sumTraits,segmentedfilled]=calcTotalTraits(volume,filledgrainbw,savePath);
    toc
    if(isSaveImage)
        saveTif(segmentedfilled*255,fullfile(savePath,'grainbw.tif'));
    end
    
    % single grain trait
    csvwrite(fullfile(savePath,'singleGrainTraits.csv'),grainTraits)
    
    grainLengthavg=mean(grainTraits(:,1));
    grainLengthStd=std(grainTraits(:,1),1);
    
    grainWidthavg=mean(grainTraits(:,2));
    grainWidthStd=std(grainTraits(:,2),1);
    
    grainDepthavg=mean(grainTraits(:,3));
    grainDepthStd=std(grainTraits(:,3),1);
    
    grainLWratio=mean(grainTraits(:,1)./grainTraits(:,2));
    grainLWratioStd=std(grainTraits(:,1)./grainTraits(:,2),1);
    
    grainWTratio=mean(grainTraits(:,2)./grainTraits(:,3));
    grainWTratioStd=std(grainTraits(:,2)./grainTraits(:,3),1);
    
    grainSurfaceavg=mean(grainTraits(:,4));
    grainSurfaceStd=std(grainTraits(:,4),1);
    
    grainVolumeavg=mean(grainTraits(:,5));
    grainVolumeStd=std(grainTraits(:,5),1);
    
    grainConvexHullVolumeavg=mean(grainTraits(:,6));
    grainConvexHullVolumeStd=std(grainTraits(:,6),1);
    
    grainEquivdiameteravg=mean(grainTraits(:,7));
    
    grainSolidityavg=mean(grainTraits(:,8));
    
    panicleTraits=[sumTraits(1) grainLengthavg grainLengthStd grainWidthavg grainWidthStd grainLWratio grainLWratioStd grainDepthavg grainDepthStd ...
        grainWTratio grainWTratioStd sumTraits(2) grainSurfaceavg grainSurfaceStd sumTraits(3) grainVolumeavg grainVolumeStd grainConvexHullVolumeavg grainConvexHullVolumeStd...
        grainEquivdiameteravg grainSolidityavg sumTraits(4)];
    csvwrite(fullfile(savePath,'panicleTraits.csv'),panicleTraits)
end
disp(num2str(dirnum,'Total %d samples process finished '));
traitsSummary(dst);
end