
for i = 1:1000
	fprintf('Training on image no. %d\n',i);
	j = 2000 + i;
	likelihood = train_on_single_image(MIT_data_set.image_names{j},numclusters);
	fprintf('Likelihood on current image is %.14f\n',likelihood);
end