import matplotlib.pyplot as plt
import numpy as np

import pickle

s = pickle.load(open('eigen_values_0.5_new.pkl','rb'))

sum_res = 0.0
cumulative_res = np.zeros(len(s))
for i in range(len(s)):
	sum_res += s[i]
	cumulative_res[i] = sum_res

for  i in range(len(s)):
	s[i] = (sum_res - cumulative_res[i])/sum_res

plt.title('Residual Variaance plot with dimension')
plt.plot(range(1,len(s)+1),s,'g-')
plt.savefig('residual_variance_plot.jpg')