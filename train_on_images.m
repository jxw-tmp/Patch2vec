
for i = 1:1000
	fprintf('Training on image no. %d\n',i);
	j = 3037 + i;
	try
		log_likelihood = train_on_single_image(MIT_data_set.image_names{j},numclusters);
		fprintf('Log-likelihood on current image is %.14f\n',log_likelihood);
	catch exception
		fprintf('Error in converting the image, discarding training on it.');
	end
	
end