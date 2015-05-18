include <../config.scad>
include <../generators/gear.scad>

module cloudGear1Shape() {
	gear(gearTeeth[0], spokes = 0);
}
