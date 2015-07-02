import numpy as np
import scipy as sp
import pickle

index2id = pickle.load(open('index2id_new.pkl','rb'))
id2index = pickle.load(open('id2index_new.pkl','rb'))

print "Working with 0.5"
co_occur_matrix = pickle.load(open('co_occur_0.5_new.pkl','rb'))
U,s,V = np.linalg.svd(co_occur_matrix)

pickle.dump(s,open('eigen_values_0.5_new.pkl','wb'))
pickle.dump(U,open('principal_components0.5_new.pkl','wb'))

print "Working with 0.4"
co_occur_matrix = pickle.load(open('co_occur_0.4_new.pkl','rb'))
U,s,V = np.linalg.svd(co_occur_matrix)
pickle.dump(s,open('eigen_values_0.4_new.pkl','wb'))
pickle.dump(U,open('principal_components0.4_new.pkl','wb'))



print "Working with 0.6"
co_occur_matrix = pickle.load(open('co_occur_0.6_new.pkl','rb'))
U,s,V = np.linalg.svd(co_occur_matrix)
pickle.dump(s,open('eigen_values_0.6_new.pkl','wb'))
pickle.dump(U,open('principal_components0.6_new.pkl','wb'))

# f10 = open('co_occur_pc10_04.txt','wb')
# f20 = open('co_occur_pc20_04.txt','wb')

# data = np.loadtxt('train_bow_0.4.txt')
# transformed_apace = data*U[:,0:20]

# for i in len(data):
# 	for j in range(20):
# 		if j < 10:
# 			f10.write(str(data[i,j]) + ' ')
# 		f20.write(str(data[i,j]) + ' ')
# 	f10.write('\n')
# 	f20.write('\n')
# print('Done first file')

# f10 = open('co_occur_pc10_05.txt','wb')
# f20 = open('co_occur_pc20_05.txt','wb')

# data = np.loadtxt('train_bow_0.5.txt')
# transformed_apace = data*U[:,0:20]

# for i in len(data):
# 	for j in range(20):
# 		if j < 10:
# 			f10.write(str(data[i,j]) + ' ')
# 		f20.write(str(data[i,j]) + ' ')
# 	f10.write('\n')
# 	f20.write('\n')
# print('Done second file')

# f10 = open('co_occur_pc10_06.txt','wb')
# f20 = open('co_occur_pc20_06.txt','wb')

# data = np.loadtxt('train_bow_0.6.txt')
# transformed_apace = data*U[:,0:20]

# for i in len(data):
# 	for j in range(20):
# 		if j < 10:
# 			f10.write(str(data[i,j]) + ' ')
# 		f20.write(str(data[i,j]) + ' ')
# 	f10.write('\n')
# 	f20.write('\n')
# print('Done third file')
