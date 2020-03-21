function [grainTraits,sumTraits,segmentedfilled]=calcTotalTraits(volume,filledgrainbw,savePath)
[l,num]=bwlabeln(filledgrainbw,6);
status=regionprops3(l,'Volume','BoundingBox','ConvexVolume','EquivDiameter','Solidity');
sVolume=[status.Volume];
gVolumeSort=sort(sVolume);
stdSingleVolume=gVolumeSort(round((numel(gVolumeSort)+1)/2));
uThresh=stdSingleVolume*1.6;
lThresh=stdSingleVolume*0.4;
totalvolume=0;
totalsurface=0;
totalfillednum=0;
singleNum=0;
segmentedfilled=uint8(zeros(size(l)));
for index=1:num
    if(sVolume(index)>=lThresh)
        singleGrainSrc= uint8(ismember(l,index));
        singleGrain= removeBlank(singleGrainSrc,status(index,2).BoundingBox);
        grainSize=calcGrainSize(singleGrain);
        if(grainSize(1)/grainSize(3)<10)   % Remove markers used for marking, the marker is a slice
            segmentedfilled=segmentedfilled+singleGrainSrc;
            if(sVolume(index)<uThresh)
                singleNum=singleNum+1;
                grainSize=grainSize*0.3;
                grainSurface=calcSurfaceArea(singleGrain)*0.09;
                grainVolume=sVolume(index)*0.027;
                convexHullvolume=status(index,4).ConvexVolume*0.027;
                equivdiameter=status(index,3).EquivDiameter*0.3;
                solidity=status(index,5).Solidity;
                totalvolume=totalvolume+grainVolume;
                totalsurface=totalsurface+grainSurface;
                grainTraits(singleNum,:)=[grainSize grainSurface grainVolume convexHullvolume equivdiameter solidity];
            else
                totalfillednum=totalfillednum+round(sVolume(index)/stdSingleVolume);
                totalvolume=totalvolume+sVolume(index)*0.027;
                totalsurface=totalsurface+calcSurfaceArea(singleGrain)*0.09;
            end
        end
    end
end
grayimage=volume.*segmentedfilled;
meangray=sum(grayimage(:))/sum(segmentedfilled(:));
totalfillednum=totalfillednum+singleNum;
sumTraits=[totalfillednum totalsurface totalvolume meangray];
end