include <../config.scad>
include <../shapes/4-planetary-gears.scad>

module planetaryGears() {
	linear_extrude(height = thick, slices = 1) {
		translate([driveGearRadius * 2 + sunGearRadius - driveGearExposed, cardSize[1] / 2]) {
			for (i = [0:planetCount-1]) {
				rotate(i * 360 / planetCount + planetCarrierRotation, [0, 0, 1]) {
					translate([sunGearRadius + planetGearRadius, 0]) {
						rotate(planetGearRotation, [0, 0, 1]) {
							planetaryGearsShape();
						}
					}
				}
			}
		}
	}
}
