include <../config.scad>
include <../shapes/2-cloud-gear-2.scad>
include <../geometry/cloud-frames.scad>

module cloudGear2() {
	linear_extrude(height = thick, slices = 1) {
		multmatrix(cloudFrames[1]) {
			rotate(gearRotations[1], [0, 0, 1]) {
				cloudGear2Shape();
			}
		}
	}
}