shader_type canvas_item;
uniform sampler2D board_texture;
uniform vec4 point_color;
void fragment() {
//	vec3 a = texture(TEXTURE, UV).rgb;
//	vec3 b = texture(board_texture, UV).rgb * point_color.rgb;
////	vec3 color = abs(a-b);
//	vec3 color = mix(a, b, 1.0-a.r);
//	COLOR.rgb = color;
//	COLOR = texture(TEXTURE, UV);
	vec3 a = texture(TEXTURE, UV).rgb;
	vec3 b = texture(board_texture, UV).rgb * point_color.rgb;
	vec4 colora = texture(TEXTURE, UV);
	vec4 colorb = texture(board_texture, UV);
	COLOR.rgb = b;
	if (colora.r > 0.9) {
		COLOR.a = 0.0;
//		COLOR.a = 1.0 - colora.r;
	} else {
		COLOR.a = colora.a;
	}
}
