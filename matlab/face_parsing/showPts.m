imageNum = 20
pointNum = 5
figure
green(1, 1, :) = [0 255 0];
mkdir('show_result');
fid = fopen('1.txt', 'r');
for n1 = 1 : imageNum
    imageName = fscanf(fid, '%s', 1);
    pt = fscanf(fid, '%d', 10);
    I = imread(imageName);
    if size(I, 3) == 1
        I = repmat(I, [1 1 3]);
    end
    pt = round(pt) + 1;
    pt
    for n2 = 1 : pointNum
        p = pt(n2 * 2 - 1 : n2 * 2);
        I(p(2) - 1 : p(2) + 1, p(1) - 2 : p(1) + 2, :) = repmat(green, [3 5]);
        I([p(2) - 2 p(2) + 2], p(1) - 1 : p(1) + 1, :) = repmat(green, [2 3]);
    end
    %imwrite(I, ['show_result/' imageName]);
	imshow(I)
	pause
end
fclose(fid);
