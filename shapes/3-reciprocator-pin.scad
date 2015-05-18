include <../config.scad>
include <../geometry/cloud-frames.scad>

module reciprocatorPinShape() {
	square(reciprocatorPinSize, center = true);
}

module reciprocatorPinWindowShape() {
	square(reciprocatorPinSize + [2, 0] * reciprocatorRadius, center = true);
}
