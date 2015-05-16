/* Defaults */

/* Width of tooth period */
gearToothWidth = 2;
/* Width of spokes */
gearSpokeWidth = 2;
/* Rim inner radius */
gearRimRadius = 3;
/* Central hub radius */
gearHubRadius = 3;
/* Central hole radius */
gearHoleRadius = 0.5;
/* How much the gears overlap */
gearOverlap = 1;
/* Extra space to leave in interlock space */
gearErrorSpace = 0.2;
/* Radius of gear space in housing is outer radius of gear plus this value */
gearHousingSpace = 0.5;

function flatten(l) = [for (a = l) for (b = a) b];

function gearRadius(numTeeth, annular = false) = numTeeth * gearToothWidth / (2 * PI);

module gearHousing(numTeeth, overlap = gearOverlap, housingSpace = gearHousingSpace) {
	circle(r = gearRadius(numTeeth) + overlap / 2 + housingSpace, center = true);
}

module gear(numTeeth, hubRadius = gearHubRadius, rimRadius = gearRimRadius, holeRadius = gearHoleRadius, spokes = 3, spokeWidth = gearSpokeWidth, annular = false, toothWidth = gearToothWidth, errorSpace = gearErrorSpace, overlap = gearOverlap) {
	intersection() {
		/* Teeth */
		radius = gearRadius(numTeeth, annular);
		toothAngle = 360 / numTeeth;
		teethDefs = flatten([for (i = [0:numTeeth-1]) [
			[i * toothAngle, 0],
			[(i + 2/6) * toothAngle, 0],
			[(i + 3/6) * toothAngle, 1],
			[(i + 5/6) * toothAngle, 1]
		]]);
		teethPts = [for (def = teethDefs)
			let (
				cs = cos(def[0]),
				sn = sin(def[0]),
				r = radius + [
					-overlap / 2 + (annular ? errorSpace : 0),
					overlap / 2 - (annular ? -errorSpace : errorSpace)
				][def[1]])
				[cs * r, sn * r]];
		polygon(teethPts);
		
		difference() {
			circle(r = radius + overlap / 2, center = true);
			/* Axle hole */
			if (holeRadius > 0) {
				circle(r = holeRadius, center = true);
			}
			/* Spokes and hub */
			if (spokes > 0) {
				difference() {
					circle(r = radius - rimRadius - overlap / 2, center = true);
					/* Hub */
					circle(r = hubRadius, center = true);
					/* Spokes */
					for (i = [0:1:spokes-1]) {
						rotate(i * 360 / spokes, [0, 0, 1]) {
							translate([0, -spokeWidth / 2]) {
								square([radius, spokeWidth]);
							}
						}
					}
				}
			}
		}
	}
}
