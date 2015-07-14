function [file_name_list] = create_sample_for_vocab_generation(num_files_to_take,train_set_indices,cell_of_file_names)
	file_name_list = cell(1)
	parfor i = 1:num_files_to_take
		file_name_list{i} = cell_of_file_names{train_set_indices(i)};
	end
end
