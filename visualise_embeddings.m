count = 1;
% mkdir patches_new;
for j = 1:2000
	image_name = MIT_data_set.image_names{train_set(2000+j)};
	[locs,sifts] = im2sift(image_name);
	sifts = double(sifts);
	im = imread(image_name);
	index = get_corresponding_index_in_hiarch_vocab(sifts);
	for i = 1:numel(index)
		if ~exist(num2str(index(i)),'dir')
			mkdir(num2str(index(i)));
		end
		imwrite(imcrop(im,[locs(1,i)-8,locs(2,i)-8,16,16]),[num2str(index(i)), '/',num2str(count),'.png']);
		count = count + 1;
	end
end