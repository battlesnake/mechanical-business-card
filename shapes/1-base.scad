include <../config.scad>
include <../generators/layer.scad>

module baseShape() {
	difference() {
		layer();
		/* Sun gear axle */
		translate([driveGearRadius * 2 + sunGearRadius - driveGearExposed, cardSize[1] / 2]) {
			circle(r = 0.4, center = true);
		}
	}
}
