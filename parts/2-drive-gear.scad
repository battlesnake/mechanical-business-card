include <../config.scad>
include <../shapes/2-drive-gear.scad>

module driveGear() {
	linear_extrude(height = thick - spacing * 2, slices = 1) {
		translate([driveGearRadius - driveGearExposed, cardSize[1] / 2, spacing]) {
			rotate(driveGearRotation, [0, 0, 1]) {
				driveGearShape();
			}
		}
	}
}
