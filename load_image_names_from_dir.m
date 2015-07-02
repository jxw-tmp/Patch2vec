function [train_file_names] = load_image_names_from_dir(dir_name,regex)
	listing = dir(strcat(dir_name,'/',regex));
	train_file_names = cell(numel(listing));
	for i = 1: numel(listing)
		train_file_names{i} = strcat(dir_name,'/',listing(i).name);
	end
end