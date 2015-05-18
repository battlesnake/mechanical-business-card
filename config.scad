include <generators/gear.scad>

/* Details */
myName = "Mark K Cowan";
myPhone = "(phone number here)";
myEmail = "mark@battlesnake.co.uk";
myPerk1 = "Physicist";
myPerk2 = "Coder";
myPerk3 = "Designer";
myPerk4 = "Hacker";

/* Card dimensions */
cardSize = [80, 53];
cornerRadius = 3;
cornerHoleRadius = 0.5;

/* Thickness of thin and of thick layers */
thin = 0.25;
thick = 0.5;

/* Extra distance between layers for exploded view */
explode = 10;

/* Use material colours */
materials = false;
metalColor = "silver";
plasticColor = "aqua";
plasticAlpha = 0.1;

/* Alpha multiplier for all layers */
alpha = materials ? 1 : 0.4;

/* Gear teeth count */
driveGearTeeth = 24;
gearTeeth = [45, 24, 32];

/* Gear orientations (relative to previous gear) */
gearOrientations = [20, -60, 80];

/* Gear rotation */
Wd = 1000 * $t;
driveGearRotation = Wd;

gearRotations =
	let (W1 = -Wd * driveGearTeeth / gearTeeth[0])
	let (W2 = -W1 * gearTeeth[0] / gearTeeth[1])
	let (W3 = -W2 * gearTeeth[1] / gearTeeth[2])
	[W1, W2, W3];

reciprocatorTeeth = 2;
reciprocatorFullTeeth = reciprocatorTeeth * 4;
reciprocatorTeethPitch = 1;
reciprocatorRadius = gearRadius(reciprocatorFullTeeth);
reciprocatorInnerRadius = reciprocatorRadius - reciprocatorTeethPitch;
reciprocatorOuterRadius = reciprocatorRadius + reciprocatorTeethPitch;

reciprocatorPinionThickness = 3;
reciprocatorPinionInnerSize =
	let (reciprocatorPinionHeight = reciprocatorInnerRadius * 2)
	let (reciprocatorPinionWidth = reciprocatorPinionHeight * 2.8)
	[reciprocatorPinionWidth, reciprocatorPinionHeight];
reciprocatorPinionOuterSize = reciprocatorPinionInnerSize + reciprocatorPinionThickness * [2, 2];
reciprocatorRounding = 1/2;

reciprocatorPinSize = [4, 0.5];
reciprocatorPinFrameSize = [6, 4];
reciprocatorPinOffset = [
	(reciprocatorPinionInnerSize[0] + reciprocatorPinFrameSize[0]) / 2,
	0
];

/* How much of the drive gear to expose through the card's side */
driveGearExposed = 2;

/* Gear radii */
driveGearRadius = gearRadius(driveGearTeeth);
gearRadii = [for (teeth = gearTeeth) gearRadius(teeth)];

driveGearAxleRadius = 2;
axleRadius = 1;

cloudSize = [12, 8];
