shader_type canvas_item;

uniform float speed = 0.15;

void fragment() {
	vec2 offset = vec2(TIME * speed, 0.0);
	COLOR = texture(TEXTURE, UV + offset);
}
