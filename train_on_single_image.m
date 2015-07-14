function [log_likelihood] = train_on_single_image(image_name,num_clusters,ALPHA)
	%{
	Variables:

	cluster_centers: global variable that represents the cluster centers corresponding to SIFT vocabulary.
				It hasb been obtained by sampling dense SIFTs from 1000 images and running 
				hiarchical clustering on them i.e. first clustering into two clusters, 
				then, recursively dividing each cluster into 2 until a fixed number of leaves is not found.
				For details, see hiarchical clustering.m

	gb_embeddings: Global variable that stores embeddings for internal nodes in hiarchical soft-max 
				and also the representaion for each word(leaf nodes).

	center_kd_tree: kd_tree built around the cluster_centers


	%}
	global cluster_centers;
	global gb_embeddings;
	%Getting SIFTs from given example image for training and building kd-tree on the SIFTs centers
	[locs,sifts] = im2sift(image_name);
	sifts = double(sifts);

	%getting context from images
	x_min  = min(locs(1,:));
	x_max = max(locs(1,:));
	y_min = min(locs(2,:));
	y_max = max(locs(2,:));

	c1 = [x_min + (x_max - x_min)/3; y_min + (y_max - y_min)/3];
	c2 = [x_min + 2*(x_max - x_min)/3; y_min + 2*(y_max - y_min)/3];
	c3  = [x_min + 2*(x_max - x_min)/3; y_min + (y_max - y_min)/3];
	c4 = [x_min + (x_max - x_min)/3; y_min + 2*(y_max - y_min)/3];

	centers = [c1,c2,c3,c4];

	centers_kd_tree = vl_kdtreebuild(centers);

	assgn = vl_kdtreequery(centers_kd_tree,centers,locs);


	%Need to be replaced by getting image patches in a circle 
	index = get_corresponding_index_in_hiarch_vocab(sifts);

	contxt1 = unique(index(assgn == 1));
	contxt2 = unique(index(assgn == 2));
	contxt3 = unique(index(assgn == 3));
	contxt4 = unique(index(assgn == 4));

	all_contexts = {contxt1,contxt2,contxt3,contxt4};

	% size(index)
	useful_indices = unique(index);
	% size(useful_indices)
	% getting indices of all the leaf nodes being used
	useful_grad_indices = useful_indices;


	% arr will contain all the nodes that will be updated while training on this image

	arr = [];
	count = 1;
	for i = 1 : numel(useful_grad_indices)
		curr = useful_grad_indices(i);
		while curr > 1
			arr(count) = curr;
			curr = floor(curr/2);
			count = count+1;
		end
	end
	arr(count) = 1;

	useful_grad_indices = unique(arr);

	%grad will contain gradients for each of the nodes used in this iteration

	grad = zeros(size(gb_embeddings,1),numel(useful_grad_indices));

	% a dictionary that will map from the vocabulary index to the column index of grad
	map_index_to_arrpos = containers.Map(useful_grad_indices,1:numel(useful_grad_indices));

	%number of nodes from root to leaf
	% path_length = ceil(log2(num_clusters));


	%Calculating gradient update from each pair of word
	average_log_probab = 0.0;
	for num_context = 1:numel(all_contexts)
		% count_el = 1;
		% forward_prob_array= [];
		log_likelihood = 0.0;
		for i = 1: numel(all_contexts{num_context})
			for j = 1: numel(all_contexts{num_context})
				if i == j
					continue;
				end
				forward_probab = 1.0;
				ind1 = all_contexts{num_context}(i);
				ind2 = all_contexts{num_context}(j);
				v_w_ind1 = gb_embeddings(:,ind1);
				current_internal_node_indices = [];
				current_internal_node_indices(1) = fix(ind2/2);
				path_length = floor(log2(ind2));
				for k = 2: path_length
					current_internal_node_indices(k) = fix(current_internal_node_indices(k-1)/2);
				end
				current_internal_node_indices = current_internal_node_indices';
				internal_node_embs = gb_embeddings(:,current_internal_node_indices);

				internal_node_embs_dot_v_w_ind1 = internal_node_embs'*v_w_ind1;
				sigma_internal_sign = [];
				sigma_internal_sign(1) = (mod(ind2,2))*2 - 1;
				for k = 2:path_length
					sigma_internal_sign(k) = (mod(current_internal_node_indices(k-1),2))*2 - 1;
				end
				sigma_internal_sign = sigma_internal_sign';
				internal_node_embs_dot_v_w_ind1_sign = internal_node_embs_dot_v_w_ind1 .* sigma_internal_sign;
				sigma_internal_node_with_sign = exp(-1 * internal_node_embs_dot_v_w_ind1_sign);
				sigma_internal_node_with_sign = 1./( 1 + sigma_internal_node_with_sign);

		
				log_forward_probab = sum(log(sigma_internal_node_with_sign));
				log_likelihood = log_likelihood + log_forward_probab;
				forward_probab = exp(log_forward_probab);

				sigma_derivative_with_sign = (sigma_internal_node_with_sign.*(1 - sigma_internal_node_with_sign)).*sigma_internal_sign;
				grad_ind1 = (1/(2.0*numel(all_contexts{num_context})*numel(all_contexts{num_context})*forward_probab))*(internal_node_embs*(sigma_derivative_with_sign));
				
				grad(:,map_index_to_arrpos(ind1)) = grad(:,map_index_to_arrpos(ind1)) + grad_ind1;
				for k = 1:numel(current_internal_node_indices)
					grad(:,map_index_to_arrpos(current_internal_node_indices(k))) = grad(:,map_index_to_arrpos(current_internal_node_indices(k))) + ((1/(2.0*numel(all_contexts{num_context})*numel(all_contexts{num_context})*forward_probab))*sigma_derivative_with_sign(k)*v_w_ind1);
				end
				% forward_prob_array(count_el) = forward_probab;
				% count_el = count_el + 1;
			end
		end
		average_log_probab = average_log_probab + log_likelihood/(numel(all_contexts{num_context})*numel(all_contexts{num_context}));
		break;
	end

	log_likelihood = average_log_probab/numel(all_contexts);

	for i = 1:numel(useful_grad_indices(i))
		gb_embeddings(:,useful_grad_indices(i)) = gb_embeddings(:,useful_grad_indices(i)) + ALPHA*(grad(:,i));
	end
end