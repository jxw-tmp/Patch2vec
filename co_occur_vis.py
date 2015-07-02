import numpy as np

co_occur = np.loadtxt('sorted_co_occur_count_freq.txt',dtype=np.int)
with open('co_occur_freq_vis.html','wb') as f:
	f.write('<html><head></head><table>\n')
	for i in range(5000):
		f.write('<tr><td><img src="base_address/'+str(co_occur[i][0])+'.jpg"></td><td><img src="base_address/'+str(co_occur[i][1])+'.jpg"></td><td>'+str(co_occur[i][2])+'</td></tr>\n')
	f.write('</table></html>')