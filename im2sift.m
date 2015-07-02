%% im2sift: function description
% fname is image path
function [f,d] = im2sift(fname)
	I = imread(fname) ;
	I = single(rgb2gray(I)) ;
	[f,d] = vl_dsift(I,'Step',4,'Size',8) ;
end
