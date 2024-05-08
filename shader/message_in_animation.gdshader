shader_type canvas_item;
uniform float offset=0;

varying vec2 uv_new;
void vertex() {
	
	// Called for every vertex the material is visible on.
}

void fragment() {
	if(UV.x<offset){
		COLOR.a=0.0;
	}
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
