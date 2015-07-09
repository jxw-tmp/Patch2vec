function [ind] = find_index_for_sift(sift)
	global gb_centers;
	global valid_index;
	left = 2;
	right = 3;
	while(true)
		dist_left = norm(sift - gb_centers(:,left));
		dist_right = norm(sift - gb_centers(:,right));
		if( dist_right > dist_left)
			if or(2*right > size(valid_index,1),valid_index(right) == 0)
				ind = right;
				return;
			else
				left = 2*right;
				right = 2*right + 1;
			end
		else
			if or(2*left > size(valid_index,1),valid_index(left) == 0)
				ind = left;
				return;
			else
				right = 2*left + 1;
				left = 2*left;
			end
		end
	end
end