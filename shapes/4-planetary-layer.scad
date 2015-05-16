include <../config.scad>
include <../generators/layer.scad>
include <../generators/gear.scad>

module planetaryLayerShape() {
	difference() {
		layer();
		translate([driveGearRadius * 2 + sunGearRadius - driveGearExposed, cardSize[1] / 2]) {
			rotate(annularGearRotation, [0, 0, 1]) {
				gear(annularGearTeeth, spokes = false, holeRadius = false, annular = true);
			}
		}
	}
}
