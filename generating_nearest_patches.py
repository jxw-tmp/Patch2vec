import gensim,logging

model = gensim.models.Word2Vec.load('test_image_10dim_reduced_vocab.model')

with open('nearest_patches_new3_10dim_reduced_vocab.txt','a') as fid:
	with open('existing_patch_ids_in_data_new3.txt','rb') as f:
		for line in f:
			line = line.strip()
			try:
				nn = model.most_similar(line)
				fid.write(line + ' ')
				for i,j in nn:
					fid.write(' '+str(i) + ' ' + str(j) )
				fid.write('\n')
			except :
				pass
