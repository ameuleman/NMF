function [result] = inPainting(img, mask)

    %% setup
    iterations = 300; %number of iterations
    stopFactor = 0.005; % the highest coefficent times stopFactor is the lowest threshold used during iterative thresholding.
    [sizeX, sizeY] = size(img); %size of image

    sl2d2 = SLgetShearletSystem2D(0,sizeX,sizeY,4,[1 1 2 2]);

    imgMasked = img.*mask;

    display('Traitement d une couleur');
    result = double(SLExperimentInpaint2D(imgMasked,mask,iterations,stopFactor,sl2d2));  

end