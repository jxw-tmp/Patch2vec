


function [list_of_image_names, image_classes, all_classes] = get_images_from_subdir(dir_name)
	listing = dir(dir_name);
	list_of_image_names = cell(1);
	image_classes = cell(1);
	all_classes = cell(1);
	pic_count = 0;
	class_count = 0;
	for i = 1:numel(listing)
		if or(or(strcmp(listing(i).name,'.'),strcmp(listing(i).name,'..') ),not(listing(i).isdir))
			continue;
		end
		class_count = class_count + 1;
		all_classes{class_count} = listing(i).name;
		new_listing = dir(strcat(dir_name,'/',listing(i).name));
		for j = 1:numel(new_listing)
			if or(strcmp(new_listing(j).name,'.'),strcmp(new_listing(j).name,'..'))
				continue;
			end
			pic_count = pic_count + 1;
			list_of_image_names{pic_count} = strcat(dir_name,'/',listing(i).name,'/',new_listing(j).name);
			image_classes{pic_count} = listing(i).name;
		end
	end
	MIT_data_set = struct();
	MIT_data_set.image_names = list_of_image_names;
	MIT_data_set.image_corresponding_class = image_classes;
	MIT_data_set.class_names = all_classes;
	save('MIT_indoor_dataset_elements.mat','MIT_data_set');
end
