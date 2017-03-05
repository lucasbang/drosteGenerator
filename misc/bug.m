% The following produces a crash in Octave 4.0.0
% ginput has error. Fixed in 4.0.2
n = 10;
x(:,:,1) = uint8 (rand (10)*255);
x(:,:,2) = uint8 (rand (10)*255);
x(:,:,3) = uint8 (rand (10)*255);
imshow (x);
ginput(1);
