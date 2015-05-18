include <../config.scad>
include <../geometry/cloud-frames.scad>
include <../shapes/2-drive-gear.scad>

module driveGear() {
	linear_extrude(height = thick, slices = 1) {
		multmatrix(driveFrame) {
			rotate(driveGearRotation, [0, 0, 1]) {
				driveGearShape();
			}
		}
	}
}
