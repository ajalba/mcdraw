shader_type canvas_item;
uniform sampler2D contrast_texture;
uniform sampler2D edges_texture;
float custom_round(float num, int places) {
	return round(num * 100.0)/100.0;
}

void fragment() {
	vec4 contrast_color = texture(contrast_texture, UV);
	vec4 edges_color = texture(edges_texture, UV);
	float value = 1.0-(contrast_color.r * 0.5 + edges_color.r * 0.5);
	if (value < 0.1) {
		COLOR.rgb = vec3(0.0);
	} else {
		
		COLOR.rgb = vec3(value); 	
	}
}