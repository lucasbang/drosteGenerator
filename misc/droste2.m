% close all;
clear all;
im = imread('blanketch.jpg');
%im = checkerboard(4,2,2);
subplot (2,2,1); 
hold off;
imshow(im);
axis on;

[h w d] = size(im);

X = []; Y = [];

break;

hold on;
for i = 1:4
  [x y] = ginput(1);
  disp([x,y]);
  plot(x,y,'mo');
  drawnow;
  X = [X,floor(x)];
  Y = [Y,floor(y)];
end

disp([X',Y'])

incp = [1 1; w 1; w h; 1 h];

udata = [min(incp(:,1)) max(incp(:,1))];
vdata = [min(incp(:,2)) max(incp(:,2))];

%outcp = [1 -40; 160 -40; 220 220; 12 140];
outcp = [X',Y'];
T = maketform ('projective', incp, outcp);
subplot (2,2,2); 
hold off;
[im2 xdata ydata] = imtransform (im, T, 'udata', udata,
                              'vdata', vdata, 'fillvalues', 1 );
% imh = imshow (im2); 
% set (imh, 'xdata', xdata, 'ydata', ydata);
% set (gca, 'xlim', xdata, 'ylim', ydata);
% axis on, hold on, xlabel ('Projection');
% plot (outcp(:,1), outcp(:,2), 'or');




% subplot (2,2,3); 

xdata = int32(xdata);
ydata = int32(ydata);


imsub = im(ydata(1)+1:ydata(2),xdata(1)+1:xdata(2),:);

%imshow(imsub);

%subplot(2,2,4);

% hold off;

% mask = max(im2,[],3);

% mask = 

[h w d] = size(im);


allwhite = 255*ones(h,w,d);

[mask xdata ydata] = imtransform (allwhite, T, 'udata', udata,
                              'vdata', vdata, 'fillvalues', 1 );


xdata = int32(xdata);
ydata = int32(ydata);

im_mask = 255*(mask>1);

imreplacement = imsub - im_mask + im2;

%imshow(imreplacement)

%set (imh, 'xdata', xdata, 'ydata', ydata);
%set (gca, 'xlim', xdata, 'ylim', ydata);
axis on, hold on, xlabel ('Projection');
%plot (outcp(:,1), outcp(:,2), 'or');


im3 = im;

im3(ydata(1)+1:ydata(2),xdata(1)+1:xdata(2),:) = imreplacement;

subplot(2,2,3)
imshow(im3);
%imshow(imsub + im2)

break;











## Various linear transforms
figure (); 
im = [checkerboard(20, 2, 4); checkerboard(40, 1, 2)];
%input space corners
incp = [1 1; 160 1; 160 160; 1 160];
udata = [min(incp(:,1)) max(incp(:,1))];
vdata = [min(incp(:,2)) max(incp(:,2))];
subplot (1,2,1); 
imshow (im)
hold on
plot (incp(:,1), incp(:,2), 'ob')
axis on
xlabel ('Original')






% Projection
outcp = [1 1; 160 -40; 220 220; 12 140];
T = maketform ('projective', incp, outcp);
subplot (1,2,2); 
[im2 xdata ydata] = imtransform (im, T, 'udata', udata,
                              'vdata', vdata, 'fillvalues', 1 );
imh = imshow (im2); set (imh, 'xdata', xdata, 'ydata', ydata) 
set (gca, 'xlim', xdata, 'ylim', ydata)
axis on, hold on, xlabel ('Projection');
plot (outcp(:,1), outcp(:,2), 'or')