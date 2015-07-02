import numpy as np

def mormalise_a_row(row):
	if np.linalg.norm(row) > 0:
		row = row/np.linalg.norm(row)
	return row
