include <../config.scad>
include <../generators/layer.scad>
include <../generators/gear.scad>

module driveLayerShape() {
	difference() {
		layer();
		translate([driveGearRadius - driveGearExposed, cardSize[1] / 2]) {
			gearHousing(driveGearTeeth);
		}
		translate([driveGearRadius * 2 + sunGearRadius - driveGearExposed - gearOverlap, cardSize[1] / 2]) {
			gearHousing(sunGearTeeth);
		}
	}
}
