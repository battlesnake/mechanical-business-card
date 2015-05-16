include <../config.scad>
include <../shapes/1-base.scad>

module infoLayer() {
	/* Rendered the engraving as another solid instead of subtracting, as SCAD won't display it otherwise */
	/* Plastic */
	linear_extrude(height = thick, slices = 1) {
		baseShape();
	}
}
