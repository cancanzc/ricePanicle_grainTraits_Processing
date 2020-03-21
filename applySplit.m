function L=applySplit(bw,r)
se=r;
D=bwdist(~bw,'chessboard');
mask=imextendedmax(D,0,6);
SE=strel('sphere',se);
mask=imdilate(mask,SE).*bw;
maxregiona=D(logical(mask));
maxvalue=max(maxregiona(:));
D(logical(mask))=maxvalue;
D=-D;
D(~bw) =inf;
L = watershed(D,18);
L(~bw) = 0;
L=(L>0);
end


