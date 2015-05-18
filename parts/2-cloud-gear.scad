include <../config.scad>
include <../geometry/cloud-frames.scad>
include <../shapes/2-cloud-gear-1.scad>
include <../shapes/2-cloud-gear-2.scad>
include <../shapes/2-cloud-gear-3.scad>

module cloudGear(i) {
	linear_extrude(height = thick, slices = 1) {
		multmatrix(cloudFrames[i]) {
			rotate(gearRotations[i], [0, 0, 1]) {
				if (i == 0) {
					cloudGear1Shape();
				} else if (i == 1) {
					cloudGear2Shape();
				} else if (i == 2) {
					cloudGear3Shape();
				}
			}
		}
	}
}
