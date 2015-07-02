# import pickle
# count_dict = dict();
# with open('existing_patch_ids_in_data_new3.txt','rb') as f:
# 	for line in f:
# 		num = line.strip()
# 		count_dict[num] = 0
# j = 0;
# with open('image_name_with_patches_new3.txt','rb') as f:
# 	for line in f:
# 		print("I am in "+str(j)+"th iteration.\n")
# 		j += 1;
# 		ids = line.strip().split('$')[1].strip().split()
# 		for patch_id in ids:
# 			count_dict[patch_id] += 1

# with open('count_ids.txt','wb') as f:
# 	for key in count_dict:
# 		f.write(key + ' ' + str(count_dict[key]) + '\n')

import numpy as np

counts = np.loadtxt('count_ids.txt')

sorted_count = counts[counts[:,1].argsort()[::-1]]

# np.savetxt('sorted_count_ids.txt',sorted_count,delimiter=' ',fmt='%d')

indices = sorted_count[0:1098,0]
check_dict = dict()
j = 0;
c = 0;
c2 = 0;
maxm = 0
minm = 100000
for key in indices:
	check_dict[key] = 1;
with open('new_sentences.txt','wb') as f1:
	with open('image_name_with_patches_new3.txt','rb') as f:
		for line in f:
			print("I am in "+str(j)+"th iteration.\n")
			j += 1;
			ids = line.strip().split('$')[1].strip().split()
			co1 = 0
			# co2 = 0
			for patch_id in ids:
				if int(patch_id) in check_dict:
					f1.write(patch_id + ' ')
					c += 1
					co1 += 1
					# co2 += 1
				c2 += 1
				if co1 > maxm:
					maxm = co1
				if co1 < minm:
					minm = co1

			f1.write('\n')
		print float(c)/1333
		print float(c2)/1333
		print maxm
		print minm

