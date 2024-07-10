shader_type spatial;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	 ALBEDO = vec3(255,0,0);
}

void light() {
	// Called for every pixel for every light affecting the material.
}
