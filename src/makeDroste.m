function drosteImage = makeDroste(filename, outfilename='droste.png')
pkg load image;
accept_rect = false;
accept_result = false;
img = imread(filename);


  while(!accept_rect)

    clf;
    subplot (2,1,1); 
    imshow(img);
    axis off;

    X = []; Y = [];

    hold on;
    for i = 1:4
      title(['Click image to place corner ', num2str(i)]);
      drawnow;
      [x y] = ginput(1);
      plot(x,y,'mo');
      drawnow;
      X = [X,floor(x)];
      Y = [Y,floor(y)];
    end

    plot([X,X(1)], [Y,Y(1)], 'g');

    answer = input('Redo region? [y/n] ', 's');
    accept_rect = answer ~= 'y';

  end

  drosteImage = img;

  for i = 1:5
    drosteImage = imageInsideImage(drosteImage, X, Y);
  end

  subplot (2,1,2); 
  imshow(drosteImage);
  drawnow;

  result_answer = input('Start over? [y/n] ', 's');
  accept_result = result_answer ~= 'y'; 

imwrite(drosteImage, outfilename);

