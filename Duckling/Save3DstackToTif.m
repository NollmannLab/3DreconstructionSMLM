function Save3DstackToTif(img, filename)
% wr_img(img, filename): write a 3D image file in uncompressed tif format
% filename=('C:\Users\Le Gall\Desktop\Nucleoid_215_2_5-500');
% Save3DstackToTif(uint16(filtered_Stack), filename)

if ndims(img) ~= 3
help wr_img
error('Requires image in 3D')
end

if nargin ~= 2
error 'requires image and file name'
end

wr_mode = 'overwrite';
for i=1:size(img,3)
    imwrite(img(:,:,i),filename, 'tif', 'Compression','none','WriteMode', wr_mode);
    wr_mode = 'append';
end
