import numpy as np

# Y = np.empty(5343,dtype=np.int)

class_descriptor = dict()

ids = []
j = 0;

train_file = open('train_data.txt','wb')

with open('image_name_with_patches_train.txt','rb') as f:
	for line in f:
		parts = line.strip().split('$')
		ids += [parts[1].strip()]
		class_descriptor[j] = parts[0].strip().split()[1].split('/')[0]
		j += 1;

with open('label_train.txt','wb') as f:
	for j in range(5343):
		f.write(class_descriptor[j] + '\n')
		train_file.write(ids[j]+'\n')