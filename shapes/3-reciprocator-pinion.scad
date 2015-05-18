include <../config.scad>

module reciprocatorRoundRect(size, rounding) {
	radius = min(size) * rounding;
	difference() {
		square(size, center = true);
		for (i = [-1, 1])
			for (j = [-1, 1])
				translate([i * (size[0] / 2), j * (size[1] / 2)])
				translate(-radius * [i, j])
					difference() {
						scale([i, j])
							square((radius + 1) * [1, 1], center = false);
						circle(r = radius, center = false);
					}
	}
}

function flatten(l) = [for (a = l) for (b = a) b];

module reciprocatorPinionShape() {
	difference() {
		union() {
			reciprocatorRoundRect(reciprocatorPinionOuterSize, reciprocatorRounding);
			translate(reciprocatorPinOffset)
				square(reciprocatorPinFrameSize, center = true);
		}
		/* Central hole */
		reciprocatorRoundRect(reciprocatorPinionInnerSize, reciprocatorRounding);
		/* Pin hole */
		translate(reciprocatorPinOffset)
			square(reciprocatorPinSize, center = true);
		/* Teeth */
		teethDefs = flatten([for (i = [0:reciprocatorTeeth - 1]) [
			[i + 1/6, 0.4],
			[i + 2/6, 1],
			[i + 4/6, 1],
			[i + 5/6, 0.4]
		]]);
		teethPts = flatten([
			[[-gearToothWidth, -0.5]],
			[for (def = teethDefs)
				[def[0] * gearToothWidth, def[1] * (gearOverlap + gearErrorSpace)]
			],
			[[(reciprocatorTeeth + 1) * gearToothWidth, -0.5]]
		]);
		scale([1, -1])
			translate([-gearToothWidth * reciprocatorTeeth / 2, reciprocatorPinionInnerSize[1] / 2])
				polygon(teethPts);
		translate([-gearToothWidth * reciprocatorTeeth / 2, reciprocatorPinionInnerSize[1] / 2])
			polygon(teethPts);
	}
}

module reciprocatorHousingShape() {
	size = 2 * (reciprocatorPinionOuterSize - [0, reciprocatorRadius] +
		gearHousingSpace * [1, 1]);
	extra = reciprocatorPinFrameSize[0];
	translate(-size / 2)
		square(size + [extra, 0], center = false);
}

function reciprocatorAngleToDisplacement(angle) =
	let (a = (angle + 230) / 180)
	let (value = ((a > 0) ? a : 2 - (abs(a) % 2)) % 2)
	let (oscillator = (((value < 1) ? value : 2 - value) * 2 - 1) * 1.3)
	let (movement = (oscillator < -1) ? -1 : (oscillator > 1) ? 1 : oscillator)
	movement/2 * (reciprocatorRadius + gearOverlap/2) * PI / 2;
