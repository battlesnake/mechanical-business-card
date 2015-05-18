include <../config.scad>
include <../generators/gear.scad>

module cloudGear3Shape() {
	gear(gearTeeth[2], spokes = 0);
}
