run('/home/kundan/cv-libs/vlfeat-0.9.20/toolbox/vl_setup');
files = load_image_names_from_dir('train/abc','*.jpg')
[locs,sifts] = calculate_sift_for_image_set(files);
