include <../config.scad>
include <../shapes/2-cloud-gear-3.scad>
include <../geometry/cloud-frames.scad>

module cloudGear3() {
	linear_extrude(height = thick, slices = 1) {
		multmatrix(cloudFrames[2]) {
			rotate(gearRotations[2], [0, 0, 1]) {
				cloudGear3Shape();
			}
		}
	}
}
