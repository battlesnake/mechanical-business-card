include <../config.scad>
include <../generators/gear.scad>

module planetaryGearsShape() {
	gear(planetGearTeeth, holeRadius = 1.75, hubRadius = 2.5, spokeWidth = 1, rimRadius = 1.5, spokes = 3);
}
