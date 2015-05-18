include <../config.scad>
include <../generators/gear.scad>
include <../geometry/cloud-frames.scad>

module reciprocatorWheelShape() {
	intersection() {
		gear(reciprocatorFullTeeth - gearErrorSpace, spokes = 0, overlap = reciprocatorTeethPitch);
		union() {
			circle(r = reciprocatorInnerRadius, center = true);
			square(-reciprocatorOuterRadius * [-1, -1], center = false);
		}
	}
}
