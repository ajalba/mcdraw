shader_type canvas_item;
uniform float sigma1 = 1.0;
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
	COLOR.rgb = vec3(sum_r);
	// Aplying the filter (big one)

	// DoG result
//	float result = abs(sum_r-sum_r2);
//	if (result > threshold) {
//		result = 1.0;
//	} else {
//		result = 0.0;
//	}
//	if (redo) {
//		COLOR = vec4(vec3(1.0-result), 1.0);
//	}
}