function grainSize=calcGrainSize(volume)
indicts=find(volume>0);
[xIndicts,yIndicts,zIndicts]=ind2sub(size(volume),indicts);
originalCoordinates=[xIndicts,yIndicts,zIndicts];
sddata=originalCoordinates;
[~,transformCoordinates,~]=pca(sddata);  %调用主成分
valueRange=max(transformCoordinates)-min(transformCoordinates);
grainSize=sort(valueRange,'descend')+1;
end