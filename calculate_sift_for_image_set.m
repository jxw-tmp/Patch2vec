function [locs,sifts] = calculate_sift_for_image_set(image_name_set)
	locs = cell(numel(image_name_set),1);
	sifts = cell(numel(image_name_set),1);
	for i = 1:numel(image_name_set)
		try
			[f,d] = im2sift(image_name_set{i});
			locs{i} = f;
			sifts{i} = d;
		catch exception
			locs{i} = -1;
			sifts{i} = -1;
			continue;
		end
	end
end