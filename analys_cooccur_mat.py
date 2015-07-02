# a datastructure to get k topmost element and their indices from a matrix.
# may be implemented as a set with remove_min operation, get_min 
# and get_size operation operation and iterator over all the elements
import pickle
import numpy as np

co_occur_matrix = pickle.load(open('co_occur_matrix.pkl','rb'))
id_desc = pickle.load(open('id_descript.dict','rb'))

index2id = np.zeros(13400)
j = 0;
with open('existing_patch_ids_in_data_new3.txt','rb') as f:
	for line in f:
		index2id[j] = int(line.strip())
		j += 1;

with open('co_occur_score.txt','wb') as f:
	for i in range(13400):
		print('I am in '+ str(i) + 'th iteration\n')
		for j in range(i):
			f.write(str(index2id[i]) + ' ' + str(index2id[j])+' '+ str(int(co_occur_matrix[i][j]))+'\n')

pickle.dump(index2id,open('index2id.pkl','wb'))