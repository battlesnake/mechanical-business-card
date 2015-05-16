include <../config.scad>
include <../generators/layer.scad>
include <../generators/gear.scad>

module midLayerShape() {
	difference() {
		layer();
		/* Hole for sun gear */
		translate([driveGearRadius * 2 + sunGearRadius - driveGearExposed, cardSize[1] / 2]) {
			gearHousing(sunGearTeeth);
		}
		/* Drive gear axle */
		translate([driveGearRadius - driveGearExposed, cardSize[1] / 2]) {
			circle(r = 1.9, center = true);
		}
	}
}
