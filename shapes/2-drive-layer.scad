include <../config.scad>
include <../generators/layer.scad>
include <../generators/gear.scad>
include <../geometry/cloud-frames.scad>

module driveLayerShape() {
	difference() {
		layer();
		multmatrix(driveFrame) {
			gearHousing(driveGearTeeth);
		}
		for (i = [0:2]) {
			multmatrix(cloudFrames[i]) {
				gearHousing(gearTeeth[i]);
			}
		}
	}
}
