% run_demo
addpath('../');
addpath('../..');
try
	load('meanshape.mat');
	%load('helen_mean_shape.mat');
catch
	error('You need a 5pts mean shape.');
end
model_path = 'model-helen';
result_path = 'vis_results';
if ~exist(result_path,'dir')
	mkdir(result_path);
end

train_id = 1;
%state_path = fullfile(model_path, sprintf('TrainID_%.2d',train_id));
%trainedmodel = fullfile(state_path, 'face_parsing_v1_iter_20800.caffemodel');
trainedmodel = fullfile(model_path, 'face_parsing_v1_iter_20800.caffemodel');
testproto = fullfile(model_path, 'face_parsing_v1_test.prototxt');
net_ = caffe.Net(testproto, trainedmodel,'train');
%caffe.set_mode_gpu();
%caffe.set_device(2);

figure
imageNum = 200;
pointNum = 5;
%img = imread('YOUR IMAGE PATH');
fid = fopen('1.txt', 'r');
for n1 = 1 : imageNum
    imageName = fscanf(fid, '%s', 1);
    pt = fscanf(fid, '%d', 10);
    img = imread(imageName);
    img1=img;
    green(1, 1, :) = [0 255 0];
    for n2 = 1 : pointNum
        p = pt(n2 * 2 - 1 : n2 * 2);
        img1(p(2) - 4 : p(2) + 4, p(1) - 4 : p(1) + 4, :) = repmat(green, [9 9]);
    end
    %lmk = [204,206,336,239,215,291,185,352,271,383];
    lmk = pt;
    [img_new,ret] = AlignHelen(img, lmk, mean_shape);
    img_new_s = imresize(img_new,[128,128]);

    [img1_new,ret] = AlignHelen(img1, lmk, mean_shape);
    img1_new = imresize(img1_new, [500, 500]);

    imwrite(img_new_s, fullfile(result_path,'new.png'));
    [label,edge] = test_1_image_11cls(net_,img_new_s);
    vis_label = vishelen(im2double(img_new_s), label);
    res_label = imtransform(imresize(label,[size(img_new,1),size(img_new,2)]),ret,'XData',[1 size(img,2)],...
    'YData',[1 size(img,1)],'XYscale',1, 'Fillvalues',0);
    %save(fullfile(result_path,'res_label.mat'),'res_label');
    imwrite(vis_label, fullfile(result_path,'vis_label.png'));
    result_big = imresize(vis_label, [500, 500]);
    result = uint8(result_big*255);
	imshow([img1_new result])
	pause
end
