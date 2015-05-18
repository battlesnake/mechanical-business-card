include <../config.scad>
include <../geometry/cloud-frames.scad>
include <../shapes/3-reciprocator-wheel.scad>
include <../shapes/3-reciprocator-pinion.scad>
include <../shapes/3-reciprocator-pin.scad>

module reciprocator(i, explode = 0) {
	baseFrame = cloudFrames[i];
	frameCorrection = cloudCorrections[i];
	rotation = gearRotations[i];
	/* Wheel */
	translate([0, 0, -explode]) {
		linear_extrude(height = thick, slices = 1) {
			multmatrix(m = baseFrame) {
				rotate(rotation + frameCorrection, [0, 0, 1]) {
					reciprocatorWheelShape();
				}
			}
		}
	}
	/* Pinion */
	translate([0, 0, -explode / 2]) {
		linear_extrude(height = thick, slices = 1) {
			multmatrix(m = baseFrame) {
				rotate(frameCorrection, [0, 0, 1]) {
					translate([reciprocatorAngleToDisplacement(rotation), 0]) {
						reciprocatorPinionShape();
					}
				}
			}
		}
	}
	/* Pin */
	linear_extrude(height = thick, slices = 1) {
		multmatrix(m = baseFrame) {
			rotate(frameCorrection, [0, 0, 1]) {
				translate(reciprocatorPinOffset +
					[reciprocatorAngleToDisplacement(rotation), 0]) {
					reciprocatorPinShape();
				}
			}
		}
	}
}

