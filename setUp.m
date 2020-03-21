clear all;
close all;
clc;
% The root path of the data to be read
rootPath='.\data';
% The path to save the result
savePath='.\result';
% Whether to save the intermediate processed image results
isSaveImage=1;
% Specify the number of files to process
sampleNum=-1;
% Will handle all folders under the root directory
batchProcessing(rootPath,savePath,sampleNum,isSaveImage);
