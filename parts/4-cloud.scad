include <../config.scad>
include <../geometry/cloud-frames.scad>
include <../shapes/3-reciprocator-pinion.scad>
include <../shapes/4-cloud.scad>

module cloud(i) {
	baseFrame = cloudFrames[i];
	frameCorrection = cloudCorrections[i];
	rotation = gearRotations[i];
	linear_extrude(height = thin, slices = 1) {
		multmatrix(m = baseFrame) {
			rotate(frameCorrection, [0, 0, 1]) {
				translate(reciprocatorPinOffset +
					[reciprocatorAngleToDisplacement(rotation), 0]) {
					cloudShape();
				}
			}
		}
	}
}
