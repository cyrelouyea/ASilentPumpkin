shader_type canvas_item;
uniform vec4 color = vec4(vec3(0), 1);
uniform vec4 reduction = vec4(1);

void fragment() {
	COLOR = texture(TEXTURE, UV) * COLOR;
	
	if (!AT_LIGHT_PASS) {
		COLOR *= color;
	} else {
		COLOR *= reduction;
	}
}