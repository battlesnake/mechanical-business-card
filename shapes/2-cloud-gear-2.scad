include <../config.scad>
include <../generators/gear.scad>

module cloudGear2Shape() {
	gear(gearTeeth[1], spokes = 0);
}
