prev = 'abc'
i = 0;
with open('label_train.txt','rb') as f:
	with open('label_train_num.txt','wb') as f1:
		for line in f:
			if line.strip() != prev:
				i += 1;
				prev = line.strip()
			f1.write(str(i) + '\n')