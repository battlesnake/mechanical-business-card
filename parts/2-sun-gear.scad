include <../config.scad>
include <../shapes/2-sun-gear.scad>

module sunGear() {
	linear_extrude(height = thick * 2 + thin * 2 - spacing * 2, slices = 1) {
		translate([driveGearRadius * 2 + sunGearRadius - driveGearExposed, cardSize[1] / 2, spacing]) {
			rotate(sunGearRotation, [0, 0, 1]) {
				sunGearShape();
			}
		}
	}
}
