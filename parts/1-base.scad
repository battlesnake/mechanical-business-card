include <../config.scad>
include <../shapes/1-base.scad>

module base() {
	linear_extrude(height = thin, slices = 1) {
		baseShape();
	}
}
