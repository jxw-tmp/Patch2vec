import gensim,logging
from random import shuffle

dim_to_keep = 10
min_count_of_words = 3

list_sentences = [lines.strip().split() for lines in open('new_sentences.txt','rb')]

new_sentences = []
j = 0
for sentence in list_sentences:
	print("I am in "+str(j)+"th iteration\n")
	j += 1;
	if len(sentence) < 3 and len(sentence) > 0:
		new_sentences += [sentence]
	elif len(sentence) >= 3:
		for i in range(2*len(sentence)):
			shuffle(sentence)
			new_sentences += [sentence]


model = gensim.models.Word2Vec(min_count = min_count_of_words,size=dim_to_keep,window=20,sg=0,workers=16,iter=5)
model.build_vocab(list_sentences)
model.train(new_sentences)
model.save('test_image_10dim_reduced_vocab.model')

