include <../config.scad>
include <../generators/gear.scad>

module driveGearShape() {
	gear(driveGearTeeth, spokes = 6, rimRadius = 4, spokeWidth = 4, holeRadius = driveGearAxleRadius, hubRadius = 6);
}
