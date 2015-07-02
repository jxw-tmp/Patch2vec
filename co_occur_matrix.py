import itertools as it
import numpy as np
import pickle

from joblib import Parallel, delayed  
import multiprocessing

desc_dict = dict()
index2id = dict()
with open('train/existing_ids_all.txt','rb') as f:
	j = 0;
	for line in f:
		num = int(line.strip())
		desc_dict[num] = j
		index2id[j] = num
		j += 1;


def calculate_co_coccur_mat(fname_with_ids_per_img, fname_to_save_co_occur_matrix):
	print("Working with file %s\n"%fname_with_ids_per_img)
	global desc_dict,index2id 
	count_id = dict()
	for key in desc_dict:
		count_id[key] = 0
	j = 0;
	co_occur_matrix = np.zeros((13400,13400))
	with open(fname_with_ids_per_img,'rb') as f:
		for line in f:
			print("I am in "+str(j)+"th iteration.\n")
			j += 1;
			ids = line.strip().split()
			for pid in ids:
				count_id[int(pid)] += 1
			for id1,id2 in it.combinations(ids,2):
				co_occur_matrix[desc_dict[int(id1)]][desc_dict[int(id2)]] += 1
				co_occur_matrix[desc_dict[int(id2)]][desc_dict[int(id1)]] += 1
		for key in count_id:
			co_occur_matrix[desc_dict[int(key)]][desc_dict[int(key)]] = count_id[key]
	pickle.dump(co_occur_matrix,open(fname_to_save_co_occur_matrix,'wb'))
	print("Co occur matrix written to file %s\n"%fname_to_save_co_occur_matrix)

pickle.dump(desc_dict,open('id2index_new.pkl','wb'))
pickle.dump(index2id,open('index2id_new.pkl','wb'))

Parallel(n_jobs=3)([delayed(calculate_co_coccur_mat)('../patch_ids_unique_sorted_train_0.6.txt','co_occur_0.6_new.pkl'),delayed(calculate_co_coccur_mat)('../patch_ids_unique_sorted_train_0.5.txt','co_occur_0.5_new.pkl'),delayed(calculate_co_coccur_mat)('../patch_ids_unique_sorted_train_0.4.txt','co_occur_0.4_new.pkl')])