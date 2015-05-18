include <../config.scad>
include <matrices.scad>

driveFrame = translation([driveGearRadius - driveGearExposed, cardSize[1] / 2]);

cloudFrames = 
	let (
		f1 =
			rotation(gearOrientations[0], [0, 0, 1]) *
				translation([driveGearRadius + gearRadii[0], 0, 0]),
		f2 =
			rotation(gearOrientations[1], [0, 0, 1]) *
				translation([gearRadii[0] + gearRadii[1], 0, 0]),
		f3 =
			rotation(gearOrientations[2], [0, 0, 1]) *
				translation([gearRadii[1] + gearRadii[2], 0, 0])
	)
	[driveFrame * f1, driveFrame * f1 * f2, driveFrame * f1 * f2 * f3];

cloudCorrections = 
	let (
		correction1 = gearOrientations[0],
		correction2 = gearOrientations[1] + gearOrientations[0],
		correction3 = gearOrientations[2] + gearOrientations[1] + gearOrientations[0]
	)
	-[correction1, correction2, correction3];
