
ALPHA = 0.07;
for epoch = 1:10
	for i = 1:8000
		fprintf('Training on image no. %d\n',i);
		j = 2000 + i;
		try
			log_likelihood = train_on_single_image(MIT_data_set.image_names{train_set(j)},numclusters,ALPHA);
			fprintf('Log-likelihood on current image is %.14f\n',log_likelihood);
		catch exception
			fprintf('Error in converting the image, discarding training on it.');
		end
	end
	save(strcat('embedding_epoch_',num2str(epoch),'.mat'),'gb_embeddings');
	ALPHA = ALPHA*0.25;
end