shader_type canvas_item;
uniform sampler2D img_texture;
uniform bool can_mix;

void fragment() {
	vec4 base_pixel = texture(TEXTURE, UV);
	vec4 texture_pixel = texture(img_texture, UV);
//	if (can_mix) {
//		COLOR.rgb = mix(base_pixel.rgb, texture_pixel.rgb + 0.5, 1.0);
//	} else {
//		COLOR = base_pixel;
//	}
	if (can_mix) {
		COLOR = texture_pixel;
	} else {
		COLOR = base_pixel;
	}
}
