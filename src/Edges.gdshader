shader_type canvas_item;
uniform float sigma1 = 0.8;
uniform float sigma2 = 2.0;
uniform float threshold = 0.02;
uniform bool redo = true;
float get_grey(vec4 color) {
	return .21 * color.r + .71 * color.g + .07 * color.b; // grey color
}


void fragment() {
    COLOR = texture(TEXTURE, UV); // Get pixel color from the image texture

	// Initialize a 5x5 kernel matrix
	float kernel[25] = float[25];

	int kernel_size = 5;
	float sum = 0.0;
	int deviation = (kernel_size - 1)/2;
	for(int i = 0; i < kernel_size; i++) {
		for (int j=0; j < kernel_size; j++) {
			float x = float(i - deviation) ;
			float y = float(j - deviation);
			float diff = (1.0 / (2.0 * PI * sigma1 * sigma1)) * exp(-(x * x + y * y) / (2.0 * sigma1 * sigma1));
			kernel[kernel_size*i+j] = diff;
			sum += diff;
		}
	}
	// Normalize the kernel so that its values sum to 1
	for(int i = 0; i< kernel_size; i++) {
		for (int j=0; j < kernel_size; j++) {
			kernel[kernel_size*i+j] /= sum;
		}
	}

	float kernel_2[49] = float[49];
	int kernel_size_2 = 7;
	float sum_2 = 0.0;
	int deviation_2 = (kernel_size_2 - 1)/2;
	for(int i = 0; i < kernel_size_2; i++) {
		for (int j=0; j < kernel_size_2; j++) {
			float x = float(i - deviation_2) ;
			float y = float(j - deviation_2);
			float diff = (1.0/(2.0*PI*sigma2*sigma2)) * exp(-(x*x + y*y)/ (2.0*sigma2*sigma2) );
			kernel_2[kernel_size_2*i+j] = diff;
			sum_2 += diff;
		}
	}
	// Normalize the kernel so that its values sum to 1
	for(int i = 0; i< kernel_size_2; i++) {
		for (int j=0; j < kernel_size_2; j++) {
			kernel_2[kernel_size_2*i+j] /= sum_2;
		}
	}


	// Aplying the filter (small one)
	float sum_r = 0.0;
	for(int i = 0; i<kernel_size; i++) {
		for (int j=0; j < kernel_size; j++) {
			float py = float( j - 2);			
			float px = float( i - 2);
			vec2 mask_UV = UV + vec2(px,py)*TEXTURE_PIXEL_SIZE;
			float grey_point = get_grey(texture(TEXTURE, mask_UV));
			sum_r += grey_point * kernel[kernel_size*i+j];
		}
	}

	// Aplying the filter (big one)
	float sum_r2 = 0.0;
	for(int i = 0; i<kernel_size_2; i++) {
		for (int j=0; j < kernel_size_2; j++) {
			float py = float( j - 3);			
			float px = float( i - 3);
			vec2 mask_UV = UV + vec2(px,py)*TEXTURE_PIXEL_SIZE;
			float grey_point = get_grey(texture(TEXTURE, mask_UV));
			sum_r2 += grey_point * kernel_2[kernel_size_2*i+j];
		}
	}

	// DoG result
	float result = abs(sum_r-sum_r2);
	if (result > threshold) {
		result = 1.0;
	} else {
		result = 0.0;
	}
	if (redo) {
		COLOR = vec4(vec3(1.0-result), 1.0);
	}
}