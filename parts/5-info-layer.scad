include <../config.scad>
include <../shapes/1-base.scad>
include <../shapes/5-text-content.scad>

module infoLayer() {
	rotate(180, [0, 1, 0]) {
		difference() {
			topLayer();
			textContent(additive = false);
		}
	}
}

module topLayer() {
	/* Plastic */
	linear_extrude(height = thick, slices = 8) {
		baseShape();
	}
}

module textContent(additive = false) {
	/* Underside engraving */
	linear_extrude(height = additive ? (thick + 0.01) : thin, slices = 1) {
		translate([5, 5]) {
			textContentShape();
		}
	}
}
