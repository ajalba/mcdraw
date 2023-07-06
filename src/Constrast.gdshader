shader_type canvas_item;
uniform bool redo = true;
float get_grey(vec4 color) {
	return .21 * color.r + .71 * color.g + .07 * color.b; // grey color
}

void fragment() {
	if (redo) {
		vec4 color = texture(TEXTURE, UV);
		COLOR.rbg = vec3(get_grey(color));
	}
}