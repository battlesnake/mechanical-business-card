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
plasticAlpha = 0.2;

/* Alpha multiplier for all layers */
alpha = materials ? 1 : 0.4;

/* Gear teeth count */
driveGearTeeth = 75;
annularGearTeeth = 72;
planetGearTeeth = 24;
sunGearTeeth = annularGearTeeth - 2 * planetGearTeeth;

/* How much of the drive gear to expose through the card's side */
driveGearExposed = 2;

/* Gear radii */
driveGearRadius = gearRadius(driveGearTeeth);
sunGearRadius = gearRadius(sunGearTeeth);
planetGearRadius = gearRadius(planetGearTeeth);
annularGearRadius = gearRadius(annularGearTeeth, annular = true);

/* Number of planets */
planetCount = 3;

/* Gear phase */
sunGearPhase = 3;
planetGearPhase = 0;
planetCarrierPhase = 0;
annularGearPhase = 0;

/* Gear rotation */
Nd = driveGearTeeth;
Ns = sunGearTeeth;
Np = planetGearTeeth;
Na = annularGearTeeth;

Wd = 100 * $t;
Ws = -Wd * Nd / Ns;
Wp = Ws * -Ns * Na / (Np * (Na + Ns));
Wc = Ws * Ns / (Na + Ns);
Wa = 0;

driveGearRotation = Wd;
sunGearRotation = Ws + sunGearPhase;
planetGearRotation = Wp + planetGearPhase;
planetCarrierRotation = Wc + planetCarrierPhase;
annularGearRotation = Wa + annularGearPhase;
