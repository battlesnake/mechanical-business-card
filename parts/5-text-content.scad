include <../config.scad>
include <../shapes/5-text-content.scad>

module textContent(visible = false) {
	/* Rendered the engraving as another solid instead of subtracting, as SCAD won't display it otherwise */
	/* Underside engraving */
	if (visible) {
		linear_extrude(height = thick+0.01, slices = 1) {
			translate([5, 5]) {
				textContentShape();
			}
		}
	}
}

