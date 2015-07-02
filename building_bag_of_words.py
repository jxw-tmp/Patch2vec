import itertools as it
import numpy as np
import pickle

freq_ids = np.loadtxt('sorted_count_ids.txt')
freq_ids = freq_ids[0:1098,0]