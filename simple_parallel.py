from joblib import Parallel, delayed  
import multiprocessing

def add_num(a,b):
	return a+b


results = Parallel(n_jobs=5)([delayed(add_num)(1,2),delayed(add_num)(2,2),delayed(add_num)(3,2),delayed(add_num)(4,2)]) 
print results