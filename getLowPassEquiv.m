function [best_p, best_s] = getLowPassEquiv()
path = 'BSDS300/images/train/';
images = dir([path '*.jpg']);
JPG_QUALITY = 10;

s = 1 : 7;
p = 0.5 : 0.2 : 2;
num_s = length(s);
num_p = length(p);
best_error = 999999999999999;
best_p = p(1);
best_s = s(1);

for ss = s(1) : s(1) + num_s - 1
    for pp = p(1) : p(1) + num_p - 1
        n_pixels = 0;
        total_error = 0;
        for i = 1 : length(images)
            filename = [path images(i).name];
            im_orig = rgb2gray(imread(filename));
            imwrite(im_orig, 'im_jpeg.jpg', 'Quality', JPG_QUALITY);
            im_low = imread('im_jpeg.jpg');
            sz = size(im_orig);
            G = fspecial('gaussian',[ss ss],pp);
            im_smooth = imfilter(im_orig, G, 'same');
            diff = abs(im_smooth - im_low);
            n_pixels = n_pixels + sz(1) * sz(2);
            total_error = total_error + sum(diff(:));
        end
        total_error = total_error / n_pixels;
        if total_error < best_error
            best_error = total_error;
            best_p = pp;
            best_s = ss;
        end
    end
end

for i = 1 : length(images)
    filename = [path images(i).name];
    im_orig = rgb2gray(imread(filename));
    imwrite(im_orig, 'im_jpeg.jpg', 'Quality', JPG_QUALITY);
    im_low = imread('im_jpeg.jpg');
    
    G = fspecial('gaussian',[best_s best_s],best_p);
    im_smooth = imfilter(im_orig, G, 'same');
    subplot(1, 2, 1);
    imshow(im_smooth);
    subplot(1, 2, 2);
    imshow(im_low);
end
end