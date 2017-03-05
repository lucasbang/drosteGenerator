function drosteImage = imageInsideImage(img, X, Y)

[h w d] = size(img);
allwhite = 255*ones(h,w,d);

incp = [1 1; w 1; w h; 1 h];
udata = [min(incp(:,1)) max(incp(:,1))];
vdata = [min(incp(:,2)) max(incp(:,2))];
outcp = [X',Y'];

T = maketform ('projective', incp, outcp);

[img_projection xdata ydata] = imtransform (img, T, 'udata', udata, 'vdata', vdata, 'fillvalues', 1 );
[mask xdata ydata] = imtransform (allwhite, T, 'udata', udata, 'vdata', vdata, 'fillvalues', 1 );

xdata = int32(xdata);
ydata = int32(ydata);

img_slice = img(ydata(1)+1:ydata(2),xdata(1)+1:xdata(2),:);
img_mask = 255*(mask>1);
img_replacement = img_slice - img_mask + img_projection;

drosteImage = img;
drosteImage(ydata(1)+1:ydata(2),xdata(1)+1:xdata(2),:) = img_replacement;


