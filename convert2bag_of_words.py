import numpy as np
import pickle

def convert_bag_to_normalized_row(id2index,single_bag,length_of_row):
	row  = np.zeros(length_of_row)
	for word in single_bag:
		row[id2index[int(word)]] += 1
	if np.linalg.norm(row) > 0:
		row = row/np.linalg.norm(row)
	return row

def convert_bag_to_normalized_count_vector(file_input,id2index,length_of_row,file_output):
	with open(file_input,'rb') as in_file:
		with open(file_output,'wb') as out_file:
			for line in in_file:
				row = convert_bag_to_normalized_row(id2index,line.strip().split(),length_of_row)
				for val in row:
					out_file.write(str(val) + ' ')
				out_file.write('\n')

id2index = pickle.load(open('id2index_new.pkl','rb'))

convert_bag_to_normalized_count_vector('../patch_ids_repeated_sorted_train_0.4.txt',id2index,13400,'train_bow_0.4.txt')
convert_bag_to_normalized_count_vector('../patch_ids_repeated_sorted_train_0.6.txt',id2index,13400,'train_bow_0.6.txt')
convert_bag_to_normalized_count_vector('../patch_ids_repeated_sorted_train_0.5.txt',id2index,13400,'train_bow_0.5.txt')
convert_bag_to_normalized_count_vector('../patch_ids_repeated_sorted_test_0.4.txt',id2index,13400,'test_bow_0.4.txt')
convert_bag_to_normalized_count_vector('../patch_ids_repeated_sorted_test_0.6.txt',id2index,13400,'test_bow_0.6.txt')
convert_bag_to_normalized_count_vector('../patch_ids_repeated_sorted_test_0.5.txt',id2index,13400,'test_bow_0.5.txt')
