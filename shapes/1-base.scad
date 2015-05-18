include <../config.scad>
include <../geometry/cloud-frames.scad>
include <../generators/layer.scad>

module baseShape() {
	difference() {
		layer();
		/* Cloud gear axles */
		for (i = [0:2]) {
			multmatrix(m = cloudFrames[i]) {
				circle(r = gearHoleRadius - 0.1, center = true);
			}
		}
	}
}
