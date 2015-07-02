fnew = fopen('co_occuring_words.txt','a+');
fhtml = fopen('co_occuring_vis.html','a+');
fprintf(fhtml,'<html><head></head><table>\n');
for i = 0:5000
	fprintf(fnew,'%d %d %d\n',co_occur_shorted(end - i,1),co_occur_shorted(end - i,2),co_occur_shorted(end - i,3));
	fprintf(fhtml,'<tr><td><img src="base_address/%d.jpg"></td><td><img src="base_address/%d.jpg"></td><td>%d</td></tr>\n',co_occur_shorted(end - i,1),co_occur_shorted(end - i,2),co_occur_shorted(end - i,3));
end

fclose(fnew);
fclose(fhtml);