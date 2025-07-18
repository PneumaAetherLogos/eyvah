shader_type canvas_item;

// 🎛️ Export edilen parametreler
uniform vec4 base_color : source_color = vec4(0.1, 0.4, 0.2, 1.0);
uniform vec4 highlight_color = vec4(0.3, 0.7, 0.4, 1.0);
uniform float vignette_strength : hint_range(0.0, 1.0) = 0.6;
uniform float wave_speed_x = 0.8;
uniform float wave_speed_y = 0.5;
uniform float wave_strength = 0.05;

uniform float time = 0.0;

void fragment() {
	vec2 uv = UV;

	// 🎞️ Dalgalanma hareketi
	float wave = sin(uv.x * 20.0 + time * wave_speed_x) * wave_strength +
				 sin(uv.y * 15.0 - time * wave_speed_y) * wave_strength;

	// 💡 Işık geçişi
	float intensity = fract(uv.x * 2.0 + uv.y * 2.0 + wave);
	vec3 final_color = mix(base_color.rgb, highlight_color.rgb, intensity);

	// 🔲 Vignette efekti
	float vignette = smoothstep(1.0, vignette_strength, distance(uv, vec2(0.5)));
	final_color *= mix(vec3(1.0), vec3(0.3), vignette);

	COLOR = vec4(final_color, 1.0);
}
