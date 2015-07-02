function [train_file_names] = load_file_names()
	load('/home/kundan/MIT_indoor67/release.mat');
	train_file_names = [];
	for i = 1: numel(imgs_test.full_name)
		train_file_names = [train_file_names,strcat('/home/kundan/Images/', imgs_test.fullname{i})];
	end
end
