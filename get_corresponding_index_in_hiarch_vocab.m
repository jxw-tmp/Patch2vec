function [index] = get_corresponding_index_in_hiarch_vocab(sifts)
	sz_sifts = size(sifts,2);
	index = [];
	for i=1:sz_sifts
		index(i) = find_index_for_sift(sifts(:,i));
	end
end