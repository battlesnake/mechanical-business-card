include <../config.scad>
include <../generators/gear.scad>

module sunGearShape() {
	gear(sunGearTeeth, spokes = 5, spokeWidth = 1, hubRadius = 2, rimRadius = 1);
}
