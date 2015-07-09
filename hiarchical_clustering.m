function [ret_val] = hiarchical_clustering(data,index,num_leaves)
	global gb_centers;
	global valid_index;
	if index >= num_leaves
		ret_val = true;
		return;
	else
		[centers, assgn] = vl_kmeans(data,2);
		data1 = data(:,assgn == 1);
		data2 = data(:,assgn == 2);
		gb_centers(:,2*index) = centers(:,1);
		gb_centers(:,2*index + 1) = centers(:,2);
		if size(data1,2) > 10
			ret_val = hiarchical_clustering(data1,2*index,num_leaves);
			valid_index(2*index) = 1;
		else
			valid_index(2*index) = 0;
			ret_val = 0;
		end

		if size(data2,2) > 10
			rv = hiarchical_clustering(data2,2*index + 1,num_leaves);
			valid_index(2*index + 1) = 1;
		else
			valid_index(2*index + 1) = 0;
			rv = 0;
		end
		ret_val = or(rv,ret_val);
	end
end