include <../config.scad>
include <../shapes/2-drive-gear.scad>

module driveGear() {
	linear_extrude(height = thick, slices = 1) {
		translate([driveGearRadius - driveGearExposed, cardSize[1] / 2]) {
			rotate(driveGearRotation, [0, 0, 1]) {
				driveGearShape();
			}
		}
	}
}
