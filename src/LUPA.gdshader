shader_type canvas_item;
uniform float x_coord;
uniform float y_coord;

void fragment() {
	COLOR = texture(TEXTURE, vec2(x_coord/1600.0,y_coord/900.0) );
}
