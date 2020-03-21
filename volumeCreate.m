function [volume,param]=volumeCreate(dicompath)  %dicom断层系列存放路径
[V,spatial,dim] = dicomreadVolume(dicompath);
volume=squeeze(V);
param=[spatial.PixelSpacings(1,:) spatial.PatientPositions(2,3)-spatial.PatientPositions(1,3)];
end
