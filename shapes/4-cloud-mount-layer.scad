include <../config.scad>
include <../generators/layer.scad>
include <3-reciprocator-pin.scad>
include <4-cloud.scad>

module cloudMountLayerShape() {
	difference() {
		layer();
		/* Cloud pin windows */
		for (i = [0:2]) {
			multmatrix(m = cloudFrames[i]) {
				rotate(cloudCorrections[i]) {
					translate(reciprocatorPinOffset) {
						minkowski() {
							reciprocatorPinWindowShape();
							cloudWindowShape();
						}
					}
				}
			}
		}
	}
}
