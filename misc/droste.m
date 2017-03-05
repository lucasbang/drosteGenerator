% close all;
clf
clear all;
im = imread('blanketch.png');
subplot (1,2,1); 
hold off;
imshow(im);
axis on;

[h w d] = size(im);

X = []; Y = [];


hold on;

break;

for i = 1:4
  [x y] = ginput(1);
  plot(x,y,'mo');
  drawnow;
  X = [X,floor(x)];
  Y = [Y,floor(y)];
end

disp([X',Y'])

incp = [1 1; w 1; w h; 1 h];

udata = [min(incp(:,1)) max(incp(:,1))];
vdata = [min(incp(:,2)) max(incp(:,2))];


outcp = [X',Y'];
T = maketform ('projective', incp, outcp);


subplot (1,2,2); 
[im2 xdata ydata] = imtransform (im, T, 'udata', udata, 'vdata', vdata, 'fillvalues', 1 );


xdata = int32(xdata);
ydata = int32(ydata);

imsub = im(ydata(1)+1:ydata(2),xdata(1)+1:xdata(2),:);

[h w d] = size(im);

allwhite = 255*ones(h,w,d);

[mask xdata ydata] = imtransform (allwhite, T, 'udata', udata, 'vdata', vdata, 'fillvalues', 1 );

xdata = int32(xdata);
ydata = int32(ydata);

im_mask = 255*(mask>1);

imreplacement = imsub - im_mask + im2;

im3 = im;

im3(ydata(1)+1:ydata(2),xdata(1)+1:xdata(2),:) = imreplacement;

imshow(im3);
