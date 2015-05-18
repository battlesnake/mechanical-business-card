include <../config.scad>
include <../shapes/2-cloud-gear-1.scad>
include <../geometry/cloud-frames.scad>

module cloudGear1() {
	linear_extrude(height = thick, slices = 1) {
		multmatrix(cloudFrames[0]) {
			rotate(gearRotations[0], [0, 0, 1]) {
				cloudGear1Shape();
			}
		}
	}
}
