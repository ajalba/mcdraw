shader_type canvas_item;
//uniform float conv_factor = 0.2;
render_mode blend_mix;
uniform sampler2D board_texture;
void fragment() {
//	float value = texture(TEXTURE, UV).r;
////	COLOR.rbg = vec3(conv_factor*value);
////	COLOR.rbg = vec3(conv_factor * value);
//
//	COLOR.rbg = vec3(0.0);
	vec3 a = texture(TEXTURE, UV).rgb * 0.6;
	vec3 b = texture(board_texture, UV).rgb;
	vec3 color = mix(a, b, 0.2);
	COLOR.rgb = color;

//	COLOR = texture(TEXTURE, UV);
}
