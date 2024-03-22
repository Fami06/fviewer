clear; clf;
home = pwd;

imgDir = uigetdir;
cd(imgDir);
imgList = dir;

WL = 400;%info.WindowCenter;
WW = 1000;%info.WindowWidth;

counter = 3;
while(1)
    imgName = imgList(counter).name;
    img = double(dicomread(imgName));
    info = dicominfo(imgName);

    if (counter == 3)
        h = figure(1); colormap(gray); axis('image');
        imagesc(img, [(WL - round(WW / 2)) (WL + round(WW / 2))]);
    end

    figure(h);
    key = get(h, 'CurrentKey');

    figure(h);
    switch key
        case 'l'
            counter = counter + 1;
        case 'j'
            counter = counter - 1;
        case 's'
            WW = WW - 10;
        case 'f'
            WW = WW + 10;
        case 'e'
            WL = WL + 10;
        case 'd'
            WL = WL - 10;
        case 'q'
            cd(home);
            break;
    end

    if (counter < 3)
        counter = 3;
    elseif (counter > length(imgList))
        counter = length(imgList);
    end

    figure(h);
    imagesc(img, [(WL - round(WW / 2)) (WL + round(WW / 2))]);
    title(strcat(num2str(counter), '/WL:', num2str(WL), '/WW:', num2str(WW)));
    drawnow;

    pause;

end