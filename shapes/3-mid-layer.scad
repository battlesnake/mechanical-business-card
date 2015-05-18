include <../config.scad>
include <../generators/layer.scad>
include <../generators/gear.scad>
include <../geometry/cloud-frames.scad>
include <../shapes/3-reciprocator-pinion.scad>

module midLayerShape() {
	difference() {
		layer();
		/* Drive gear axle */
		translate([driveGearRadius - driveGearExposed, cardSize[1] / 2]) {
			circle(r = driveGearAxleRadius - 0.1, center = true);
		}
		/* Cloud gear axles */
		for (i = [0:2]) {
			multmatrix(m = cloudFrames[i]) {
				rotate(cloudCorrections[i], [0, 0, 1]) {
					reciprocatorHousingShape();
				}
			}
		}
	}
}
