import itertools as it
import numpy as np
import pickle

freq_ids = np.loadtxt('sorted_count_ids.txt')
freq_ids = freq_ids[0:1098,0]
co_occur_matrix = np.zeros((1098,1098),dtype=np.int)
id2index_freq = dict()
index2id_freq = dict()
j = 0;

for pid in freq_ids:
	id2index_freq[pid] = j
	index2id_freq[j] = pid
	j += 1;

with open('new_sentences.txt','rb') as f:
	for line in f:
		ids = [int(k) for k in line.strip().split()]
		for id1,id2 in it.combinations(ids,2):
			co_occur_matrix[id2index_freq[id1]][id2index_freq[id2]] += 1 
			co_occur_matrix[id2index_freq[id2]][id2index_freq[id1]] += 1

with open('co_occur_count_freq.txt','wb') as f:
	for i in range(1098):
		for j in range(i):
			f.write(str(index2id_freq[i]) + ' ' + str(index2id_freq[j]) + ' ' + str(co_occur_matrix[i][j]) + '\n')

co_occur_matrix_expanded = np.loadtxt('co_occur_count_freq.txt')

# co_occur_matrix_expanded = int(co_occur_matrix_expanded)

sorted_co_occur_matrix_expanded = co_occur_matrix_expanded[co_occur_matrix_expanded[:,2].argsort()[::-1]]

np.savetxt('sorted_co_occur_count_freq.txt',sorted_co_occur_matrix_expanded,fmt='%d',delimiter=' ')
