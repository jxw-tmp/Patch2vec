run('/home/kundan/cv-libs/vlfeat-0.9.20/toolbox/vl_setup');
load('MIT_indoor_dataset_elements.mat');
load('data_partition_train_test_MIT.mat');
% file_names = create_sample_for_vocab_generation(2000,train_set,MIT_data_set.image_names);
% [locs,sifts] = calculate_sift_for_image_set(file_names);
% all_sifts = []
% for i = 1: numel(sifts)
% 	if size(sifts{i},1) > 1
% 		all_sifts = [all_sifts,sifts{i}];
% 	end
% end

numclusters = 8192; % usually a power of 2

numdimensions = 2;

global valid_index;

valid_index = zeros(numclusters*2 - 1,1);

all_sifts = double(all_sifts);
size(all_sifts)
global gb_centers;
global cluster_centers;
global gb_embeddings;
gb_centers = zeros(128,numclusters*2 - 1);
gb_embeddings = rand(numdimensions,numclusters*2 - 1)*2 - 1;

hiarchical_clustering(all_sifts,1,numclusters);
valid_index(1) = 1;

cluster_centers = gb_centers(:,numclusters:end);

% global center_kd_tree;
% center_kd_tree = vl_kdtreebuild(cluster_centers);


train_on_images

% [tree,assgn] = vl_hikmeans(all_sifts,2,numclusters);

% kdtree = vl_kdtreebuild(centers);

% % global vector_representation;

% vector_representation = rand(2*size(centers,2) - 1,numdimensions);


% % vector_representation = train_on_single_image(kdtree,vector_representation, centers, MIT_data_set.image_names{train_set(1001)});

% train_on_images